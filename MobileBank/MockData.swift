//
//  MockData.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//

import SwiftUI

// MARK: - MOCK DATA STRUCTURES

struct Accounts: Identifiable {
    let id = UUID()
    let name: String
    let balance: Double
    let type: String
}

struct Transaction: Identifiable {
    let id = UUID()
    let date: Date
    let vendor: String
    let amount: Double
    let categoryIcon: String // SF Symbol name
}

struct Card: Identifiable {
    let id = UUID()
    let lastFour: String
    let cardType: String
    let color: Color
}

// MARK: - GLOBAL MOCK DATA

struct MockData {
    static let accounts: [Accounts] = [
        Accounts(name: "Primary Checking", balance: 8450.78, type: "Checking"),
        Accounts(name: "High-Yield Savings", balance: 4000.00, type: "Savings"),
        Accounts(name: "Travel Fund", balance: 560.20, type: "Savings")
    ]

    static let totalBalance = accounts.reduce(0) { $0 + $1.balance }

    static let transactions: [Transaction] = [
        Transaction(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, vendor: "Starbucks", amount: -5.45, categoryIcon: "mug"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, vendor: "Amazon", amount: -49.99, categoryIcon: "cart.fill"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, vendor: "Monthly Rent", amount: -1500.00, categoryIcon: "house.fill"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, vendor: "Paycheck Deposit", amount: 2800.00, categoryIcon: "arrow.down.to.line"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, vendor: "Gym Membership", amount: -65.00, categoryIcon: "figure.walk"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, vendor: "Whole Foods", amount: -112.50, categoryIcon: "basket.fill")
    ]
    
    static let cards: [Card] = [
        Card(lastFour: "4567", cardType: "Visa Platinum", color: .blue),
        Card(lastFour: "9012", cardType: "Mastercard Debit", color: .purple),
        Card(lastFour: "3456", cardType: "Amex Rewards", color: .gray)
    ]
}
