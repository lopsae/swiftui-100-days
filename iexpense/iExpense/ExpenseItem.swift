//
// iExpense
//


import Foundation


struct ExpenseItem: Identifiable, Codable, Equatable {

    private(set) var id = UUID()

    let name: String
    let category: ExpenseCategory
    let amount: Double


    static func makePreviewExample(category: ExpenseCategory) -> ExpenseItem {
        let componentSet: Set = [Calendar.Component.minute, .nanosecond]
        let dateComponents = Calendar.current.dateComponents(componentSet, from: .now)
        let name = "\(category.display)-\(dateComponents.minute!).\(dateComponents.nanosecond! % 1000)"
        let amount = [200.0, 100, 75, 20, 5].randomElement()!
        return ExpenseItem(name: name, category: category, amount: amount)
    }

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

