//
//  ContentView.swift
//  BetterRest
//
//  Created by Maic Lopez Saenz on 11/6/23.
//

import SwiftUI

struct ContentView: View {

    @State private var sleepAmount = 8.0
    @State private var wakeUp: Date = {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }()

    var body: some View {
        Form {
            Section {
                Stepper("\(sleepAmount.formatted()) Hours", value: $sleepAmount, in: 4...12, step: 0.25)
            }
            Section {
                Text("Date: \(wakeUp.formatted(date: .long, time: .shortened))")
                DatePicker("Wakeup time", selection: $wakeUp, /*in: Date.now...,*/ displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }

        }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Better Rest")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
