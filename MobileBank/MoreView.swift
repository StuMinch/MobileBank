//
//  MoreView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/28/24.
//
import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("Settings View")) {
                    Text("Settings")
                }
                // Add more options (profile, help, etc.)
            }
            .navigationTitle("More")
        }
    }
}
