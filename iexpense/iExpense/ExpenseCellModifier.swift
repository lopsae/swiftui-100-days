//
// iExpense
//


import SwiftUI


struct ExpenseCellModifier: ViewModifier {

    let amount: Double

    func body(content: Content) -> some View {
        if amount > 100 {
            return content
                .listRowBackground(Color.red)
        }
        if amount > 50 {
            return content
                .listRowBackground(Color.orange)
        }

        return content.listRowBackground(Color.white)
    }

}


extension View {

    func expenseBackground(amount: Double) -> some View {
        modifier(ExpenseCellModifier(amount: amount))
    }

}

