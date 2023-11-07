//
// BetterRest

//


import SwiftUI


struct ContentView: View {

    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)

                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)

            } // VStack
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        } // NavigationStack
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
    } // body


    func calculateBedTime() {
        // TODO
    }
}

#Preview {
    ContentView()
}
