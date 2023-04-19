//
//  SignInSignOutView.swift
//  SwitChat
//
//  Created by Max Ward on 04/04/2023.
//

import SwiftUI

struct SignInSignUpView: View {
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))
    
    //App state properties
    @EnvironmentObject var appState: AppState
    @ObservedObject private var viewModel: SignInSignUpViewModel
    @State private var showPassword = false
    
    init(viewModel: SignInSignUpViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image("draw_key")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
            VStack(spacing: 8) {
                Text("Sign in to your account")
                    .font(.system(size: 24, weight: .medium))
                Text("Login with your email address and password")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            VStack(spacing: 24) {
                HStack {
                    Image(systemName: "envelope")
                        .font(.system(size: 14))
                        .foregroundColor(Color("Light3"))
                    TextField("Ingrese su texto aquí", text: $viewModel.email)
                        .foregroundColor(Color("Light3"))
                        .padding(.vertical, 16)
                }
                .padding(.leading, 16)
                .background(Color("Light1"))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("Light2"), lineWidth: 1)
                )
                
                HStack {
                    Image(systemName: "lock")
                        .font(.system(size: 14))
                        .foregroundColor(Color("Light3"))
                    TextField("Ingrese su texto aquí", text: $viewModel.password)
                        .foregroundColor(Color("Light3"))
                        .padding(.vertical, 16)
                }
                .padding(.leading, 16)
                .background(Color("Light1"))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("Light2"), lineWidth: 1)
                )
                
                Button(action: {
                    self.viewModel.didTapSignInButton()
                }) {
                    Spacer()
                    Text("Sign In")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color("Blue1"))
                .cornerRadius(50)
                .padding(.top, 50)
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
        .onAppear() {
            self.viewModel.setAppStateReference(self.appState)
        }
        .activityIndicator(isLoading: viewModel.isLoading)
    }
    
    
}

extension SignInSignUpView {
    static func build() -> SignInSignUpView {
        let viewModel = SignInSignUpViewModel(repository: AuthenticateRepositoryFirebase())
        return SignInSignUpView(viewModel: viewModel)
    }
}

//struct SignInSignOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInSignUpView.build()
//    }
//}
