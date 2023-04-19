//
//  MessagesViewModel.swift
//  SwitChat
//
//  Created by Max Ward on 16/04/2023.
//

import Foundation
import Firebase

class MessagesViewModel: ObservableObject {
    
    @Published var messageContent: String = ""
    @Published var chatMessages: [MessageScheme] = []
    @Published var recipientUser: UserPresentationObject?
    @Published var sender: UserPresentationObject?
    @Published var messageCount: Int = 0
    
    var firebaseListener: ListenerRegistration?
    
    private var chatRepository = ChatRepository()
    var messageStream = AsyncMessageStream()
    
    init(recipient: UserPresentationObject?, sender: UserPresentationObject?) {
        self.recipientUser = recipient
        self.sender = sender
        
    }
    
    func handleSend() {
        if messageContent == "" { return }
        guard let senderId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let recipientId = recipientUser?.id else { return }
        
        let message = MessageScheme(sender: senderId,
                                    receiver: recipientId,
                                    content: messageContent,
                                    timestamp: Timestamp())
        
        self.chatRepository.persistMessage(recipientId: recipientId, message: message)
        self.persistRecentMessage(message: message)
    }
    
    private func persistRecentMessage(message: MessageScheme) {
        guard let recipient = recipientUser, let sender = self.sender else { return }
        chatRepository.persistRecentMessage(sender: sender, recipientUser: recipient, message: message)
        self.messageContent = ""
        self.messageCount += 1
    }
    
    func fetchMessages() async {
        guard let recipient = recipientUser else { return }
        do {
            for try await message in messageStream.listenForMessages(recipientUser: recipient) {
                await MainActor.run {
                    self.chatMessages.append(message)
                    self.messageCount += 1
                }
            }
        } catch {
            print(error)
        }
    }
    
}
