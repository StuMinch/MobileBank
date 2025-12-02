//
//  HomeView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int
    // Access the shared account data
    @Environment(AccountManager.self) var accountManager
    
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)
    
    var body: some View {
        NavigationView {
            List {
                // Total Balance View
                VStack(spacing: 8) {
                    Text("Total Balance")
                        .font(.headline)
                        .foregroundColor(.gray)
                    // Use manager's calculated property
                    Text(accountManager.totalBalance, format: .currency(code: "USD"))
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(primaryBankColor)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                // Quick Actions
                VStack(alignment: .leading) {
                    Text("Quick Actions")
                        .font(.headline)
                    QuickActionsBar(selectedTab: $selectedTab)
                }
                .listRowSeparator(.hidden)

                // Accounts List
                Section(header: Text("My Accounts")) {
                    // Use manager's accounts
                    ForEach(accountManager.accounts) { account in
                        AccountRow(account: account, primaryColor: primaryBankColor)
                    }
                }
            }
            .navigationTitle("Welcome Back")
            .listStyle(.insetGrouped)
        }
    }
}

// MARK: - HOME SUB-VIEWS

struct QuickActionsBar: View {
    // ACCEPT THE BINDING
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                // ACTION: Set selectedTab to 2 (Transfer Tab Index)
                QuickActionButton(icon: "arrow.up.arrow.down", text: "Transfer", action: {
                    selectedTab = 2 // <--- NAVIGATION LOGIC HERE
                })
                QuickActionButton(icon: "dollarsign.circle", text: "Pay Bill", action: {})
                QuickActionButton(icon: "camera.fill", text: "Deposit", action: {})
                QuickActionButton(icon: "chart.bar.fill", text: "Budget", action: {})
            }
            .padding(.vertical, 10)
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let text: String
    // ADD ACTION CLOSURE
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 50, height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                Text(text)
                    .font(.caption)
            }
        }
        .buttonStyle(.plain)
    }
}

struct AccountRow: View {
    // CORRECTED TYPE: singular Account
    let account: Account
    let primaryColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: account.type == "Checking" ? "creditcard.and.123" : "banknote.fill")
                .foregroundColor(primaryColor)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(account.name)
                    .font(.headline)
                Text(account.type)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(account.balance, format: .currency(code: "USD"))
                .font(.title3.weight(.semibold))
        }
    }
}
