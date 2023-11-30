//
// iExpense
//


import SwiftUI


struct AddExpenseView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 10.0

    // TODO: could be an enum
    let types = ["Business", "Personal"]

    var expenses: Expenses

    @Environment(\.dismiss) var dismiss


    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            } // Form
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let newExpense = ExpenseItem(
                        name: name, type: type, amount: amount)
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

