//
//  MessageBubbleView.swift
//  SwitChat
//
//  Created by Max Ward on 16/04/2023.
//

import SwiftUI

protocol MessageBubbleProtocol {
    var content: String { get }
}

struct MessageBubbleView: View {
    
    var message: MessageBubbleProtocol
    var ownerCell: Bool = true
    
    init(message: MessageBubbleProtocol, ownerCell: Bool) {
        self.message = message
        self.ownerCell = ownerCell
    }
    
    var body: some View {
        HStack {
            // if message sender its ownwer
            // show this spacer
            if ownerCell {
                Spacer()
            }
            
            HStack{
                Text(message.content)
                    .font(.system(size: 18))
                    .foregroundColor(ownerCell ? .white : .black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(ownerCell ? Color("Blue1") : Color.white)
            .cornerRadius(14)
            .overlay (alignment: ownerCell ? .bottomTrailing : .bottomLeading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(ownerCell ? Color("Blue1") : Color.white)
                    .frame(width: 14, height: 20)
            }
            
            // if message recipient is the owner
            // show this spacer
            if !ownerCell {
                Spacer()
            }
        }
    }
}
