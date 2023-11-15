//
// Animations
//


import SwiftUI


struct ContentView: View {

    @State private var redButtonFactor = 1.0


    var body: some View {
        print("🍊 redButtonFactor: \(redButtonFactor)")
        return List {
            Stepper("Scale amount", value: $redButtonFactor.animation(.bouncy(duration: 2)), in: 1...10)
            // Text also animates when change comes from the stepper
            Text("scaleFactor: \(redButtonFactor)")
            Button("Scale +1") {
                redButtonFactor += 1.0
            }.padding(50)
                .background(.red.gradient)
                .foregroundStyle(.white)
                .clipShape(.circle)
            // How is this knowing that it should animate?
            // Is $.animation() creating an animation transaction everytime it changes?
                .scaleEffect(redButtonFactor)
                .frame(maxWidth: .infinity)
        } // VStack
    }
}

#Preview {
    ContentView()
}
