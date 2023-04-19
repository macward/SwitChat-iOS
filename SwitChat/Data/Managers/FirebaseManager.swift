//
//  FirebaseManager.swift
//  SwitChat
//
//  Created by Max Ward on 11/04/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class FirebaseManager {
    
    enum FirestoreCollection: String {
        case users
        case chats
        case recentMessages = "recent_messages"
    }
    
    var auth: Auth
    var firestore: Firestore
    
    static let shared = FirebaseManager()
    
    init() {
        
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true

        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.firestore.settings = settings
    }
    
    func collection(_ collection: FirestoreCollection) -> CollectionReference {
        return self.firestore.collection(collection.rawValue)
    }
}
