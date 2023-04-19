//
//  AuthenticateRepositoryFirebase.swift
//  SwitChat
//
//  Created by Max Ward on 18/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthenticateRepositoryFirebase: AuthenticateRepository {
    
    private var firebase = FirebaseManager.shared.auth
    
    func login(email: String, password: String) async throws {
        try await firebase.signIn(withEmail: email, password: password)
    }
    
    func logout() async throws {
        try firebase.signOut()
    }
    
    func createAccount(email: String, password: String) async throws {
        try await firebase.createUser(withEmail: email, password: password)
    }
    
}
