//
// iExpense
//


import Foundation


struct ExpenseItem: Identifiable, Codable, Equatable {

    private(set) var id = UUID()

    let name: String
    let category: ExpenseCategory
    let amount: Double

}


enum ExpenseCategory: Codable, CaseIterable {

    case personal
    case business

    var display: String {
        switch self {
        case .personal: return "Personal"
        case .business: return "Business"
        }
    }

}

