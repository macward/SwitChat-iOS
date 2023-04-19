//
//  SignInSignOutViewModel.swift
//  SwitChat
//
//  Created by Max Ward on 04/04/2023.
//

import Foundation
import Combine
import Firebase

class SignInSignUpViewModel: ObservableObject {
    
    enum ViewState {
        case SignIn
        case SignUp
    }
    
    @Published var email = "max@switchat.io"
    @Published var password = "pass1234"
    @Published private var cancellables = Set<AnyCancellable>()
    @Published var viewState: ViewState = .SignIn
    @Published var isLoading: Bool = false
    var appState: AppState?
    
    private var counter = 0
    private var db: Firestore
    
    private var repo: AuthenticateRepository
    private var userRepo: UserRepository = UserRepositoryFirebase()
    
    init(repository: AuthenticateRepository) {
        self.repo = repository
        self.db = Firestore.firestore()
    }

    func setAppStateReference(_ appState: AppState) {
        self.appState = appState
    }
    
    func didTapSignInButton() {
        
        Task {
            await MainActor.run(body: {
                self.isLoading.toggle()
            })
            if self.email.isValidEmail() {
                switch viewState {
                case .SignIn:
                    await self.makeLoginRequest()
                case .SignUp:
                    await makeCreateAccountRequest()
                }
            }
        }
    }
    
    @MainActor
    private func makeLoginRequest() async {
        do {
            try await self.repo.login(email: self.email, password: self.password)
            self.appState?.setView(.chats)
            self.isLoading.toggle()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    private func makeCreateAccountRequest() async {
        do {
            try await self.repo.createAccount(email: self.email, password: self.password)
            guard let user = FirebaseAuthManager.shared.currentAuthUser(), let userEmail = user.email else { return }
            let presentationObject = UserPresentationObject(id: user.uid,
                                                            email: userEmail,
                                                            username: "",
                                                            photo: "")
            try await self.userRepo.createUser(from: presentationObject)
            self.appState?.setView(.chats)
            self.isLoading = false
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
