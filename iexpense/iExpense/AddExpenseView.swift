//
// iExpense
//


import SwiftUI


struct AddExpenseView: View {
    
    @State private var name = ""
    @State private var category: ExpenseCategory = .personal
    @State private var amount = 10.0

    var expenses: Expenses

    @Environment(\.dismiss) var dismiss


    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(ExpenseCategory.allCases, id: \.self) {
                        Text($0.display)
                    }
                }
                TextField("Amount", value: $amount, format: .localCurrencyOrUsd())
                    .keyboardType(.decimalPad)
            } // Form
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let newExpense = ExpenseItem(
                        name: name, category: category, amount: amount)
                    expenses.items.append(newExpense)
                    dismiss()
                }
            }
        } // NavigationStack
    }
}


#Preview {
    AddExpenseView(expenses: Expenses(items: []))
}

