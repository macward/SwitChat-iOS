//
//  MessagesNavigationBar.swift
//  SwitChat
//
//  Created by Max Ward on 19/04/2023.
//

import SwiftUI

struct MessagesNavigationBar: View {
    
    var user: UserPresentationObject?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack(spacing: 10) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
            }

            Image(user?.photo ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
                .padding(.all, 8)
            
                
            VStack(alignment: .leading) {
                Text(user?.email ?? "")
                    .font(.system(size: 18, weight: .medium))
                HStack {
                    
                    Circle()
                        .foregroundColor(Color.green)
                        .frame(width: 12, height: 12)
                    
                    Text("Online")
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
                .offset(y: -10)
            }
            Spacer()

        }
        .padding(.horizontal, 16)
    }
}

struct MessagesNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        MessagesNavigationBar(user: UserPresentationObject(id: "1",
                                                           email: "max@sample.com",
                                                           username: "user12312",
                                                           photo: "2"))
    }
}
