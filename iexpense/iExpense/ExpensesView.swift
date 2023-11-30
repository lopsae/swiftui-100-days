//
// iExpense
//


import SwiftUI


struct ExpensesView: View {

    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems(at:))
            } // List
            .navigationTitle("Expenses")
            .toolbar {
                Button("Add Expense") {
                    let componentSet: Set = [Calendar.Component.hour, .minute, .second, .nanosecond]
                    let dateComponents = Calendar.current.dateComponents(componentSet, from: .now)
                    let name = "Test-\(dateComponents.hour!)\(dateComponents.minute!)\(dateComponents.second!)\(dateComponents.nanosecond!)"
                    let newExpense = ExpenseItem(name: name, type: "Personal", amount: 10.0)
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

