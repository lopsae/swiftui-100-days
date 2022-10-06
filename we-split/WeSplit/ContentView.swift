//
//  WeSplit
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var tapCount = 0

    let options = ["Uno", "Dos", "Tres"]
    @State private var selectedOption = "Dos"

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Name: \(name)")
                }
                Section {
                    Button("Increase tap: \(tapCount)") {
                        tapCount += 1
                    }
                }
                Section {
                    Picker("Select your option", selection: $selectedOption) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    ForEach(0 ..< 7) {
                        Text("Row No. \($0)")
                    }
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
