//
//  RegisterView.swift
//  Ditto
//
//  Created by Shyamprakash A on 06/04/26.
//
import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Custom Back Button (WHITE)
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                
                // Title
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Personal Info")
                    .foregroundColor(.gray)
                
                // Step Indicator
                HStack(spacing: 20) {
                    stepCircle(icon: "person.fill", isActive: true)
                    stepLine()
                    stepCircle(icon: "shield.fill", isActive: false)
                    stepLine()
                    stepCircle(icon: "doc.fill", isActive: false)
                }
                .padding(.vertical)
                
                // Input Fields
                inputField(icon: "person", placeholder: "Full Name", text: $fullName)
                inputField(icon: "envelope", placeholder: "Email Address", text: $email)
                inputField(icon: "phone", placeholder: "Phone Number", text: $phone)
                
                // Continue Button
                Button(action: {}) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.top)
                
                // Bottom Text
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Sign In") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding()
        }
        // 🔥 IMPORTANT FIX
        .navigationBarBackButtonHidden(true)   // ❌ hides default blue back button
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Components

func inputField(icon: String, placeholder: String, text: Binding<String>) -> some View {
    HStack {
        Image(systemName: icon)
            .foregroundColor(.gray)
        
        TextField(placeholder, text: text)
            .foregroundColor(.white)
    }
    .padding()
    .background(Color.white.opacity(0.05))
    .cornerRadius(14)
}

func stepCircle(icon: String, isActive: Bool) -> some View {
    ZStack {
        Circle()
            .fill(isActive ? Color.blue : Color.gray.opacity(0.3))
            .frame(width: 40, height: 40)
        
        Image(systemName: icon)
            .foregroundColor(.white)
    }
}

func stepLine() -> some View {
    Rectangle()
        .fill(Color.gray.opacity(0.3))
        .frame(height: 2)
}

// Preview
//#Preview {
//    NavigationStack {
//        RegisterView()
//    }
//}
