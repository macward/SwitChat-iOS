//
//  DataServiceProtocols.swift
//  SwitChat
//
//  Created by Max Ward on 11/04/2023.
//

import Foundation

protocol AuthenticateDataService {
    func signup(email: String, password: String) async throws
    func login(email: String, password: String) async throws
    func logout() async throws
}

protocol UserDataService {
    func createNewUser(uid: String, scheme: UserSchemeObject) async throws
    func me() async throws -> UserSchemeObject
    func allUsers() async throws -> [UserSchemeObject]
}

protocol ChatDataService {
    func getActiveChats()
    func sendMessage(content: MessageScheme)
    func storeRecentMessage(content: RecentMessageScheme)
}
