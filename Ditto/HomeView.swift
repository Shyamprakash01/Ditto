//
//  HomeView.swift
//  Ditto
//
//  Created by Shyamprakash A on 07/04/26.
//

import SwiftUI

struct HomeView: View {
    
    // 🔥 Fix Tab Bar Color
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.shadowColor = .clear
        
        UITabBar.appearance().standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View {
        TabView {
            
            // HOME
            NavigationStack {
                HomeContentView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            // WATCHLIST
            NavigationStack {
                WatchlistView()
            }
            .tabItem {
                Image(systemName: "eye")
                Text("Watchlist")
            }
            
            // PORTFOLIO
            NavigationStack {
                PortfolioView()
            }
            .tabItem {
                Image(systemName: "chart.pie")
                Text("Portfolio")
            }
            
            // ORDERS
            NavigationStack {
                OrdersView()
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text("Orders")
            }
            
            // PROFILE
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
        .accentColor(.blue)
    }
}

//////////////////////////////////////////////////////////////
// MARK: - HOME CONTENT
//////////////////////////////////////////////////////////////

struct HomeContentView: View {
    
    @State private var showSheet = false
    @State private var selectedStock: (symbol: String, name: String) = ("", "")
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // HEADER
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .overlay(Text("A").foregroundColor(.white))
                            
                            VStack(alignment: .leading) {
                                Text("Welcome back")
                                    .foregroundColor(.gray)
                                Text("Alex Morgan")
                                    .foregroundColor(.white)
                                    .font(.title2.bold())
                            }
                            
                            Spacer()
                            
                            Image(systemName: "bell")
                                .foregroundColor(.white)
                        }
                    }
                    // INVESTMENT CARD
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Total Investment")
                            .foregroundColor(.gray)
                        
                        Text("$13.45K")
                            .foregroundColor(.white)
                            .font(.system(size: 34, weight: .bold))
                        
                        Text("+$400.80 (2.98%)")
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.4), Color.black],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    
                    // QUICK ACTIONS
                    Text("Quick Actions")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                    
                    HStack(spacing: 20) {
                        actionItem(icon: "magnifyingglass", title: "Search")
                        actionItem(icon: "plus", title: "Buy")
                        actionItem(icon: "chart.line.uptrend.xyaxis", title: "Markets")
//                        actionItem(icon: "eye", title: "Watchlist")
                     
                        actionItem(icon: "wallet.pass", title: "Wallet")
                    }
                    
                    // SECTOR ALLOCATION
                    Text("Sector Allocation")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                    
                    VStack(spacing: 12) {
                        colorBar
                        
                        sectorRow(color: .blue, title: "Technology", value: "$6.96K")
                        sectorRow(color: .green, title: "Energy", value: "$2.20K")
                        sectorRow(color: .orange, title: "Healthcare", value: "$1.92K")
                        sectorRow(color: .red, title: "Consumer", value: "$1.19K")
                        sectorRow(color: .purple, title: "Finance", value: "$1.19K")
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(20)
                    
                    // TOP HOLDINGS
                    Text("Top Holdings")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                    
                    VStack(spacing: 12) {
                        
                        Button {
                            selectedStock = ("AAPL", "Apple Inc.")
                            showSheet = true
                        } label: {
                            stockRow(symbol: "AAPL", name: "Apple Inc.", price: "$189.84", gain: "+8.2%")
                        }
                        
                        Button {
                            selectedStock = ("MSFT", "Microsoft Corp.")
                            showSheet = true
                        } label: {
                            stockRow(symbol: "MSFT", name: "Microsoft Corp.", price: "$378.91", gain: "+3.8%")
                        }
                        
                        Button {
                            selectedStock = ("GOOGL", "Alphabet Inc.")
                            showSheet = true
                        } label: {
                            stockRow(symbol: "GOOGL", name: "Alphabet Inc.", price: "$141.80", gain: "+4.9%")
                        }
                    }
                }
                .padding()
            }
        }
        
        // 🔥 BOTTOM SHEET (HOVER STYLE)
        .sheet(isPresented: $showSheet) {
            TopHoldingsView(
                symbol: selectedStock.symbol,
                name: selectedStock.name
            )
            .presentationDetents([.fraction(0.75), .large]) // ✅ 75% FIXED
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(30)
        }
        .navigationBarHidden(true)
    }
}

//////////////////////////////////////////////////////////////
// MARK: - COMPONENTS
//////////////////////////////////////////////////////////////

func actionItem(icon: String, title: String) -> some View {
    VStack {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue.opacity(0.2))
                .frame(width: 60, height: 60)
            
            Image(systemName: icon)
                .foregroundColor(.blue)
        }
        
        Text(title)
            .foregroundColor(.gray)
            .font(.caption)
    }
}

var colorBar: some View {
    HStack(spacing: 5) {
        Capsule().fill(Color.blue).frame(height: 6)
        Capsule().fill(Color.green).frame(width: 40, height: 6)
        Capsule().fill(Color.orange).frame(width: 30, height: 6)
        Capsule().fill(Color.red).frame(width: 25, height: 6)
        Capsule().fill(Color.purple).frame(width: 25, height: 6)
    }
}

func sectorRow(color: Color, title: String, value: String) -> some View {
    HStack {
        Circle().fill(color).frame(width: 10, height: 10)
        Text(title).foregroundColor(.white)
        Spacer()
        Text(value).foregroundColor(.white).bold()
    }
}

func stockRow(symbol: String, name: String, price: String, gain: String) -> some View {
    HStack {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.2))
            .frame(width: 50, height: 50)
            .overlay(Text(String(symbol.prefix(1))).foregroundColor(.white))
        
        VStack(alignment: .leading) {
            Text(symbol).foregroundColor(.white).bold()
            Text(name).foregroundColor(.gray).font(.caption)
        }
        
        Spacer()
        
        VStack(alignment: .trailing) {
            Text(price).foregroundColor(.white)
            Text(gain).foregroundColor(.green).font(.caption)
        }
    }
    .padding()
    .background(Color.white.opacity(0.05))
    .cornerRadius(16)
}
