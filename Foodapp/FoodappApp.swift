//
//  FoodappApp.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-05-07.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct FoodappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//Initializing Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}




