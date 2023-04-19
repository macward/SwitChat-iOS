//
//  AuthenticateRepository.swift
//  SwitChat
//
//  Created by Max Ward on 04/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class AsyncMessageStream {
    
    private var repository: ChatRepository = .init()
    private var listener: ListenerRegistration?
    
    func listenForMessages(recipientUser: UserPresentationObject) -> AsyncThrowingStream<MessageScheme, Error> {
        return AsyncThrowingStream { continuation in
            self.listener = repository.listenForNewMessage(recipientUser: recipientUser) { message in
                continuation.yield(message)
            }
        }
    }
    
    func listenForActiveChats() -> AsyncThrowingStream<RecentMessageScheme, Error> {
        return AsyncThrowingStream { continuation in
            self.listener = repository.listenForActiveChats(completion: { recentMessage in
                continuation.yield(recentMessage)
            })
        }
    }
    
    func removeListener() {
        listener?.remove()
    }
}
