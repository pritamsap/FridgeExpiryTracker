//
//  FridgeViewModel.swift
//  FridgeExpiryTracker
//
//  Created by pritam on 2025-05-24.
//

import Foundation
import SwiftUI


@Observable
class FridgeViewModel {
    var items: [FoodItem] = []
    
    var newName = ""
    var newDate = Date()
    
    @AppStorage("savedItems") @ObservationIgnored private var savedData: Data = Data()

    
    
    // Functions
    func sortedItems() -> [FoodItem] {
        items.sorted { $0.expiryDate < $1.expiryDate }
    }
   
    func addItem() {
        let newItem = FoodItem(name: newName, expiryDate: newDate)
        items.append(newItem)
        newName = ""
        newDate = Date()
        saveItems()
    }
    
    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            savedData = encoded
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveItems()
    }
    
    func loadItems() {
        if let decoded = try? JSONDecoder().decode([FoodItem].self, from: savedData) {
            items = decoded
        }
    }
    
    func containsItems() -> Bool {
        if items.isEmpty {
            return false
        }
        return true
    }
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }
    
   
}
