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
            Text("And a Two!")
                .modifier(RedCapsuleModifier())
            Text("And a Two Three Four!")
                .redCapsule()
        }
        .padding()
        .background(.red)

        GridStack(rows: 2, columns: 2) { row, col in
            VStack {
                Image(systemName: "\(row*2 + col).circle")
                Text("R\(row) C\(col)")
            }.padding()
            .background(.gray)
            .clipShape(.capsule)
        }
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
