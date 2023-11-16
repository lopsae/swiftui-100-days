//
// Animations
//


import SwiftUI


struct Navigator: View {
    @State private var viewStack: [Destination] = []

    var body: some View {
        NavigationStack(path: $viewStack) {
            List {
                NavigationLink("Animation examples", value: Destination("examples"))
            }.listStyle(.grouped)
            .navigationDestination(for: Destination.self) { destination in
                if destination.destination == "examples" {
                    AnimationExamples()
                }
            }
            .navigationTitle("Animations")
        }
    }
}


struct Destination: Hashable {
    let destination: String

    init(_ destination: String) {
        self.destination = destination
    }
}

#Preview {
    Navigator()
}

