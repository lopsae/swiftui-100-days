//
// iExpense
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            let expenses = Expenses(storage: UserDefaults.standard)
            ExpensesView(expenses: expenses)
        }
    }
}
