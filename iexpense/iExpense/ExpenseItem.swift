//
// iExpense
//


import Foundation


struct ExpenseItem: Identifiable, Codable {

    private(set) var id = UUID()

    let name: String
    let type: String
    let amount: Double

}

