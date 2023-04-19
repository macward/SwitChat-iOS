//
//  MessagesView.swift
//  SwitChat
//
//  Created by Max Ward on 12/04/2023.
//

import SwiftUI

extension MessageScheme: MessageBubbleProtocol {}

struct MessagesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: MessagesViewModel
    @State private var shouldPresentLogOutOptions: Bool = false
    
    init(viewModel: MessagesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            MessagesNavigationBar(user: viewModel.recipientUser)
            ScrollView {
                ScrollViewReader { proxy in
                    VStack {
                        ForEach(viewModel.chatMessages) { message in
                            MessageCell(message: message)
                        }
                        Rectangle()
                            .fill(Color("Light2").opacity(0.9))
                            .frame(width: 200, height: 10)
                            .padding(.top, 20)
                            .opacity(0.0)
                        EmptyView()
                            .frame(width: 200, height: 10)
                            .padding(.top, 20)
                            .id("Empty")
                        
                    }
                    .onReceive(viewModel.$messageCount) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo("Empty", anchor: .bottom)
                        }
                    }
                }
            }
            .background(Color("Light2").opacity(0.9))
            HStack {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 24))
                    .foregroundColor(Color("Light3"))
                TextField("Description", text: $viewModel.messageContent)
                
                Button {
                    viewModel.handleSend()
                } label: {
                    Text("Send")
                        .foregroundColor(Color.white)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color("Blue1"))
                .cornerRadius(8)
            }
            .padding()
        }
        //.navigationTitle(viewModel.userChat?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
        .toolbarBackground(Color("Light1"), for: .navigationBar)
        .task {
            await self.viewModel.fetchMessages()
        }
        .onDisappear() {
            self.viewModel.messageStream.removeListener()
            self.viewModel.chatMessages.removeAll()
        }
    }
    
    @ViewBuilder
    func MessageCell(message: MessageScheme) -> some View {
        VStack {
            if message.sender == FirebaseAuthManager.shared.currentAuthUser()?.uid {
                MessageBubbleView(message: message, ownerCell: true)
            } else {
                MessageBubbleView(message: message, ownerCell: false)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
}
