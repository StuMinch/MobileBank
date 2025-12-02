//
//  TransactionsView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//

import SwiftUI

struct TransactionsView: View {
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Recent Activity")) {
                    ForEach(MockData.transactions) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
            }
            .navigationTitle("Activity")
            .listStyle(.insetGrouped)
        }
    }
}

// MARK: - TRANSACTION SUB-VIEWS

struct TransactionRow: View {
    let transaction: Transaction
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            Image(systemName: transaction.categoryIcon)
                .frame(width: 30, height: 30)
                .background(Color(.systemGray5))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(transaction.vendor)
                    .font(.headline)
                Text(TransactionRow.dateFormatter.string(from: transaction.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text(transaction.amount, format: .currency(code: "USD"))
                .font(.body.weight(.semibold))
                .foregroundColor(transaction.amount < 0 ? .primary : .green)
        }
    }
}
