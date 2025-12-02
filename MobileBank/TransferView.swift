//
//  TransferView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//
import SwiftUI

struct TransferView: View {
    
    // Access the shared account data
    @Environment(AccountManager.self) var accountManager
    
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)
    
    @State private var sourceAccountIndex = 0
    @State private var destinationAccountIndex = 1
    @State private var amountString: String = ""
    
    // State for error/success feedback
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // Calculated property to check if the button should be enabled
    var isTransferValid: Bool {
        sourceAccountIndex != destinationAccountIndex &&
        Double(amountString) != nil &&
        (Double(amountString) ?? 0) > 0
    }
    
    func attemptTransfer() {
        let amount = Double(amountString) ?? 0.0
        
        let result = accountManager.performTransfer(
            from: sourceAccountIndex,
            to: destinationAccountIndex,
            amount: amount
        )
        
        alertTitle = result.success ? "Transfer Successful" : "Transfer Failed"
        alertMessage = result.message
        showingAlert = true
        
        // Clear amount on success
        if result.success {
            amountString = ""
            // Reset account selections to ensure user reviews next transfer
            sourceAccountIndex = 0
            destinationAccountIndex = 1
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transfer Details")) {
                    Picker("From Account", selection: $sourceAccountIndex) {
                        // Use manager's accounts
                        ForEach(accountManager.accounts.indices, id: \.self) { index in
                            Text("\(accountManager.accounts[index].name) (Bal: \(accountManager.accounts[index].balance, format: .currency(code: "USD")))")
                        }
                    }
                    
                    Picker("To Account", selection: $destinationAccountIndex) {
                        ForEach(accountManager.accounts.indices, id: \.self) { index in
                            Text(accountManager.accounts[index].name)
                        }
                    }
                    
                    HStack {
                        Text("Amount")
                        Spacer()
                        TextField("0.00", text: $amountString)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.title3.weight(.semibold))
                    }
                }
                
                Section {
                    Button(action: attemptTransfer) {
                        Text("Confirm Transfer")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isTransferValid ? primaryBankColor : Color(.systemGray4))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    // Disable button if validation fails
                    .disabled(!isTransferValid)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                
                Text("Note: This is a demonstration prototype. Transfers update mock balances only.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .navigationTitle("Funds Transfer")
            // Show alert for success/error
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}
