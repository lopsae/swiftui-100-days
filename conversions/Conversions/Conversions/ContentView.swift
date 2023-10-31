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

    private let units: [String: [ConversionUnit]] = [
        "temperature": [
            ConversionUnit(id: "celcius", unit: UnitTemperature.celsius),
            ConversionUnit(id: "fahrenheit", unit: UnitTemperature.fahrenheit),
            ConversionUnit(id: "kelvin", unit: UnitTemperature.kelvin)],
        "length": [
            ConversionUnit(id: "meters", unit: UnitLength.meters),
            ConversionUnit(id: "kilometers", unit: UnitLength.kilometers),
            ConversionUnit(id: "feet", unit: UnitLength.feet),
            ConversionUnit(id: "yards", unit: UnitLength.yards),
            ConversionUnit(id: "miles", unit: UnitLength.miles),]
    ]

    struct ConversionUnit: Hashable {
        let id: String
        let unit: Unit

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }

    @State private var inputValue: Double? = nil
    @State private var selectedInputUnit: ConversionUnit? = nil
    @State private var selectedOutputUnit: ConversionUnit? = nil

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
                    TextField("Input value", value: $inputValue, format: .number, prompt: Text("Input value"))
                        .keyboardType(.decimalPad)
                    Text("Raw: \(inputValue?.description ?? "nil")")
                    Picker("Input Unit", selection: $selectedInputUnit) {
                        ForEach(units[selectedMeasurement]!, id: \.self) {
                            Text($0.id).tag(Optional($0))
                        }
                    }.pickerStyle(.segmented)
                    Text("Raw: \(selectedInputUnit?.id ?? "nil")")
                }
                Section("Output") {
                    Text("Converted to: \(convertedValue?.description ?? "nil")")
                    Picker("Output Unit", selection: $selectedOutputUnit) {
                        ForEach(units[selectedMeasurement]!, id: \.self) {
                            Text($0.id).tag(Optional($0))
                        }
                    }.pickerStyle(.segmented)
                    Text("Raw: \(selectedOutputUnit?.id ?? "nil")")
                }
            } // Form
            .navigationTitle("Conversions")
            .navigationBarTitleDisplayMode(.inline)
        } // NavigationStack
    }// body

    
    private var convertedValue: Double? {
        guard let inputValue = inputValue,
              let selectedInputUnit = selectedInputUnit?.unit,
              let selectedOutputUnit = selectedOutputUnit?.unit
        else { return nil }

        if selectedMeasurement == "temperature" {
            let inputUnit = selectedInputUnit as! UnitTemperature
            let outputUnit = selectedOutputUnit as! UnitTemperature
            let input = Measurement(value: inputValue, unit: inputUnit)
            let converted = input.converted(to: outputUnit)
            return converted.value
        } else if selectedMeasurement == "length" {
            let inputUnit = selectedInputUnit as! UnitLength
            let outputUnit = selectedOutputUnit as! UnitLength
            let input = Measurement(value: inputValue, unit: inputUnit)
            let converted = input.converted(to: outputUnit)
            return converted.value
        }

        return nil
    }

}


#Preview {
    ContentView()
}
