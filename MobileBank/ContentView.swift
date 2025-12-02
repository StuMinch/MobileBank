//
//  ContentView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//
import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    // 1. Instantiate the observable manager
    @State private var accountManager = AccountManager()
    
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)

    var body: some View {
        TabView(selection: $selectedTab) {
            
            // 1. Home (Dashboard)
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            // 2. Transactions (Activity)
            TransactionsView()
                .tabItem {
                    Label("Activity", systemImage: "list.bullet.clipboard.fill")
                }
                .tag(1)

            // 3. Transfer
            TransferView()
                .tabItem {
                    Label("Transfer", systemImage: "arrow.left.arrow.right.circle.fill")
                }
                .tag(2)

            // 4. Cards
            CardsView()
                .tabItem {
                    Label("Cards", systemImage: "creditcard.fill")
                }
                .tag(3)

            // 5. More (Settings/Profile)
            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis.circle.fill")
                }
                .tag(4)
        }
        .accentColor(primaryBankColor)
        // 2. Inject the manager into the environment
        .environment(accountManager)
    }
}


struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

