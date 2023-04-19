//
//  AppDelegate.swift
//  SwitChat
//
//  Created by Max Ward on 11/04/2023.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      let _ = FirebaseManager.shared

    return true
  }
}
