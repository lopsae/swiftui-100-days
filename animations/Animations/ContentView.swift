//
// Animations
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush.pointed")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Animations")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
