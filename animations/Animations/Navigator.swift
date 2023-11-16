//
// Animations
//


import SwiftUI


struct Navigator: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Animation examples") {
                    AnimationExamples()
                }
            }.listStyle(.grouped)
            .navigationTitle("Animations")
        }
    }
}

#Preview {
    Navigator()
}

