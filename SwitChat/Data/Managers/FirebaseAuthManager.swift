//
//  AuthManager.swift
//  SwitChat
//
//  Created by Max Ward on 04/04/2023.
//

import Foundation
import Firebase

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    private var auth: Auth = FirebaseManager.shared.auth
    
    func isAuth() -> Bool {
        
        if self.auth.currentUser == nil {
            return false
        }
        return true
    }
    
    func currentAuthUser() -> Firebase.User? {
        return self.auth.currentUser
    }
    
    func destroySession() throws {
        try auth.signOut()
    }
    
}

extension FirebaseAuthManager {
    var authorizedApiHeaders: [String: String] {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer"]
    }
}
