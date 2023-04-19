//
//  UserPresentationObject.swift
//  SwitChat
//
//  Created by Max Ward on 05/04/2023.
//

import Foundation

struct UserPresentationObject: Codable, Identifiable {
    
    let id: String
    let email: String
    let username: String?
    let photo: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.photo = try container.decodeIfPresent(String.self, forKey: .photo)
    }
    
    init(id: String, email: String, username: String?, photo: String?) {
        self.id = id
        self.email = email
        self.username = username
        self.photo = photo
    }
}


extension UserPresentationObject: Hashable {
    
}

extension UserPresentationObject {
    func toFirebaseScheme() -> UserSchemeObject {
        return UserSchemeObject(email: self.email,
                                username: self.username,
                                photo: self.photo)
    }
    
}

extension UserSchemeObject {
    func toUserPresentation() -> UserPresentationObject {
        return UserPresentationObject(id: self.id ?? "",
                                      email: self.email,
                                      username: self.username,
                                      photo: self.photo)
    }
}
