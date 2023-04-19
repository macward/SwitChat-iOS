//
//  NewMessageView.swift
//  SwitChat
//
//  Created by Max Ward on 12/04/2023.
//

import SwiftUI

struct NewMessageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let didSelectNewUser: (UserPresentationObject) -> ()
    
    @StateObject private var viewModel: NewMessageViewModel = NewMessageViewModel()
    
    var body: some View {
        
        VStack {
            ScrollView {
                ForEach(viewModel.users) { user in
                    Button {
                        didSelectNewUser(user)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack {
                            HStack(alignment: .top, spacing: 16) {
                                Image(user.photo ?? "22")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60)
                                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
                                Text(user.email)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.black)
                                    .padding(.top, 8)
                                
                                Spacer()
                            }
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .activityIndicator(isLoading: viewModel.isLoading)
        .task {
            await self.viewModel.getAllUsers()
        }
        .navigationTitle("New Message")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

