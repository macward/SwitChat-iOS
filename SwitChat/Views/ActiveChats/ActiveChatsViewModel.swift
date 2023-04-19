//
//  ActiveChatsViewModel.swift
//  SwitChat
//
//  Created by Max Ward on 11/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ActiveChatsViewModel: ObservableObject {

    @Published var user: UserPresentationObject?
    @Published var activeChats: [RecentMessageScheme] = []
    @Published var isLoading: Bool = false
    private var chatViewModel: MessagesViewModel = MessagesViewModel(recipient: nil,
                                                                     sender: nil)
    private var chatRepository: ChatRepository = .init()
    private var userRepository: UserRepository = UserRepositoryFirebase()
    var asyncMessage: AsyncMessageStream = .init()
    var appState: AppState?
    private func resetData() {
        self.asyncMessage.removeListener()
        self.activeChats.removeAll()
    }
    
    func setAppState(_ appState: AppState) {
        self.appState = appState
    }
    
    @MainActor
    func loadData() async {
        self.isLoading.toggle()
        do {
            self.user = try await userRepository.me() // this should be a global user
            self.isLoading.toggle()
        } catch (let error) {
            print(error.localizedDescription)
            self.isLoading.toggle()
        }
        await self.recentMessages()
    }
    
    @MainActor
    func recentMessages() async {
        self.resetData()
        do {
            for try await message in asyncMessage.listenForActiveChats() {
                
                let docId = message.id
                
                if let index = activeChats.firstIndex(where: { rm in
                    return rm.id == docId
                }) {
                    self.activeChats.remove(at: index)
                }
                self.activeChats.insert(message, at: 0)
            }
        } catch {
            fatalError()
        }
    }
    
    func configureChatViewModel(chat: RecentMessageScheme) {
        let uid = self.user?.id == chat.fromId ? chat.toId : chat.fromId
        let chatUser = UserPresentationObject(id: uid,
                                              email: chat.email,
                                              username: "",
                                              photo: chat.photo)
        self.chatViewModel.recipientUser = chatUser
        self.chatViewModel.sender = self.user
    }
    
    func setUserToChat(user: UserPresentationObject) {
        self.chatViewModel.recipientUser = user
        self.chatViewModel.sender = self.user
    }
    
    func getChatViewModel() -> MessagesViewModel {
        return self.chatViewModel
    }
    
    func closeSession() {
        do {
            try FirebaseAuthManager.shared.destroySession()
        } catch {
            fatalError()
        }
    }
}
