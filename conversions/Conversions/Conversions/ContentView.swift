//
//  ContentView.swift
//  Conversions
//
//  Created by Maic Lopez Saenz on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    private let measurementOptions = ["temperature", "length"]
    @State private var selectedMeasurement = "temperature"

    private let units = [
        "temperature": ["celcius", "fahrenheit", "kelvin"],
        "length": ["meters", "kilometers", "feet", "yards", "miles"]
    ]

    @State private var inputValue: Double? = nil
    @State private var selectedInputUnit: String? = "celcius"
    @State private var selectedOutputUnit: String? = nil

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Measurement", selection: $selectedMeasurement) {
                        ForEach(measurementOptions, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Input") {
                    TextField("Input value", value: $inputValue, format: .number, prompt: Text("Prompt?"))
                        .keyboardType(.decimalPad)
                    Text("Raw: \(inputValue?.description ?? "nil")")
                    Picker("Input Unit", selection: $selectedInputUnit) {
                        ForEach(units[selectedMeasurement]!, id: \.self) {
                            Text($0).tag(Optional($0))
                        }
                    }.pickerStyle(.segmented)
                    Text("Raw: \(selectedInputUnit ?? "nil")")
                }
                Section("Output") {
                    Text("Converted to: TODO")
                    Picker("Output Unit", selection: $selectedOutputUnit) {
                        ForEach(units[selectedMeasurement]!, id: \.self) {
                            Text($0).tag(Optional($0))
                        }
                    }.pickerStyle(.segmented)
                    Text("Raw: \(selectedOutputUnit ?? "nil")")
                }
            } // Form
            .navigationTitle("Conversions")
            .navigationBarTitleDisplayMode(.inline)
        } // NavigationStack
    }
}

#Preview {
    ContentView()
}
