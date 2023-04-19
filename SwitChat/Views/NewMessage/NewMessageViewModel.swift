//
//  NewMessageViewModel.swift
//  SwitChat
//
//  Created by Max Ward on 16/04/2023.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    
    @Published var users: [UserPresentationObject] = []
    @Published var errorMessage: String = ""
    @Published var showErrorMessage: Bool = false
    @Published var isLoading: Bool = false
    
    private var repository: UserRepositoryFirebase = UserRepositoryFirebase()
    
    @MainActor
    func getAllUsers() async {
        do {
            self.isLoading.toggle()
            self.users = try await repository.allUsers()
            self.isLoading.toggle()
        } catch (let error) {
            self.showErrorMessage.toggle()
            self.errorMessage = error.localizedDescription
            self.isLoading.toggle()
        }
    }
    
    
}
