//
//  MainChatCustomNavigationView.swift
//  SwitChat
//
//  Created by Max Ward on 12/04/2023.
//

import SwiftUI

struct MainChatCustomNavigationView: View {
    
    var user: UserPresentationObject?
    @Binding var shouldShowLogOutOptions: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            if user?.photo != nil {
                Image(user!.photo!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
                    .padding(.all, 8)
                    
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 28, weight: .heavy))
                    .frame(width: 50, height: 50)
                    .padding(.all, 8)
                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
            }
            
                
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
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 20, weight: .bold))
            }

        }
        .padding(.horizontal, 8)
    }
}

//struct MainChatCustomNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainChatCustomNavigationView()
//    }
//}
