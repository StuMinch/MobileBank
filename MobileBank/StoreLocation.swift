//
//  StoreLocation.swift
//  MobileBank
//
//  Created by Stuart Minchington on 5/14/25.
//


import Foundation
import CoreLocation

struct StoreLocation: Identifiable, Codable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
