//
//  AppState.swift
//  SwitChat
//
//  Created by Max Ward on 11/04/2023.
//

import SwiftUI

class AppState: ObservableObject {
    
    private var userRepository = UserRepositoryFirebase()
    
    enum CurrentView: Int {
        case login
        case chats
    }
    
    @AppStorage("scene") private var switchScene = CurrentView.login
    var user: UserPresentationObject? = nil
    
    var currentView: CurrentView {
        self.switchScene
    }
    
    @MainActor func setView(_ scene: CurrentView) {
        self.switchScene = scene
    }
    
    init() {
        let currentView: CurrentView = !FirebaseAuthManager.shared.isAuth() ? .login : .chats
        self.switchScene = currentView
        Task {
            await self.getAuthUserInfo()
        }
    }
    
    private func getAuthUserInfo() async{
        if !FirebaseAuthManager.shared.isAuth() { return }
        do {
            self.user = try await userRepository.me()
        } catch {
            try! FirebaseManager.shared.auth.signOut()
            self.switchScene = .login
        }
    }
}


