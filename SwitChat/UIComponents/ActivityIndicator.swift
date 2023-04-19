//
//  ActivityIndicator.swift
//  SwitChat
//
//  Created by Max Ward on 05/04/2023.
//

import SwiftUI

struct ActivityIndicatorModifier: ViewModifier {
    
    var isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack(alignment: .center) {
                    Color(.systemBackground)
                        .ignoresSafeArea()
                        .opacity(0.8)
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.gray)
                        .scaleEffect(3.0)
                }
                .opacity(isLoading ? 1 : 0)
            }
  }
}

extension View {
    func activityIndicator(isLoading: Bool) -> some View {
        return modifier(ActivityIndicatorModifier(isLoading: isLoading))
    }
}
