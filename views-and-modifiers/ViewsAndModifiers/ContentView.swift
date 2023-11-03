//
// ViewsAndModifiers
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            CapsuleText(text: "And a one!")
            CapsuleText(text: "And a Two!")
            CapsuleText(text: "And a one two three!")
        }
        .padding()
        .background(.red)
    }
}


struct CapsuleText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.subheadline)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

#Preview {
    ContentView()
}
