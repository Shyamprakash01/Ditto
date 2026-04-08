//
//  NotificationsView.swift
//  Ditto
//
//  Created by Shyamprakash A on 08/04/26.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var pushEnabled = true
    @State private var emailEnabled = false
    @State private var activityEnabled = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    notificationSection(title: "ALERTS") {
                        ToggleView(title: "Push Notifications", isOn: $pushEnabled, icon: "bell.badge.fill")
                        divider()
                        ToggleView(title: "Email Notifications", isOn: $emailEnabled, icon: "envelope.fill")
                    }
                    
                    notificationSection(title: "ACTIVITY") {
                        ToggleView(title: "Portfolio Updates", isOn: $activityEnabled, icon: "chart.line.uptrend.xyaxis")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Notifications")
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
    
    func notificationSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).foregroundColor(.gray).font(.caption).padding(.leading, 5)
            VStack(spacing: 0) { content() }.background(Color.white.opacity(0.05)).cornerRadius(16)
        }
    }
    
    func divider() -> some View { Divider().background(Color.gray.opacity(0.3)).padding(.horizontal) }
}
