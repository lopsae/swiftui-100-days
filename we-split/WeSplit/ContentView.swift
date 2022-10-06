//
//  WeSplit
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""

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
