//
// Animations
//


import SwiftUI


struct Navigator: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Animations examples") {
                    ContentView()
                }
            }.listStyle(.grouped)
            .navigationTitle("Animations")
        }
    }
}

#Preview {
    Navigator()
}

