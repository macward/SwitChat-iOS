//
//  UserRepositoryFirebase.swift
//  SwitChat
//
//  Created by Max Ward on 18/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserRepositoryFirebase: UserRepository {
    
    private var firestore = FirebaseManager.shared.collection(.users)
    
    func me() async throws -> UserPresentationObject? {
        guard let user = FirebaseAuthManager.shared.currentAuthUser() else { throw NSError() }
        let document = try await firestore.document(user.uid).getDocument()
        let userScheme = try document.data(as: UserSchemeObject.self)
        return userScheme.toUserPresentation()
    }
    
    func allUsers() async throws -> [UserPresentationObject] {
        do {
            let response = try await firestore.getDocuments()
            return try response.documents.map { try $0.data(as: UserSchemeObject.self).toUserPresentation() }
        } catch let error {
            throw error
        }
    }
    
    func createUser(from presentationObject: UserPresentationObject) async throws {
        
        try firestore.document(presentationObject.id)
            .setData(from: presentationObject.toFirebaseScheme())
        
    }
}
