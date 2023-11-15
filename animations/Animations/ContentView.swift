//
// Animations
//


import SwiftUI


struct ContentView: View {

    @State private var redButtonFactor = 1.0
    @State private var rotationAmount = Double.zero


    var body: some View {
        print("🍊 redButtonFactor: \(redButtonFactor)")
        return List {
            Section {
                Button("Rotate me") {
                    withAnimation(.spring(duration: 2, bounce: 0.5)) {
                        rotationAmount += 70
                    }
                }
                    .padding(50)
                    .background(.blue.gradient)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
                    .frame(maxWidth: .infinity)
                    .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 1, z: 0))
            }
            Section("Scale animation") {
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
            }
        } // VStack
    }
}

#Preview {
    ContentView()
}
