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

    @State private var originalAmount = 0.0
    @State private var selectedOriginalUnit = "celcius"
    @State private var selectedConvertedUnit = "celcius"

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
                Section("Original") {
                    TextField("Unit to convert", value: $originalAmount, format: .number)
                        .keyboardType(.decimalPad)
                    Text("Formatted value: \(originalAmount)")
                    Picker("Original Unit", selection: $selectedOriginalUnit) {
                        ForEach(units[selectedMeasurement]!, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Converted") {
                    Text("Converted to: TODO")
                    Picker("Converted Unit", selection: $selectedConvertedUnit) {
                        ForEach(units[selectedMeasurement]!, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
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
