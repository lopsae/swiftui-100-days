//
//  ContentView.swift
//  Conversions
//
//  Created by Maic Lopez Saenz on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedMeasurement: MeasurementSet = measurementOptions[0]
    private static let measurementOptions: [MeasurementSet] = [
        MeasurementSet(id: "temperature",
            units: [
            ConversionUnit(id: "celcius", unit: UnitTemperature.celsius),
            ConversionUnit(id: "fahrenheit", unit: UnitTemperature.fahrenheit),
            ConversionUnit(id: "kelvin", unit: UnitTemperature.kelvin)]),
        MeasurementSet(id: "length",
            units: [
            ConversionUnit(id: "meters", unit: UnitLength.meters),
            ConversionUnit(id: "kilometers", unit: UnitLength.kilometers),
            ConversionUnit(id: "feet", unit: UnitLength.feet),
            ConversionUnit(id: "yards", unit: UnitLength.yards),
            ConversionUnit(id: "miles", unit: UnitLength.miles)])
    ]

    struct MeasurementSet: Hashable {
        let id: String
        let units: [ConversionUnit]
        func hash(into hasher: inout Hasher) { hasher.combine(id) }
    }

    struct ConversionUnit: Hashable {
        let id: String
        let unit: Unit
        func hash(into hasher: inout Hasher) { hasher.combine(id) }
    }

    @State private var inputValue: Double? = nil
    @State private var selectedInputUnit: ConversionUnit? = nil
    @State private var selectedOutputUnit: ConversionUnit? = nil

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Measurement", selection: $selectedMeasurement) {
                        ForEach(Self.measurementOptions, id: \.self) {
                            Text($0.id)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Input") {
                    TextField("Input value", value: $inputValue, format: .number, prompt: Text("Input value"))
                        .keyboardType(.decimalPad)
                    Text("Raw: \(inputValue?.description ?? "nil")")
                    Picker("Input Unit", selection: $selectedInputUnit) {
                        ForEach(selectedMeasurement.units, id: \.self) {
                            Text($0.id).tag(Optional($0))
                        }
                    }.pickerStyle(.segmented)
                    Text("Raw: \(selectedInputUnit?.id ?? "nil")")
                }
                Section("Output") {
                    Text("Converted to: \(convertedValue?.description ?? "nil")")
                    Picker("Output Unit", selection: $selectedOutputUnit) {
                        ForEach(selectedMeasurement.units, id: \.self) {
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

        if selectedMeasurement.id == "temperature" {
            let inputUnit = selectedInputUnit as! UnitTemperature
            let outputUnit = selectedOutputUnit as! UnitTemperature
            let input = Measurement(value: inputValue, unit: inputUnit)
            let converted = input.converted(to: outputUnit)
            return converted.value
        } else if selectedMeasurement.id == "length" {
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
