//
//  ContentView.swift
//  WeSplitAgain
//
//  Created by Maic Lopez Saenz on 10/27/23.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 0.0
    @State private var peopleCount = 2
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
                    Picker("Number of people", selection: $peopleCount) {
                        ForEach(2..<10) {
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
                Section {
                    Text(checkAmount, format: .localCurrencyOrUsd())
                }
            }
            .navigationTitle("WeSplit-Again")
            .navigationBarTitleDisplayMode(.inline)
        }

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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
