//
//  SecurityView.swift
//  Ditto
//
//  Created by Shyamprakash A on 08/04/26.
//

import SwiftUI

struct SecurityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isTwoFactorEnabled = false
    @State private var isFaceIDEnabled = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // LOGIN SECURITY
                    securitySection(title: "LOGIN SECURITY") {
                        NavigationLink(destination: Text("Change Password").foregroundColor(.white)) {
                            securityRow(title: "Change Password", icon: "key.fill")
                        }
                        divider()
                        ToggleView(title: "Two-Factor Authentication", isOn: $isTwoFactorEnabled, icon: "shield.lefthalf.filled")
                    }
                    
                    // BIOMETRICS
                    securitySection(title: "BIOMETRICS") {
                        ToggleView(title: "Use Face ID", isOn: $isFaceIDEnabled, icon: "faceid")
                    }
                    
                    // DEVICES
                    securitySection(title: "DEVICES") {
                        NavigationLink(destination: Text("Active Sessions").foregroundColor(.white)) {
                            securityRow(title: "Active Sessions", icon: "desktopcomputer")
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Security")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss() // ✅ Correctly pops back to SettingsView
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                        Text("Settings")
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    // MARK: - UI COMPONENTS
    func securitySection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).foregroundColor(.gray).font(.caption).padding(.leading, 5)
            VStack(spacing: 0) { content() }
                .background(Color.white.opacity(0.05))
                .cornerRadius(16)
        }
    }
    
    func securityRow(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon).foregroundColor(.blue).frame(width: 25)
            Text(title).foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.gray).font(.caption)
        }
        .padding()
    }
    
    func divider() -> some View {
        Divider().background(Color.gray.opacity(0.3)).padding(.horizontal)
    }
}

// MARK: - TOGGLE ROW COMPONENT
struct ToggleView: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundColor(.blue).frame(width: 25)
            Text(title).foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn).tint(.blue)
        }
        .padding()
    }
}
