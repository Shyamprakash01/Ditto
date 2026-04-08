//
//  SettingsView.swift
//  Ditto
//
//  Created by Shanmugam N on 08/04/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss   // ✅ Back navigation
    
    @State private var showLogoutAlert = false
    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // ACCOUNT
                    section(title: "ACCOUNT") {
                        row(icon: "person", title: "Edit Profile")
                        divider()
                        row(icon: "shield", title: "Security")
                        divider()
                        row(icon: "bell", title: "Notifications")
                    }
                    
                    // PREFERENCES
                    section(title: "PREFERENCES") {
                        row(icon: "moon", title: "Appearance")
                        divider()
                        row(icon: "globe", title: "Language")
                        divider()
                        row(icon: "dollarsign", title: "Currency")
                    }
                    
                    // SUPPORT
                    section(title: "SUPPORT") {
                        row(icon: "questionmark.circle", title: "Help Center")
                        divider()
                        row(icon: "message", title: "Contact Us")
                        divider()
                        row(icon: "doc.text", title: "Terms of Service")
                        divider()
                        row(icon: "shield", title: "Privacy Policy")
                    }
                    
                    // LOGOUT
                    Button {
                        showLogoutAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "arrow.right.square")
                            Text("Logout")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.15))
                        .cornerRadius(12)
                    }
                    
                    Text("Ditto v1.0.0")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                .padding()
            }
        }
        
        // MARK: - NAV BAR
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        // DARK NAV FIX
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        
        // BACK BUTTON → PROFILE
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.white)
                }
            }
        }
        
        // LOGOUT ALERT
        .alert("Logout", isPresented: $showLogoutAlert) {
            
            Button("Cancel", role: .cancel) { }
            
            Button("Logout", role: .destructive) {
                dismiss()   // ✅ Also goes back to Profile (clean)
            }
            
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
    
    // MARK: - SECTION
    func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.gray)
                .font(.caption)
            
            VStack(spacing: 0) {
                content()
            }
            .background(Color.white.opacity(0.05))
            .cornerRadius(16)
        }
    }
    
    // MARK: - ROW
    func row(icon: String, title: String) -> some View {
        HStack(spacing: 15) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .foregroundColor(.blue)
            }
            
            Text(title)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    // MARK: - DIVIDER
    func divider() -> some View {
        Divider()
            .background(Color.gray.opacity(0.3))
    }
}
//#Preview {
//    SettingsView()
//}
