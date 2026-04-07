//
//  PortfolioView.swift
//  Ditto
//
//  Created by Shyamprakash A on 07/04/26.
//
import SwiftUI

struct PortfolioItem: Identifiable {
    let id = UUID()
    let author: String
    let initials: String
    let date: String
    let title: String
    let description: String
    let tickers: [String]
    let growth: String
    let likes: Int
    let comments: Int
}

struct PortfolioView: View {
    @State private var selectedTab = "Followed"
    
    let portfolios = [
        PortfolioItem(
            author: "Sarah Chen",
            initials: "SC",
            date: "2025-02-10",
            title: "Tech Growth Portfolio",
            description: "My curated tech growth portfolio focusing on AI and cloud computing leaders. These stocks have consistentl..",
            tickers: ["AAPL", "MSFT", "NVDA", "GOOGL"],
            growth: "+18.5%",
            likes: 234,
            comments: 2
        ),
        PortfolioItem(
            author: "David Kim",
            initials: "DK",
            date: "2025-02-01",
            title: "Consumer Staples Shield",
            description: "Recession-proof portfolio with consumer staples that perform well in any market condition.",
            tickers: ["WMT", "PG", "KO"],
            growth: "+5.7%",
            likes: 102,
            comments: 5
        )
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                HStack {
                    Text("Portfolio")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "tray")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // MARK: - Custom Segmented Picker
                HStack(spacing: 0) {
                    PickerButton(title: "Global", isSelected: selectedTab == "Global") {
                        selectedTab = "Global"
                    }
                    PickerButton(title: "Followed", isSelected: selectedTab == "Followed") {
                        selectedTab = "Followed"
                    }
                }
                .background(Color(white: 0.15))
                .cornerRadius(12)
                .padding()
                
                // MARK: - Scrollable Content
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(portfolios) { item in
                            PortfolioCard(item: item)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
       
    }
}

// MARK: - Subviews

struct PickerButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color.blue : Color.clear)
                .foregroundColor(isSelected ? .white : .gray)
                .cornerRadius(10)
        }
        .padding(4)
    }
}

struct PortfolioCard: View {
    let item: PortfolioItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User Info
            HStack(spacing: 12) {
                Circle()
                    .fill(Color(white: 0.2))
                    .frame(width: 40, height: 40)
                    .overlay(Text(item.initials).foregroundColor(.white).font(.system(size: 14, weight: .bold)))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.author)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Text(item.date)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            
            Text(item.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text(item.description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineLimit(3)
            
            // Tickers
            HStack(spacing: 8) {
                ForEach(item.tickers, id: \.self) { ticker in
                    Text(ticker)
                        .font(.system(size: 12, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.15))
                        .foregroundColor(.blue)
                        .cornerRadius(6)
                }
            }
            
            // Growth Badge
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text(item.growth)
            }
            .font(.system(size: 14, weight: .bold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.green.opacity(0.15))
            .foregroundColor(.green)
            .cornerRadius(8)
            
            Divider().background(Color.gray.opacity(0.3))
                .padding(.vertical, 4)
            
            // Social Actions
            HStack(spacing: 20) {
                Label("\(item.likes)", systemImage: "heart")
                Label("\(item.comments)", systemImage: "bubble.right")
                Spacer()
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .font(.system(size: 14))
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color(white: 0.12))
        .cornerRadius(20)
    }
}



struct BottomTabItem: View {
    let icon: String
    let label: String
    var isActive: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 22))
            Text(label)
                .font(.system(size: 10))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(isActive ? .blue : .gray)
    }
}

//struct PortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioView()
//    }
//}
