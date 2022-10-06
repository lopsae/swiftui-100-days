//
//  WeSplit
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var peopleCount = 2
    @State private var tip = 20

    let tipOptions = [25, 20, 15, 10, 0]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Check Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    Text("Amount: \(checkAmount)")
                    Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
