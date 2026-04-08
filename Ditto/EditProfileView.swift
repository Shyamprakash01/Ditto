//
//  EditProfileView.swift
//  Ditto
//
//  Created by Shyamprakash A on 08/04/26.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var fullName: String = "Alex Morgan"
    @State private var bio: String = "Passionate investor. Tech enthusiast."
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Profile Image Placeholder
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 100, height: 100)
                    Image(systemName: "camera.fill")
                        .foregroundColor(.blue)
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Full Name")
                        .foregroundColor(.gray)
                        .font(.caption)
                    TextField("Name", text: $fullName)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    Text("Bio")
                        .foregroundColor(.gray)
                        .font(.caption)
                    TextEditor(text: $bio)
                        .frame(height: 100)
                        .padding(10)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Text("Save Changes")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss() // ✅ Pops back to SettingsView
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
}
