//
// Animations
//


import SwiftUI


struct ContentView: View {

    @State private var animationFactor = 1.0


    var body: some View {
        Button("Tap me") {
            animationFactor += 0.5
        }.padding(50)
            .background(.red.gradient)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationFactor)
            .blur(radius: (animationFactor - 1) * 3)
            .animation(.default, value: animationFactor)
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
