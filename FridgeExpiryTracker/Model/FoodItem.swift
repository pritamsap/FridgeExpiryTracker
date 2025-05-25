//
//  FoodItem.swift
//  FridgeExpiryTracker
//
//  Created by pritam on 2025-05-24.
//

import Foundation


struct FoodItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var expiryDate: Date
}
