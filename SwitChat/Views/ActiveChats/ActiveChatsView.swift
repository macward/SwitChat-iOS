//
//  ActiveChatsView.swift
//  SwitChat
//
//  Created by Max Ward on 04/04/2023.
//

import SwiftUI

struct ActiveChatsView: View {
    
    // Glabl and Environment Parameters
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState
    
    // View State Params
    @State private var shouldPresentLogOutOptions: Bool = false
    @State private var shouldPresentNewMessageView: Bool = false
    @State private var shouldNavigateToMessagesView: Bool = false
    
    // View Model
    @StateObject private var viewModel: ActiveChatsViewModel = ActiveChatsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                MainChatCustomNavigationView(user: appState.user, shouldShowLogOutOptions: $shouldPresentLogOutOptions)
                if viewModel.activeChats.count == 0 {
                    VStack {
                        Spacer()
                        Image("draw_empty_conversation")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .offset(y: -50)
                        Spacer()
                    }
                } else {
                    activeMessagesView
                }
                
            }
            .overlay(
                Button {
                    self.shouldPresentNewMessageView.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("+ New Message")
                            .padding()
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(32)
                    .padding(.horizontal)
                    .frame(maxWidth: 400)
                }, alignment: .bottom
            )
            .fullScreenCover(isPresented: $shouldPresentNewMessageView, content: {
                NavigationView {
                    NewMessageView { user in
                        self.viewModel.setUserToChat(user: user)
                        self.shouldNavigateToMessagesView.toggle()
                    }
                }
            })
            .navigationDestination(for: RecentMessageScheme.self, destination: { user in
                MessagesView(viewModel: self.viewModel.getChatViewModel())
            })
            .navigationDestination(isPresented: $shouldNavigateToMessagesView, destination: {
                MessagesView(viewModel: self.viewModel.getChatViewModel())
            })
            .actionSheet(isPresented: $shouldPresentLogOutOptions) {
                .init(title: Text("Settings"), message: Text("What do you want to do"), buttons: [
                    .destructive(Text("Sign out"), action: {
                        viewModel.closeSession()
                        appState.setView(.login)
                    }),
                    .cancel()
                ])
            }
            .activityIndicator(isLoading: viewModel.isLoading)
            
        }
        .navigationTitle("Users")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await self.viewModel.loadData()
        }
        .onDisappear() {
            self.viewModel.asyncMessage.removeListener()
        }
    }
    
    var activeMessagesView: some View {
        ScrollView {
            ForEach(viewModel.activeChats) { chat in
                Button {
                    self.viewModel.configureChatViewModel(chat: chat)
                    self.shouldNavigateToMessagesView.toggle()
                } label: {
                    ActiveChatCellView(message: chat)
                }

                
            }
            .padding(.bottom, 50)
        }
        .background()
    }
}
