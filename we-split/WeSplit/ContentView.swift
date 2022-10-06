//
//  WeSplit
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var peopleCount = 2
    @State private var tip = 20

    let tipOptions = [25, 20, 15, 10, 0]

    init() {

    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Check Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    Text("Plain: \(checkAmount)")
                    Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                Section {
                    Picker("Number of people", selection: $peopleCount) {
                        ForEach(2..<10, id: \.self) { Text("\($0) people") }
                    }
                    Text("Count: \(peopleCount)")
                }
                Section {

                    Picker("Tip %", selection: $tip) {
                        ForEach(tipOptions, id: \.self) { Text($0, format: .percent) }
                    }.pickerStyle(.segmented)
                    Text("Percentage: \(tip)")
                } header: { Text("Tip percentage") }
                Section {
                    Text("Grand total: \(grandTotal)")
                    Text("Per person: \(totalPerPerson)")
                } header: { Text("Totals") }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.large)
        } // NavigationView
    } // body


    var grandTotal: Double {
        let tipAmount: Double = checkAmount * Double(tip) / 100
        return checkAmount + tipAmount
    }

    var totalPerPerson: Double {
        return grandTotal / Double(peopleCount)
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
