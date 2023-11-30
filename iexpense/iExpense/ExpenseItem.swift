//
// iExpense
//


import Foundation
import Observation


struct ExpenseItem: Identifiable, Codable {

    private(set) var id = UUID()

    let name: String
    let type: String
    let amount: Double

}


@Observable
class Expenses {

    static let storageKey = "expenses.items"

    let storage: UserDefaults?

    var items: [ExpenseItem] {
        didSet {
            if let storage,
               let encoded = try? JSONEncoder().encode(items)
            {
                storage.set(encoded, forKey: Self.storageKey)
            }
        }
    }


    init(storage: UserDefaults) {
        self.storage = storage
        if let storedData = storage.data(forKey: Self.storageKey),
           let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: storedData)
        {
            items = decoded
        } else {
            items = []
        }
    }


    init(items: [ExpenseItem]) {
        self.storage = nil
        self.items = items
    }


    static var preview: Expenses {
        return Expenses(items: [
            .init(name: "Antique", type: "Personal", amount: 57.0),
            .init(name: "Bubbles", type: "Business", amount: 12.0),
            .init(name: "Chocolate", type: "Personal", amount: 10.0),
        ])
    }

}

