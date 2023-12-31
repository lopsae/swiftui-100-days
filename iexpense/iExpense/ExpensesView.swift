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
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    let items = expenses.items.filter {
                        $0.category == category
                    }
                    ExpenseSection(category: category, items: items) { items in
                        removeExpenses(items)
                    }
                } // ForEach
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
                Button("Add P") {
                    let newExpense = ExpenseItem.makePreviewExample(category: .personal)
                    expenses.items.append(newExpense)
                }
                Button("Add B") {
                    let newExpense = ExpenseItem.makePreviewExample(category: .business)
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


    private var personalExpenses: [ExpenseItem] {
        expenses.items.filter {
            $0.category == .personal
        }
    }


    private var businessExpenses: [ExpenseItem] {
        expenses.items.filter {
            $0.category == .business
        }
    }


    private func removeExpenses(_ items: [ExpenseItem]) {
        var indexSet = IndexSet()
        for item in items {
            if let index = expenses.items.firstIndex(of: item) {
                indexSet.insert(index)
            }
        }

        guard !indexSet.isEmpty else { return }

        if expenses.items.count == indexSet.count {
            // remove last items with animation to transition to overlay
            withAnimation {
                expenses.items.remove(atOffsets: indexSet)
            }
        } else {
            expenses.items.remove(atOffsets: indexSet)
        }
    }

}


private struct ExpenseSection: View {

    let category: ExpenseCategory
    let items: [ExpenseItem]
    let onDelete: ([ExpenseItem]) -> Void

    var body: some View {
        Section(category.display) {
            ForEach(items) { item in
                ExpenseCell(item: item)
            }
            .onDelete { indexSet in
                var itemsToDelete: [ExpenseItem] = []
                itemsToDelete.reserveCapacity(indexSet.count)
                for index in indexSet {
                    itemsToDelete.append(items[index])
                }
                onDelete(itemsToDelete)
            }
        } // Section
    }

}


private struct ExpenseCell: View {

    let item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name).font(.headline)
                Text(item.category.display)
            }
            Spacer()
            Text(item.amount, format: .localCurrencyOrUsd())
        }.expenseBackground(amount: item.amount)
    }

}


#Preview("With items") {
    ExpensesView(expenses: Expenses.preview)
}


#Preview("Empty List") {
    ExpensesView(expenses: Expenses(items: []))
}

