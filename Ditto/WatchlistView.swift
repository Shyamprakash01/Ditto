//
//  WatchlistView.swift
//  Ditto
//
//  Created by Shyamprakash A on 07/04/26.
//
import SwiftUI

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let change: Double
}

struct WatchlistView: View {
    // Sample Data
    let categories = ["Tech Favorites", "Dividend", "Growth"]
    let stocks = [
        Stock(symbol: "AAPL", name: "Apple Inc.", price: 189.84, change: 1.25),
        Stock(symbol: "MSFT", name: "Microsoft Corp.", price: 378.91, change: -0.32),
        Stock(symbol: "GOOGL", name: "Alphabet Inc.", price: 141.80, change: 2.49),
        Stock(symbol: "NVDA", name: "NVIDIA Corp.", price: 495.22, change: 2.55)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Header
                    HStack {
                        Text("Watchlist")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                        Image(systemName: "ellipsis")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    
                    // MARK: - Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { category in
                                CategoryCard(title: category, isActive: category == "Tech Favorites")
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 160)
                    
                    // MARK: - Stock List
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(stocks) { stock in
                                StockRow(stock: stock)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            // MARK: - Bottom Tab Bar Simulation
            .safeAreaInset(edge: .bottom) {
                CustomTabBar()
            }
        }
    }
}

// MARK: - Supporting Views

struct CategoryCard: View {
    let title: String
    let isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(16)
            Spacer()
        }
        .frame(width: 140, height: 160, alignment: .topLeading)
        .background(isActive ? Color.blue : Color(white: 0.15))
        .cornerRadius(20)
    }
}

struct StockRow: View {
    let stock: Stock
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.15))
                    .frame(width: 50, height: 50)
                Text(String(stock.symbol.prefix(1)))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.symbol)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text(stock.name)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(String(format: "%.2f", stock.price))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(stock.change > 0 ? "▲" : "▼") \(String(format: "%.2f", abs(stock.change)))%")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(stock.change > 0 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .foregroundColor(stock.change > 0 ? .green : .red)
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(Color(white: 0.1))
        .cornerRadius(16)
    }
}

struct CustomTabBar: View {
    var body: some View {
        HStack {
            TabBarItem(icon: "house", label: "Home")
            TabBarItem(icon: "eye", label: "Watchlist", isSelected: true)
            TabBarItem(icon: "chart.pie", label: "Portfolio")
            TabBarItem(icon: "doc.text", label: "Orders")
            TabBarItem(icon: "person", label: "Profile")
        }
        .padding(.top, 10)
        .background(Color.black)
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(label)
                .font(.system(size: 10))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(isSelected ? .blue : .gray)
    }
}

//#Preview {
//    WatchlistView()
//}

//#Preview {
//    WatchlistView()
//}
