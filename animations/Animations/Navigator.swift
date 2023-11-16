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
            }.listStyle(.grouped)
            .navigationDestination(for: Destination.self) { destination in
                destination.view
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

