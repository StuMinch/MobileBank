//
//  AccountManager.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/2/25.
//

import SwiftUI
import Observation

@Observable
class AccountManager {
    var accounts: [Account] = [
        Account(name: "Primary Checking", balance: 8450.78, type: "Checking"),
        Account(name: "High-Yield Savings", balance: 4000.00, type: "Savings"),
        Account(name: "Travel Fund", balance: 560.20, type: "Savings")
    ]
    
    // 1. MAKE TRANSACTIONS MUTABLE AND OBSERVABLE
    var transactions: [Transaction] = [
        Transaction(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, vendor: "Starbucks", amount: -5.45, categoryIcon: "mug"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, vendor: "Amazon", amount: -49.99, categoryIcon: "cart.fill"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, vendor: "Monthly Rent", amount: -1500.00, categoryIcon: "house.fill"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, vendor: "Paycheck Deposit", amount: 2800.00, categoryIcon: "arrow.down.to.line"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, vendor: "Gym Membership", amount: -65.00, categoryIcon: "figure.walk"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, vendor: "Whole Foods", amount: -112.50, categoryIcon: "basket.fill")
    ].sorted(by: { $0.date > $1.date }) // Ensure sorting by date

    // Mock Cards remain static
    static let cards: [Card] = [
        Card(lastFour: "4567", cardType: "Visa Platinum", color: .blue),
        Card(lastFour: "9012", cardType: "Mastercard Debit", color: .purple),
        Card(lastFour: "3456", cardType: "Amex Rewards", color: .gray)
    ]
    
    var totalBalance: Double {
        accounts.reduce(0) { $0 + $1.balance }
    }
    
    // 2. ADD LOGIC TO RECORD A NEW TRANSACTION
    func logTransaction(vendor: String, amount: Double, icon: String) {
        let newTransaction = Transaction(date: Date(), vendor: vendor, amount: amount, categoryIcon: icon)
        // Insert new transaction at the beginning of the list
        transactions.insert(newTransaction, at: 0)
    }
    
    // MARK: - TRANSFER LOGIC
    
    func performTransfer(from sourceIndex: Int, to destinationIndex: Int, amount: Double) -> (success: Bool, message: String) {
        // Validation checks (same as before)
        guard sourceIndex != destinationIndex else {
            return (false, "Error: Cannot transfer funds to the same account.")
        }
        
        let sourceAccount = accounts[sourceIndex]
        guard amount > 0 && amount <= sourceAccount.balance else {
            return (false, "Error: Insufficient funds or invalid amount.")
        }
        
        // --- Execute Transfer ---
        
        // Decrease source balance
        accounts[sourceIndex].balance -= amount
        // Increase destination balance
        accounts[destinationIndex].balance += amount
        
        // 3. LOG THE TRANSFER TRANSACTIONS
        let destinationAccountName = accounts[destinationIndex].name
        
        // Log source transfer (negative amount)
        logTransaction(
            vendor: "Transfer from \(sourceAccount.name)",
            amount: -amount,
            icon: "arrow.up.right.circle.fill"
        )
        
        // Log destination transfer (positive amount)
        logTransaction(
            vendor: "Transfer to \(destinationAccountName)",
            amount: amount,
            icon: "arrow.down.left.circle.fill"
        )
        
        return (true, "Success! $\(String(format: "%.2f", amount)) transferred from \(sourceAccount.name) to \(destinationAccountName).")
    }
}
