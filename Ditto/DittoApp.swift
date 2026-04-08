//
//  DittoApp.swift
//  Ditto
//
//  Created by Shyamprakash A on 06/04/26.
//
import SwiftUI

@main
struct DittoApp: App {
    
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if appState.isLoggedIn {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(appState)
        }
    }
}
