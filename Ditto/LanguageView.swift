//
//  LanguageView.swift
//  Ditto
//
//  Created by Shyamprakash A on 08/04/26.
//

import SwiftUI

struct LanguageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedLang = "English (US)"
    let languages = ["English (US)", "English (UK)", "Hindi", "Tamil", "French"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(languages, id: \.self) { lang in
                        Button(action: { selectedLang = lang }) {
                            HStack {
                                Text(lang).foregroundColor(.white)
                                Spacer()
                                if selectedLang == lang {
                                    Image(systemName: "checkmark").foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                        }
                        if lang != languages.last { Divider().background(Color.gray.opacity(0.3)) }
                    }
                }
                .cornerRadius(16)
                .padding()
            }
        }
        .navigationTitle("Language")
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
