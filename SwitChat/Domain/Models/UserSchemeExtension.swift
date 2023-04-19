//
//  UserSchemeExtension.swift
//  SwitChat
//
//  Created by Max Ward on 12/04/2023.
//

import Foundation

extension UserSchemeObject {
    static func instance(from presentationObject: UserPresentationObject) -> UserSchemeObject {
        return UserSchemeObject(email: presentationObject.email,
                                username: presentationObject.username,
                                photo: presentationObject.photo)
    }
}

