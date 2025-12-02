//
//  TransferView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//
import SwiftUI

struct TransferView: View {
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)
    @State private var sourceAccountIndex = 0
    @State private var destinationAccountIndex = 1
    @State private var amountString: String = "100.00"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transfer Details")) {
                    Picker("From Account", selection: $sourceAccountIndex) {
                        ForEach(MockData.accounts.indices, id: \.self) { index in
                            Text(MockData.accounts[index].name)
                        }
                    }
                    
                    Picker("To Account", selection: $destinationAccountIndex) {
                        ForEach(MockData.accounts.indices, id: \.self) { index in
                            Text(MockData.accounts[index].name)
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
                
                Button(action: {
                    // Action: Simulate Transfer (prototype)
                    print("Transferring $\(amountString) from \(MockData.accounts[sourceAccountIndex].name) to \(MockData.accounts[destinationAccountIndex].name)")
                }) {
                    Text("Confirm Transfer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(primaryBankColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                
                Text("Note: This is a demonstration prototype. No actual funds will be transferred.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .navigationTitle("Funds Transfer")
        }
    }
}
