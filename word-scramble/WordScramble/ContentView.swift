//
// WordScramble
//


import SwiftUI


struct ContentView: View {

    private let names = ["Pedro", "Pablo", "Jose", "Jose"] 
    // jose repeats, which produces a runtime warning

    var body: some View {
        List {
            Section("Text section") {
                Text("One text")
                Text("Two text")
                Text("Three text")
            }

            Section("Dynamic section") {
                ForEach(0..<5) {
                    Text("Dynamic Text \($0)")
                }
            }

            Section("Names section") {
                ForEach(names, id: \.self) {
                    Text("Name: \($0)")
                }
            }

            Section("VStack Section") {
                VStack(alignment: .center) {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("WordScramble!")
                }.frame(maxWidth: .infinity)
            }
        }.listStyle(.grouped)
    }
}

#Preview {
    ContentView()
}
