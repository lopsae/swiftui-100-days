//
// iExpense
//


import Observation


struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}


@Observable
class Expenses {
    var items: [ExpenseItem] = []
}

