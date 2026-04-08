//
//  WatchlistView.swift
//  Ditto
//
//  Created by Shyamprakash A on 07/04/26.
//

import SwiftUI

//////////////////////////////////////////////////////////////
// MARK: - MODEL
//////////////////////////////////////////////////////////////

struct Stock: Identifiable, Codable, Equatable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let change: String = "+1.25%" // Mock data for UI
}

//////////////////////////////////////////////////////////////
// MARK: - VIEW MODEL
//////////////////////////////////////////////////////////////

class WatchlistViewModel: ObservableObject {
    @Published var watchlists: [String: [Stock]] = [
        "Tech Favorites": [],
        "Dividend": [],
        "Growth": []
    ]
    
    @Published var selected = "Tech Favorites"
    @Published var allStocks: [Stock] = [
        Stock(symbol: "AAPL", name: "Apple Inc.", price: 189.84),
        Stock(symbol: "MSFT", name: "Microsoft Corp.", price: 378.91),
        Stock(symbol: "GOOGL", name: "Alphabet Inc.", price: 141.80),
        Stock(symbol: "NVDA", name: "NVIDIA Corp.", price: 495.22),
        Stock(symbol: "TSLA", name: "Tesla Inc.", price: 248.50)
    ]
    
    @Published var filtered: [Stock] = []
    
    init() {
        filtered = allStocks
    }
    
    func toggle(_ stock: Stock) {
        var list = watchlists[selected] ?? []
        if list.contains(stock) {
            list.removeAll { $0 == stock }
        } else {
            list.append(stock)
        }
        watchlists[selected] = list
    }
    
    func isAdded(_ stock: Stock) -> Bool {
        watchlists[selected]?.contains(stock) ?? false
    }
    
    func currentStocks() -> [Stock] {
        watchlists[selected] ?? []
    }
    
    func search(_ text: String) {
        if text.isEmpty {
            filtered = allStocks
        } else {
            filtered = allStocks.filter {
                $0.symbol.lowercased().contains(text.lowercased()) ||
                $0.name.lowercased().contains(text.lowercased())
            }
        }
    }
    
    func addWatchlist() {
        let name = "Watchlist \(watchlists.count + 1)"
        watchlists[name] = []
        selected = name
    }
    
    func deleteWatchlist() {
        guard watchlists.count > 1 else { return }
        watchlists.removeValue(forKey: selected)
        selected = watchlists.keys.first ?? ""
    }
    
    func renameWatchlist(newName: String) {
        let trimmedName = newName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty, trimmedName != selected else { return }
        let stocks = watchlists[selected] ?? []
        watchlists.removeValue(forKey: selected)
        watchlists[trimmedName] = stocks
        selected = trimmedName
    }
}

//////////////////////////////////////////////////////////////
// MARK: - MAIN VIEW
//////////////////////////////////////////////////////////////

struct WatchlistView: View {
    @StateObject var vm = WatchlistViewModel()
    @State private var showSearch = false
    @State private var showRename = false
    @State private var newName = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    // HEADER
                    HStack {
                        Text("Watchlist")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button { showSearch = true } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        
                        // Action Menu (Rename/Delete)
                        Menu {
                            Button {
                                newName = vm.selected
                                showRename = true
                            } label: {
                                Label("Rename", systemImage: "pencil")
                            }
                            
                            Button(role: .destructive) {
                                vm.deleteWatchlist()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // WATCHLIST CARDS
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            // Sort keys so they don't jump around
                            ForEach(vm.watchlists.keys.sorted(), id: \.self) { key in
                                WatchlistCard(title: key, isSelected: vm.selected == key)
                                    .onTapGesture {
                                        withAnimation(.spring()) { vm.selected = key }
                                    }
                            }
                            
                            // Add List Button
                            Button { vm.addWatchlist() } label: {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .frame(width: 140, height: 160)
                                    .overlay(Image(systemName: "plus").foregroundColor(.blue))
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 10)
                    
                    // STOCK LIST AREA
                    if vm.currentStocks().isEmpty {
                        EmptyWatchlistState(showSearch: $showSearch)
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(vm.currentStocks()) { stock in
                                    StockRow(stock: stock)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                SearchView(vm: vm)
            }
            .alert("Rename Watchlist", isPresented: $showRename) {
                TextField("New Name", text: $newName)
                Button("Cancel", role: .cancel) { }
                Button("Save") { vm.renameWatchlist(newName: newName) }
            }
        }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - SUBVIEWS
//////////////////////////////////////////////////////////////

struct WatchlistCard: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(20)
            Spacer()
        }
        .frame(width: 140, height: 160)
        .background(isSelected ? Color.blue : Color(white: 0.12))
        .cornerRadius(24)
    }
}

struct EmptyWatchlistState: View {
    @Binding var showSearch: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Image(systemName: "eye")
                .font(.system(size: 50))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("No stocks yet")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Text("Search and add stocks to this watchlist")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Button {
                showSearch = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Stocks")
                }
                .fontWeight(.bold)
                .padding(.horizontal, 25)
                .padding(.vertical, 12)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.top, 10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct StockRow: View {
    let stock: Stock
    
    var body: some View {
        HStack(spacing: 15) {
            // Leading Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.15))
                    .frame(width: 48, height: 48)
                Text(String(stock.symbol.prefix(1)))
                    .foregroundColor(.white)
                    .bold()
            }
            
            // Name and Symbol
            VStack(alignment: .leading, spacing: 2) {
                Text(stock.symbol)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(stock.name)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Price and Change
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(stock.price, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(stock.change)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.2))
                    .foregroundColor(.green)
                    .cornerRadius(6)
            }
        }
        .padding()
        .background(Color(white: 0.08))
        .cornerRadius(18)
    }
}

struct SearchView: View {
    @ObservedObject var vm: WatchlistViewModel
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    List(vm.filtered) { stock in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(stock.symbol).foregroundColor(.white).bold()
                                Text(stock.name).foregroundColor(.gray).font(.caption)
                            }
                            Spacer()
                            Button {
                                vm.toggle(stock)
                            } label: {
                                Image(systemName: vm.isAdded(stock) ? "checkmark.circle.fill" : "plus.circle")
                                    .foregroundColor(vm.isAdded(stock) ? .green : .blue)
                                    .font(.title2)
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.05))
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Add Stocks")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search symbol or name")
            .onChange(of: text) { _, newValue in
                vm.search(newValue)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
