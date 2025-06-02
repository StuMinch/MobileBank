//
//  TransferView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/28/24.
//
import SwiftUI

struct AccountBalances: Codable, Identifiable, Equatable {
    let id = UUID()
    var name: String
    var balance: Double
}

struct TransferView: View {
    @State private var accounts: [AccountBalances] = []
    @State private var fromAccountID: UUID? = nil
    @State private var toAccountID: UUID? = nil
    @State private var amount: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            Form {
                Picker("From Account", selection: $fromAccountID) {
                    ForEach(accounts) { account in
                        Text(account.name).tag(account.id as UUID?)
                    }
                }
                Picker("To Account", selection: $toAccountID) {
                    ForEach(accounts) { account in
                        Text(account.name).tag(account.id as UUID?)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button("Transfer") {
                    performTransfer()
                }
                .disabled(fromAccountID == nil || toAccountID == nil || amount.isEmpty)
            }
            .navigationTitle("Transfer Funds")
            .onAppear(perform: loadAccounts)
        }
    }

    func loadAccounts() {
        let jsonURL = Bundle.main.url(forResource: "accounts", withExtension: "json")
        guard let url = jsonURL else {
            errorMessage = "Could not find accounts.json file."
            return
        }
        do {
            let data = try Data(contentsOf: url)
            accounts = try JSONDecoder().decode([AccountBalances].self, from: data)
        } catch {
            errorMessage = "Failed to load accounts: \(error.localizedDescription)"
        }
    }

    func performTransfer() {
        guard let fromAccountID = fromAccountID, let toAccountID = toAccountID,
              let transferAmount = Double(amount), transferAmount > 0 else {
            errorMessage = "Invalid input. Please check your entries."
            return
        }

        if fromAccountID == toAccountID {
            errorMessage = "Cannot transfer to the same account."
            return
        }

        if let fromIndex = accounts.firstIndex(where: { $0.id == fromAccountID }),
           let toIndex = accounts.firstIndex(where: { $0.id == toAccountID }) {
            if accounts[fromIndex].balance >= transferAmount {
                accounts[fromIndex].balance -= transferAmount
                accounts[toIndex].balance += transferAmount
                errorMessage = nil
                saveAccounts()
            } else {
                errorMessage = "Insufficient funds in the 'From' account."
            }
        }
    }

    func saveAccounts() {
        let jsonURL = Bundle.main.url(forResource: "accounts", withExtension: "json")
        guard let url = jsonURL else {
            errorMessage = "Could not find accounts.json file."
            return
        }
        do {
            let data = try JSONEncoder().encode(accounts)
            try data.write(to: url)
        } catch {
            errorMessage = "Failed to save accounts: \(error.localizedDescription)"
        }
    }
}
