//
//  WeSplit
//

import SwiftUI


struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var peopleCount = 2
    @State private var tip = 20

    let tipOptions = [25, 20, 15, 10, 0]

    @FocusState private var amountIsFocused: Bool

    init() {}

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .onReceive(UITextField.textDidBeginEditingNotification.publisher()) {
                            notification in
                            guard let textField = notification.object as? UITextField else { return }
                            textField.selectedTextRange = textField.fullRange
                        }
                    Text("Raw: \(checkAmount)")
                    Text("Formatted: \(checkAmount.formatted(currencyFormat))")
                    Text("Focused: \(amountIsFocused.description)")
                }
                Section {
                    Picker("Number of people", selection: $peopleCount) {
                        ForEach(2..<10, id: \.self) { Text("\($0) people") }
                    }
                    Text("Raw: \(peopleCount)")
                }
                Section {
                    Picker("Tip %", selection: $tip) {
                        ForEach(tipOptions, id: \.self) { Text($0, format: .percent) }
                    }.pickerStyle(.segmented)
                    Text("Raw: \(tip)")
                } header: { Text("Tip percentage") }
                Section {
                    Text("Total tip: \(tipAmount.formatted(currencyFormat))")
                    Text("Grand total: \(grandTotal.formatted(currencyFormat))")
                    Text("Per person: \(totalPerPerson.formatted(currencyFormat))")
                } header: { Text("Totals") }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        } // NavigationView
    } // body

    var tipAmount: Double {
        return checkAmount * Double(tip) / 100
    }

    var grandTotal: Double {
        return checkAmount + tipAmount
    }

    var totalPerPerson: Double {
        return grandTotal / Double(peopleCount)
    }

    var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
