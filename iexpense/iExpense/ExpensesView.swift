//
// iExpense
//


import SwiftUI


struct ExpensesView: View {

    @State private(set) var expenses: Expenses

    @State private var isAddExpensesVisible = false

    var body: some View {
        NavigationStack {
            List {
                // TODO: can a default element be added for empty lists?
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems(at:))
            } // List
            .navigationTitle("Expenses")
            .toolbar {
                Button("Add Test") {
                    let componentSet: Set = [Calendar.Component.hour, .minute, .second, .nanosecond]
                    let dateComponents = Calendar.current.dateComponents(componentSet, from: .now)
                    let name = "Test-\(dateComponents.hour!)\(dateComponents.minute!)\(dateComponents.second!)\(dateComponents.nanosecond!)"
                    let newExpense = ExpenseItem(name: name, type: "Personal", amount: 10.0)
                    expenses.items.append(newExpense)
                }
                Button("Add Expense", systemImage: "plus") {
                    isAddExpensesVisible = true
                }
            }
            .sheet(isPresented: $isAddExpensesVisible) {
                AddExpenseView(expenses: expenses)
            }
        } // NavigationStack
    } // body


    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}


#Preview {
    ExpensesView(expenses: Expenses(items: []))
}

