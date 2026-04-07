import SwiftUI

struct LoginView: View {
    
    @State private var userId = ""
    @State private var password = ""
    @State private var isSecure = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer()
                
                // Logo
                Image(systemName: "diamond.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(16)
                
                // Title
                Text("Ditto")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Invest. Share. Grow.")
                    .foregroundColor(.gray)
                
                Spacer().frame(height: 20)
                
                // User ID
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    
                    TextField("User ID", text: $userId)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(12)
                
                // Password
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    
                    if isSecure {
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                    } else {
                        TextField("Password", text: $password)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(12)
                
                // Sign In Button
                Button(action: {}) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                // Forgot Password
                Button("Forgot Password?") {}
                    .foregroundColor(.blue)
                
                // Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Text("or")
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                }
                
                // Login as User Button
                NavigationLink(destination: HomeView()) {
                    HStack {
                        Image(systemName: "bolt.fill")
                        Text("Login as User")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                
                // Register Navigation
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
