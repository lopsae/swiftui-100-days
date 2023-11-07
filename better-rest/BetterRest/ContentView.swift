//
// BetterRest

//


import CoreML
import SwiftUI


struct ContentView: View {

    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    @State private var wakeUp = defaultWakeUp

    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(maxWidth: .infinity)
                    Text("Raw components: h:\(wakeUpComponents.hour) m:\(wakeUpComponents.minute)")
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect:true)", value: $coffeeAmount, in: 1...20)
                }

            } // VStack
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        } // NavigationStack
        .alert(alertTitle, isPresented: $showingAlert) {
            // Empty
        } message: {
            Text(alertMessage)
        }

    } // body


    private var wakeUpComponents: (hour: Int, minute: Int) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return (hour: hour, minute: minute)
    }


    func calculateBedTime() {
        let componets = wakeUpComponents
        let wakeUpSeconds = componets.hour * 3600 + componets.minute * 60
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let prediction = try model.prediction(wake: Int64(wakeUpSeconds), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)

        } catch {
            print(error)
            alertTitle = "Error"
            alertMessage = "There was an error estimating your bedtime"
        }

        showingAlert = true
    }
}

#Preview {
    ContentView()
}
