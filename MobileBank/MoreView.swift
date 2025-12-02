//
//  MoreView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//
import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account")) {
                    NavigationLink(destination: Text("Profile Settings View")) {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    NavigationLink(destination: Text("Security Settings View")) {
                        Label("Security", systemImage: "lock.fill")
                    }
                    NavigationLink(destination: Text("Notifications View")) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                }
                
                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("Help Center View")) {
                        Label("Help & Support", systemImage: "questionmark.circle.fill")
                    }
                    NavigationLink(destination: Text("Legal Information View")) {
                        Label("Legal", systemImage: "doc.text.fill")
                    }
                }
                
                Section {
                    Button(role: .destructive) {
                        // Action: Simulate Logout
                        print("User Logged Out")
                    } label: {
                        HStack {
                            Spacer()
                            Text("Logout")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("More")
        }
    }
}
