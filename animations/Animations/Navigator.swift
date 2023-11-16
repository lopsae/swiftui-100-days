//
// Animations
//


import SwiftUI


struct Navigator: View {
    @State private var viewStack: [Destination] = [.animationExamples]

    var body: some View {
        NavigationStack(path: $viewStack) {
            List {
                NavigationLink("Animation examples", value: Destination.animationExamples)
                NavigationLink("Sphinxes", value: Destination.sphinxes)
                NavigationLink("A String (does not work)", value: "destinationString")
            }.listStyle(.grouped)
            .navigationDestination(for: Destination.self) { destination in
                destination.view
            }
            .navigationDestination(for: String.self) { string in
                // viewStack type limits the values that can be pushed to the stack
                // the string value cannot be used, produces a runtime warning in console
                Text("Simply a string")
            }
            .navigationTitle("Animations")
        }
    }
}


enum Destination: Hashable {

    case animationExamples
    case sphinxes

    @ViewBuilder var view: some View {
        switch self {
        case .animationExamples: AnimationExamples()
        case .sphinxes:          Text("Sphinx of black quartz")
        }
    }
}


#Preview {
    Navigator()
}

