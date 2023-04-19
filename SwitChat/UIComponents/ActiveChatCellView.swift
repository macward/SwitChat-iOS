//
//  ActiveChatCellView.swift
//  SwitChat
//
//  Created by Max Ward on 12/04/2023.
//

import SwiftUI

struct ActiveChatCellView: View {
    
    var message: RecentMessageScheme
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                Image(message.photo)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(.gray, lineWidth: 1))
                VStack(alignment: .leading) {
                    Text(message.email)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.black)
                    Text(message.message)
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                }
                .padding(.top, 8)
                Spacer()
                VStack {
                    Spacer()
                    Text("22d")
                        .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("Light3"))
                    Spacer()
                }
            }
            Divider()
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

//struct ActiveChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveChatCellView()
//    }
//}
