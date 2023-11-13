//
// WeSplitAgain
//

import SwiftUI

struct ContentView: View {

    @FocusState private var amountIsFocused: Bool

    @State private var checkAmount = 20.0
    @State private var peopleCount = 4
    @State private var tipPercentage = 20

    let tipOptions = [0, 10, 15, 20, 25]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .localCurrencyOrUsd())
                    .keyboardType(.decimalPad)
                    .submitLabel(.done) // noes not show button
                    .focused($amountIsFocused)

                    .onReceive(UITextField.textDidBeginEditingNotification.publisher()) {
                        notification in
                        guard let textField = notification.object as? UITextField else { return }

                        // Queueing seems to work more consistently for
                        // selecting the entire textfield
                        DispatchQueue.main.async { [weak textField] in
                            guard let textField else { return }
                            textField.selectedTextRange = textField.fullRange
                        }

                    }

                    Picker("Number of people", selection: $peopleCount) {
                        ForEach(2..<10, id: \.self) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Tip percentage") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipOptions, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Values") {
                    Text("Check amount: \(checkAmount.asCurrency())")
                    Text("Tip amount: \(tipAmount.asCurrency())")
                    Text("Grand Total: \(grandTotal.asCurrency())")
                    Text("Split between: \(peopleCount)")
                }
                Section("Amount per person") {
                    Text("Per person: \(totalPerPerson.asCurrency())")
                }
            } // Form
            .navigationTitle("WeSplit-Again")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        // Done button seems to de-focus the text field
                        // but does not trigger a submit
                        amountIsFocused = false
                    }
                }
            }
            .onSubmit {
                print("🍊 Form submited")
            }
        }
    }

    var tipAmount: Double {
        let tipSelection = Double(tipPercentage)
        return checkAmount / 100 * tipSelection
    }

    var grandTotal: Double {
        return checkAmount + tipAmount
    }

    var totalPerPerson: Double {
        let peopleCount = Double(peopleCount)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
}


extension FormatStyle {
    static func localCurrencyOrUsd<Value>() -> Self
    where Self == FloatingPointFormatStyle<Value>.Currency, Value: BinaryFloatingPoint
    {
        let code = Locale.current.currency?.identifier ?? "USD"
        return .currency(code: code)
    }
}


extension BinaryFloatingPoint {
    func asCurrency() -> FloatingPointFormatStyle<Self>.Currency.FormatOutput {
        self.formatted(.localCurrencyOrUsd())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
