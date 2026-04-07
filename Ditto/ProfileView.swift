//
//  ProfileView.swift
//  Ditto
//
//  Created by Shyamprakash A on 07/04/26.
//

import SwiftUI

// MARK: - Models
struct UserPortfolio: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let growth: String
    let tickers: [String]
}

// MARK: - Profile View
struct ProfileView: View {
    let portfolios = [
        UserPortfolio(
            title: "Tech Growth Portfolio",
            description: "My curated tech growth portfolio focusing on AI and cl...",
            growth: "+18.5%",
            tickers: ["AAPL", "MSFT", "NVDA", "GOOGL"]
        ),
        UserPortfolio(
            title: "Dividend Champions",
            description: "Blue-chip dividend stocks for steady passive income. Focus ...",
            growth: "+8.2%",
            tickers: ["JNJ", "PG", "KO", "JPM"]
        )
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Navigation Bar
                HStack {
                    Image(systemName: "wallet.pass")
                    Spacer()
                    Text("Profile")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Image(systemName: "gearshape")
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        
                        // MARK: - User Header
                        VStack(spacing: 15) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Text("A")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            VStack(spacing: 8) {
                                Text("Alex Morgan")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Passionate investor. Tech enthusiast.\nBuilding wealth one stock at a time.")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                            }
                        }
                        .padding(.top, 20)
                        
                        // MARK: - Stats Card
                        HStack(spacing: 0) {
                            StatBox(value: "3", label: "Followers")
                            Divider().background(Color.gray.opacity(0.5)).frame(height: 40)
                            StatBox(value: "3", label: "Following")
                            Divider().background(Color.gray.opacity(0.5)).frame(height: 40)
                            StatBox(value: "1", label: "Requests")
                        }
                        .padding(.vertical, 20)
                        .background(Color(white: 0.12))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        // MARK: - Portfolio Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("My Portfolios")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            ForEach(portfolios) { portfolio in
                                ProfilePortfolioCard(portfolio: portfolio)
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct StatBox: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfilePortfolioCard: View {
    let portfolio: UserPortfolio
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Text(portfolio.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(portfolio.growth)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.15))
                    .foregroundColor(.green)
                    .cornerRadius(8)
            }
            
            Text(portfolio.description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineLimit(2)
            
            HStack(spacing: 8) {
                ForEach(portfolio.tickers, id: \.self) { ticker in
                    Text(ticker)
                        .font(.system(size: 12, weight: .bold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.12))
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(white: 0.12))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}


