//
//  FundsView.swift
//  Ditto
//
//  Created by Shyamprakash A on 09/04/26.
//

import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let amount: Double
    let isPositive: Bool
}

struct FundsView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - State for Balance and Popups
    @State private var totalBalance: Double = 25370.50
    @State private var showAmountPopup = false
    @State private var popupMode: PopupMode = .deposit
    @State private var inputAmount: String = ""
    
    // MARK: - Transaction History
    @State private var transactions = [
        Transaction(name: "Deposit", date: "Feb 15, 2025", amount: 5000.00, isPositive: true),
        Transaction(name: "AAPL x10", date: "Feb 14, 2025", amount: 1755.00, isPositive: false),
        Transaction(name: "Deposit", date: "Feb 10, 2025", amount: 10000.00, isPositive: true),
        Transaction(name: "NVDA x3", date: "Feb 8, 2025", amount: 1350.00, isPositive: false)
    ]
    
    enum PopupMode {
        case deposit, withdraw
        var title: String { self == .deposit ? "Deposit" : "Withdraw" }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Text("Funds")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // MARK: - Wallet Balance Card
                        VStack(spacing: 15) {
                            Image(systemName: "wallet.pass.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                            
                            VStack(spacing: 5) {
                                Text("Wallet Balance")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16))
                                Text("$\(totalBalance, specifier: "%.2f")")
                                    .foregroundColor(.white)
                                    .font(.system(size: 42, weight: .bold))
                            }
                            
                            HStack(spacing: 15) {
                                // Deposit Button
                                Button(action: {
                                    popupMode = .deposit
                                    inputAmount = ""
                                    showAmountPopup = true
                                }) {
                                    Label("Deposit", systemImage: "plus")
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 15)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                
                                // Withdraw Button
                                Button(action: {
                                    popupMode = .withdraw
                                    inputAmount = ""
                                    showAmountPopup = true
                                }) {
                                    Label("Withdraw", systemImage: "arrow.up")
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 15)
                                        .background(Color.black)
                                        .foregroundColor(.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue, lineWidth: 1))
                                }
                            }
                        }
                        .padding(20)
                        .background(Color(white: 0.12))
                        .cornerRadius(20)
                        
                        // MARK: - Bank Account Section
                        Text("Bank Account")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)).frame(width: 45, height: 45)
                                Image(systemName: "building.columns.fill").foregroundColor(.blue)
                            }
                            VStack(alignment: .leading) {
                                Text("Primary Bank Account").foregroundColor(.white).fontWeight(.bold)
                                Text("Account ending in ****4521").foregroundColor(.gray).font(.caption)
                            }
                            Spacer()
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                        }
                        .padding()
                        .background(Color(white: 0.12))
                        .cornerRadius(15)
                        
                        // MARK: - Recent Transactions
                        Text("Recent Transactions")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        VStack(spacing: 20) {
                            ForEach(transactions) { tx in
                                TransactionRow(tx: tx)
                                Divider().background(Color.gray.opacity(0.3))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // MARK: - Custom Input Popup
            if showAmountPopup {
                Color.black.opacity(0.6).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text(popupMode.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("$").font(.title).foregroundColor(.white)
                        TextField("0.00", text: $inputAmount)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(12)
                    
                    HStack(spacing: 15) {
                        Button("Cancel") {
                            showAmountPopup = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        
                        Button(popupMode.title) {
                            handleTransaction()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(25)
                .background(Color(white: 0.15))
                .cornerRadius(25)
                .frame(width: 320)
                .transition(.scale)
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Logic
    private func handleTransaction() {
        guard let amount = Double(inputAmount), amount > 0 else { return }
        
        if popupMode == .deposit {
            totalBalance += amount
            transactions.insert(Transaction(name: "Deposit", date: "Today", amount: amount, isPositive: true), at: 0)
        } else {
            if amount <= totalBalance {
                totalBalance -= amount
                transactions.insert(Transaction(name: "Withdrawal", date: "Today", amount: amount, isPositive: false), at: 0)
            }
        }
        showAmountPopup = false
    }
}

struct TransactionRow: View {
    let tx: Transaction
    var body: some View {
        HStack {
            ZStack {
                Circle().fill(tx.isPositive ? Color.green.opacity(0.15) : Color.red.opacity(0.15)).frame(width: 35, height: 35)
                Image(systemName: tx.isPositive ? "arrow.down" : "arrow.up")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(tx.isPositive ? .green : .red)
            }
            
            VStack(alignment: .leading) {
                Text(tx.name).foregroundColor(.white).fontWeight(.semibold)
                Text(tx.date).foregroundColor(.gray).font(.caption)
            }
            Spacer()
            Text("\(tx.isPositive ? "+" : "-")$\(String(format: "%.2f", tx.amount))")
                .foregroundColor(tx.isPositive ? .green : .red)
                .fontWeight(.bold)
        }
    }
}
