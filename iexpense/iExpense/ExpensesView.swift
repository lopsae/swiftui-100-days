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
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.category.display)
                        }
                        Spacer()
                        Text(item.amount, format: .localCurrencyOrUsd())
                    }.expenseBackground(amount: item.amount)
                }
                .onDelete(perform: removeItems(at:))
            } // List
            .overlay {
                if (expenses.items.isEmpty) {
                    Text("No expenses recorded")
                } else {
                    EmptyView()
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button("Add Test") {
                    let componentSet: Set = [Calendar.Component.hour, .minute, .second, .nanosecond]
                    let dateComponents = Calendar.current.dateComponents(componentSet, from: .now)
                    let name = "Test-\(dateComponents.hour!)\(dateComponents.minute!)\(dateComponents.second!)\(dateComponents.nanosecond!)"
                    let newExpense = ExpenseItem(name: name, category: .personal, amount: 10.0)
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
        if expenses.items.count == 1 {
            // remove last one with animation to transition to overlay
            withAnimation {
                expenses.items.remove(atOffsets: offsets)
            }
        } else {
            expenses.items.remove(atOffsets: offsets)
        }

    }

}


#Preview("With items") {
    ExpensesView(expenses: Expenses.preview)
}


#Preview("Empty List") {
    ExpensesView(expenses: Expenses(items: []))
}

