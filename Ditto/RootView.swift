//
//  RootView.swift
//  Ditto
//
//  Created by Shyamprakash A on 09/04/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
          
          var body: some View {
              Group {
                  if appState.isLoggedIn {
                      HomeView()
                  } else {
                      NavigationStack {   // ✅ ONLY for login flow
                          LoginView()
                      }
                  }
              }
          }
}

//#Preview {
//    RootView()
//}
