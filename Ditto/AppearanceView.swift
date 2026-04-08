//
//  AppearanceView.swift
//  Ditto
//
//  Created by Shyamprakash A on 08/04/26.
//

import SwiftUI

struct AppearanceView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTheme = "Dark"
    let themes = ["Light", "Dark", "System"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                VStack(spacing: 0) {
                    ForEach(themes, id: \.self) { theme in
                        Button(action: { selectedTheme = theme }) {
                            HStack {
                                Text(theme).foregroundColor(.white)
                                Spacer()
                                if selectedTheme == theme {
                                    Image(systemName: "checkmark").foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                        }
                        if theme != themes.last { Divider().background(Color.gray.opacity(0.3)) }
                    }
                }
                .cornerRadius(16)
                .padding()
                Spacer()
            }
        }
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                        Text("Settings")
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
