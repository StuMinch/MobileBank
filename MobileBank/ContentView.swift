//
//  ContentView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/28/24.
//
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
                TabView {
                    AccountOverviewView()
                        .tabItem {
                            Label("Overview", systemImage: "house")
                        }
                    TransferView()
                        .tabItem {
                            Label("Transfer", systemImage: "arrow.left.arrow.right")
                        }
                    DepositCheckView()
                        .tabItem {
                            Label("Deposit", systemImage: "camera")
                        }
                    MoreView() 
                        .tabItem {
                            Label("More", systemImage: "ellipsis")
                        }
                }
            }
        }
    }
