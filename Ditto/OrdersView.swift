//
//  OrdersView.swift
//  Ditto
//
//  Created by Shyamprakash A on 07/04/26.
//

import SwiftUI

// MARK: - Models
struct Order: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let quantity: Int
    let buyPrice: Double
    let currentPrice: Double
    let date: String
    
    var returnPercentage: Double {
        ((currentPrice - buyPrice) / buyPrice) * 100
    }
    
    var totalReturn: Double {
        (currentPrice - buyPrice) * Double(quantity)
    }
}

// MARK: - Orders View
struct OrdersView: View { // ✅ FIXED HERE
    
    let orders = [
        Order(symbol: "AMZN", name: "Amazon.com Inc.", quantity: 7, buyPrice: 170.00, currentPrice: 178.25, date: "2025-02-12"),
        Order(symbol: "NVDA", name: "NVIDIA Corp.", quantity: 3, buyPrice: 450.00, currentPrice: 495.22, date: "2025-02-10"),
        Order(symbol: "JPM", name: "JPMorgan Chase", quantity: 8, buyPrice: 148.30, currentPrice: 153.72, date: "2025-02-05")
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // HEADER
                HStack {
                    Text("Orders")
                        .font(.system(size: 34, weight: .bold))
                    
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title2)
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 10)
                
                ScrollView {
                    VStack(spacing: 16) {
                        
                        // SUMMARY CARD
                        SummaryHeaderView()
                        
                        // ORDERS LIST
                        ForEach(orders) { order in
                            OrderCardView(order: order)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - SUMMARY HEADER
struct SummaryHeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            SummaryColumn(label: "Invested", value: "$13,454.40", color: .white)
            
            Divider()
                .background(Color.gray.opacity(0.5))
                .frame(height: 30)
                .padding(.horizontal)
            
            SummaryColumn(label: "Current", value: "$13,855.20", color: .white)
            
            Divider()
                .background(Color.gray.opacity(0.5))
                .frame(height: 30)
                .padding(.horizontal)
            
            SummaryColumn(label: "Returns", value: "+$400.80", color: .green)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .background(Color(white: 0.12))
        .cornerRadius(16)
    }
}

// MARK: - SUMMARY COLUMN
struct SummaryColumn: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - ORDER CARD
struct OrderCardView: View {
    let order: Order
    
    var body: some View {
        VStack(spacing: 16) {
            
            // TOP ROW
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(white: 0.18))
                        .frame(width: 45, height: 45)
                    
                    Text(String(order.symbol.prefix(1)))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(order.symbol)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(order.name)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("BUY")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.15))
                    .foregroundColor(.green)
                    .cornerRadius(6)
            }
            
            // MIDDLE ROW
            HStack {
                StatItem(label: "Qty", value: "\(order.quantity)")
                Spacer()
                StatItem(label: "Buy Price", value: "$\(String(format: "%.2f", order.buyPrice))")
                Spacer()
                StatItem(label: "Current", value: "$\(String(format: "%.2f", order.currentPrice))")
                Spacer()
                StatItem(label: "Return", value: "+\(String(format: "%.1f", order.returnPercentage))%", color: .green)
            }
            
            Divider().background(Color.gray.opacity(0.2))
            
            // BOTTOM ROW
            HStack {
                Text(order.date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("+\(String(format: "$%.2f", order.totalReturn))")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(white: 0.12))
        .cornerRadius(16)
    }
}

// MARK: - STAT ITEM
struct StatItem: View {
    let label: String
    let value: String
    var color: Color = .white
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(color)
        }
    }
}
