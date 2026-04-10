import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState // ✅ REQUIRED for logout
    @State private var showLogoutAlert = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // ACCOUNT SECTION
                    section(title: "ACCOUNT") {
                        NavigationLink(destination: EditProfileView()) {
                            row(icon: "person", title: "Edit Profile")
                        }
                        divider()
                        NavigationLink(destination: SecurityView()) {
                            row(icon: "shield", title: "Security")
                        }
                        divider()
                        NavigationLink(destination: NotificationsView()) {
                            row(icon: "bell", title: "Notifications")
                        }
                    }
                    
                    // PREFERENCES
                    section(title: "PREFERENCES") {
                        NavigationLink(destination: AppearanceView()) {
                            row(icon: "moon", title: "Appearance")
                        }
                        divider()
                        NavigationLink(destination: LanguageView()) {
                            row(icon: "globe", title: "Language")
                        }
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
                    
                    // LOGOUT BUTTON
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
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        // NAV BAR STYLE
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        
        // CUSTOM BACK BUTTON
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss() // ✅ Only goes back to Profile
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.white)
                }
            }
        }
        
        .alert("Logout", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            
            Button("Logout", role: .destructive) {
                appState.isLoggedIn = false
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
    }

    // MARK: - UI HELPERS
    
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
    
    func divider() -> some View {
        Divider()
            .background(Color.gray.opacity(0.3))
            .padding(.horizontal)
    }
}
