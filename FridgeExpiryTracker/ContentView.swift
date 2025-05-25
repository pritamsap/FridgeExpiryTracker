//
//  ContentView.swift
//  FridgeExpiryTracker
//
//  Created by pritam on 2025-05-24.
//

import SwiftUI

struct ContentView: View {
    // State variable to manage app behavior
//    @AppStorage("savedItems") private var savedData: Data = Data() // Local Storage
//    @State private var items: [FoodItem] = []
//    
//    
//    @State private var newName = ""
//    @State private var newDate = Date()
    
    @State var viewModel = FridgeViewModel()
    @State private var FoodListTitle = ""
    
    var body: some View {
    
        NavigationView {
            VStack {
                // Input form to add new food item
                Form {
                    Section(header: Text("Add Food Item")) {
                        TextField("Food Name", text: $viewModel.newName)
                        DatePicker("ExpiryDate", selection: $viewModel.newDate, displayedComponents: .date)
                        
                        Button("Add Item") {
                            viewModel.addItem()
                        }.disabled(viewModel.newName.isEmpty)
                    }
                }
                
                
                // To Display list of food items added
                Text(viewModel.containsItems() == true ? "Food Item" : "")
                List {
                    ForEach(viewModel.sortedItems()) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .fontWeight(.bold)
                            Text("Expires: \(item.expiryDate, formatter: dateFormatter)").foregroundStyle(item.expiryDate < Date() ? .red : .secondary)
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
            }
            .navigationTitle("Fridge Food Tracker")
            .onAppear(perform: viewModel.loadItems)


        }
    }
    
//    
//    // Functions
//    func sortedItems() -> [FoodItem] {
//        items.sorted { $0.expiryDate < $1.expiryDate }
//    }
//    
//    // Add a new item to the list and save it
//    func addItem() {
//        let newItem = FoodItem(name: newName, expiryDate: newDate)
//        items.append(newItem)
//        newName = ""
//        newDate = Date()
//        saveItems()
//    }
//    
//    func deleteItem(at offsets: IndexSet) {
//        items.remove(atOffsets: offsets)
//        saveItems()
//    }
//    
//    func saveItems() {
//        if let encoded = try? JSONEncoder().encode(items) {
//            savedData = encoded
//        }
//    }
//    
//    func loadItems() {
//        if let decoded = try? JSONDecoder().decode([FoodItem].self, from: savedData) {
//            items = decoded
//        }
//    }
//    
//    func containsItems() -> Bool {
//        if items.isEmpty {
//            return false
//        }
//        return true
//    }
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }
}


#Preview {
    ContentView()
}


