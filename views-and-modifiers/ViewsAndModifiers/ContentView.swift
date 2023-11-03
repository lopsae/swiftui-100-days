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
            CapsuleText("And a one!")
            CapsuleText("And a Two!")
            Text("And a one two three!")
                .modifier(RedCapsuleModifier())
            Text("Bop bop bop!")
                .redCapsule()
        }
        .padding()
        .background(.red)
    }
}


struct CapsuleText: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

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
