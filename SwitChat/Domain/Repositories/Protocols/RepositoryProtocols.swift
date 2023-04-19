//
//  RepositoryProtocols.swift
//  SwitChat
//
//  Created by Max Ward on 05/04/2023.
//

import Foundation

protocol AuthenticateRepository {
    func login(email: String, password: String) async throws
    func logout() async throws
    func createAccount(email: String, password: String) async throws
}

protocol UserRepository {
    func me() async throws -> UserPresentationObject?
    func allUsers() async throws -> [UserPresentationObject]
    func createUser(from presentationObject: UserPresentationObject) async throws
}
