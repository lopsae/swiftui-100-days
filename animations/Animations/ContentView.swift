//
// Animations
//


import SwiftUI


struct ContentView: View {

    @State private var animationFactor = 1.0


    var body: some View {
        Button("Tap me") {
//            animationFactor += 1.0
        }.padding(50)
            .background(.red.gradient)
            .foregroundStyle(.white)
            .clipShape(.circle)
//            .scaleEffect(animationFactor)
            .overlay {
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationFactor)
                    .opacity(2-animationFactor)
                    .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationFactor)
            }
            .onAppear {
                animationFactor = 2
            }
//            .animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true), value: animationFactor)
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
