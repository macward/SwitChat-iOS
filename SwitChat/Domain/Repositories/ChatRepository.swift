//
//  ChatRepository.swift
//  SwitChat
//
//  Created by Max Ward on 18/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ChatRepository {
    
    var me: UserPresentationObject?
    
    init(me: UserPresentationObject? = nil) {
        self.me = me
    }
    
    func listenForActiveChats(completion: @escaping ((RecentMessageScheme) -> Void)) -> ListenerRegistration {
        
        guard let senderId = FirebaseManager.shared.auth.currentUser?.uid else { fatalError() }
        
        let collection = FirebaseManager.shared.collection(.recentMessages)
        
        let document = collection.document(senderId).collection("messages").order(by: "timestamp")
        
        
        return document.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                print(error)
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                
                do {
                    let recentMessage = try change.document.data(as: RecentMessageScheme.self)
                    print(recentMessage)
                    completion(recentMessage)
                } catch {
                    fatalError()
                }
    
            })
        }
    }
    
    func persistMessage(recipientId: String, message: MessageScheme) {
        guard let senderId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let senderDocument = FirebaseManager.shared.collection(.chats).document(senderId).collection(recipientId).document()
        let recipientDocument = FirebaseManager.shared.collection(.chats).document(recipientId).collection(senderId).document()
        
        Task {
            do {
                try senderDocument.setData(from: message)
                try recipientDocument.setData(from: message)
                
            } catch {
                print("error")
            }
        }
    }
    
    func persistRecentMessage(sender: UserPresentationObject, recipientUser: UserPresentationObject, message: MessageScheme) {
        
        let senderDocument = FirebaseManager.shared.collection(.recentMessages).document(sender.id).collection("messages").document(recipientUser.id)
        let recipientDocument = FirebaseManager.shared.collection(.recentMessages).document(recipientUser.id).collection("messages").document(sender.id)
        
        let recentMessageToMe: RecentMessageScheme = .init(email: recipientUser.email,
                                                           message: message.content,
                                                           fromId: sender.id,
                                                           toId: recipientUser.id,
                                                           photo: recipientUser.photo ?? "",
                                                           timestamp: message.timestamp)
        
        let recentMessageToRecipient: RecentMessageScheme = .init(email: sender.email,
                                                                  message: message.content,
                                                                  fromId: sender.id,
                                                                  toId: recipientUser.id,
                                                                  photo: sender.photo ?? "",
                                                                  timestamp: message.timestamp)
        
        do {
            try senderDocument.setData(from: recentMessageToMe)
            try recipientDocument.setData(from: recentMessageToRecipient)
        } catch {
            fatalError()
        }
    }
    
    func listenForNewMessage(recipientUser: UserPresentationObject,
                           completion: @escaping ((MessageScheme) -> Void)) -> ListenerRegistration {
        
        guard let sender = FirebaseManager.shared.auth.currentUser else { fatalError() }
        
        let document = FirebaseManager.shared.collection(.chats)
            .document(recipientUser.id).collection(sender.uid).order(by: "timestamp")
        
        return document.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error)
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = try! change.document.data(as: MessageScheme.self)
                    completion(data)
                }
            })
        }
    }
    
}
