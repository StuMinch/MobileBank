//
//  CardsView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/1/25.
//

import SwiftUI

struct CardsView: View {
    let primaryBankColor = Color(red: 0.0, green: 86.0/255.0, blue: 145.0/255.0)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Swipe to view your cards")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TabView {
                    ForEach(MockData.cards) { card in
                        MockCardView(card: card)
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 250)
                
                Spacer()
            }
            .navigationTitle("My Cards")
        }
    }
}

// MARK: - CARDS SUB-VIEWS

struct MockCardView: View {
    let card: Card
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(card.cardType)
                    .font(.title2.weight(.bold))
                Spacer()
                Image(systemName: "wifi")
            }
            Spacer()
            
            Text("**** **** **** \(card.lastFour)")
                .font(.title.monospaced())
            
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("Card Holder")
                        .font(.caption2)
                    Text("JANE DOE")
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "c.circle.fill")
                    .font(.largeTitle)
            }
        }
        .padding(25)
        .frame(maxWidth: .infinity)
        .background(card.color.opacity(0.85))
        .foregroundColor(.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}
