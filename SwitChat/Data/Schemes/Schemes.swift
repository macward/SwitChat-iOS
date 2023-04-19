//
//  UserSchemeObject.swift
//  SwitChat
//
//  Created by Max Ward on 05/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserSchemeObject: Codable {
    @DocumentID var id: String?
    let email: String
    let username: String?
    let photo: String?
}

struct MessageScheme: Codable, Identifiable {
    @DocumentID var id: String?
    var sender: String
    var receiver: String
    var content: String
    var timestamp: Timestamp
}

struct RecentMessageScheme: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var email: String
    var message: String
    var fromId: String
    var toId: String
    var photo: String
    var timestamp: Timestamp
}
