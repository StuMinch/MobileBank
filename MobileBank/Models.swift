//
//  Models.swift
//  MobileBank
//
//  Created by Stuart Minchington on 12/2/25.
//

import SwiftUI

// MARK: - STRUCT DEFINITIONS

struct Account: Identifiable {
    let id = UUID()
    let name: String
    var balance: Double // Must be 'var' now
    let type: String
}

struct Transaction: Identifiable {
    let id = UUID()
    let date: Date
    let vendor: String
    let amount: Double
    let categoryIcon: String
}

struct Card: Identifiable {
    let id = UUID()
    let lastFour: String
    let cardType: String
    let color: Color
}
