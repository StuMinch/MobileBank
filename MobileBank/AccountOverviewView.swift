//
//  AccountOverviewView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/28/24.
//

import SwiftUI

// Account Model (Decodable and Identifiable)
struct Account: Identifiable, Decodable {
    let id = UUID() // Auto-generated
    let name: String
    let balance: Double
}

// Mock Account Service
class MockAccountService {
    func getAccounts(completion: @escaping (Result<[Account], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let accounts = try decoder.decode([Account].self, from: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Simulate delay
                completion(.success(accounts))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

// Account Overview View
struct AccountOverviewView: View {
    @State private var accounts: [Account] = []
    let accountService = MockAccountService()

    // Preview initialization
    init(accounts: [Account] = []) {
        self._accounts = State(initialValue: accounts)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(accounts) { account in
                    Section(header: Text(account.name)) {
                        Text(String(format: "Balance: $%.2f", account.balance))
                    }
                }
            }
            .navigationTitle("Accounts")
            .onAppear {
                accountService.getAccounts { result in
                    switch result {
                    case .success(let accounts):
                        self.accounts = accounts
                    case .failure(let error):
                        print("Error loading accounts: \(error)")
                    }
                }
            }
        }
    }
}

struct AccountOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        AccountOverviewView()
    }
}
