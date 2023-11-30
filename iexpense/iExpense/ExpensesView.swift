//
// iExpense
//


import SwiftUI


struct ExpensesView: View {

    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems(at:))
            } // List
            .navigationTitle("Expenses")
            .toolbar {
                Button("Add Expense") {
                    let newExpense = ExpenseItem(name: "Test", type: "Personal", amount: 10.0)
                    expenses.items.append(newExpense)
                }
            }
        } // NavigationStack
    } // body


    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}


#Preview {
    ExpensesView()
}

