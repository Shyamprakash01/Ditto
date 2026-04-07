import SwiftUI

struct TopHoldingsView: View {
    let symbol: String
    let name: String
    
    @State private var showTransactionSheet = false
    @State private var transactionType: TransactionType = .buy
    @State private var quantity: String = ""
    
    enum TransactionType {
        case buy, sell
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - Stock Header
                    HStack(spacing: 15) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(white: 0.15))
                            .frame(width: 50, height: 50)
                            .overlay(Text(String(symbol.prefix(1))).foregroundColor(.white).bold())
                        
                        VStack(alignment: .leading) {
                            Text(symbol).font(.title.bold()).foregroundColor(.white)
                            Text(name).foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Price Info
                    VStack(alignment: .leading, spacing: 4) {
                        Text("$189.84")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("▲ +$2.34 (1.25%)")
                            .font(.subheadline.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.green.opacity(0.15))
                            .foregroundColor(.green)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Chart (Simplified Mock)
                    ChartMockView()
                        .frame(height: 200)
                        .padding(.vertical)
                    
                    // MARK: - Analytics Grid
                    Text("Analytics")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        AnalyticsCard(label: "Market Cap", value: "2.95T")
                        AnalyticsCard(label: "Sector", value: "Technology")
                        AnalyticsCard(label: "Day High", value: "$193.64")
                        AnalyticsCard(label: "Day Low", value: "$186.04")
                        AnalyticsCard(label: "52W High", value: "$237.30")
                        AnalyticsCard(label: "52W Low", value: "$132.89")
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Action Buttons
                    HStack(spacing: 15) {
                        Button(action: {
                            transactionType = .buy
                            showTransactionSheet = true
                        }) {
                            Text("Buy")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            transactionType = .sell
                            showTransactionSheet = true
                        }) {
                            Text("Sell")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        // MARK: - Transaction Sheet
        .sheet(isPresented: $showTransactionSheet) {
            TransactionSheet(type: transactionType, symbol: symbol)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Sub-Components

struct AnalyticsCard: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.caption).foregroundColor(.gray)
            Text(value).font(.headline).foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(white: 0.1))
        .cornerRadius(12)
    }
}

struct ChartMockView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLines([
                CGPoint(x: 50, y: 80), CGPoint(x: 100, y: 120),
                CGPoint(x: 150, y: 60), CGPoint(x: 200, y: 90),
                CGPoint(x: 250, y: 40), CGPoint(x: 300, y: 110),
                CGPoint(x: 400, y: 130)
            ])
        }
        .stroke(Color.green, lineWidth: 2)
    }
}

struct TransactionSheet: View {
    let type: TopHoldingsView.TransactionType
    let symbol: String
    @Environment(\.dismiss) var dismiss
    @State private var quantity = "0"
    
    var body: some View {
        ZStack {
            Color(white: 0.1).ignoresSafeArea()
            VStack(spacing: 25) {
                Text("\(type == .buy ? "Buy" : "Sell") \(symbol)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                HStack {
                    Text("Quantity").foregroundColor(.gray)
                    Spacer()
                    TextField("0", text: $quantity)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .frame(width: 100)
                }
                .padding()
                .background(Color(white: 0.15))
                .cornerRadius(12)
                
                Button(action: { dismiss() }) {
                    Text("Confirm \(type == .buy ? "Buy" : "Sell")")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(type == .buy ? Color.green : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button("Cancel") { dismiss() }
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}
