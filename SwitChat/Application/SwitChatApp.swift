//
//  SwitChatApp.swift
//  SwitChat
//
//  Created by Max Ward on 03/04/2023.
//

import SwiftUI
import Firebase

@main
struct SwitChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var appState = AppState()
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch (appState.currentView) {
                case .chats:
                    ActiveChatsView()
                        .environmentObject(appState)
                        .transition(transition)
                        .preferredColorScheme(.light)
                case .login:
                    SignInSignUpView.build()
                        .environmentObject(appState)
                        .transition(transition)
                        .preferredColorScheme(.light)
                }
            }
            .animation(.default, value: appState.currentView)
        }
    }
}
