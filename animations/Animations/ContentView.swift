//
// Animations
//


import SwiftUI


struct ContentView: View {

    @State private var compoundTrigger = false
    @State private var rotationAmount = Double.zero
    @State private var redButtonFactor = 1.0



    var body: some View {
//        print("🍊 redButtonFactor: \(redButtonFactor)")
//        return List {
        Button("Compound me") {
            compoundTrigger.toggle()
        }.frame(width: 150, height: 150)
        .background(compoundTrigger ? Color.green : Color.indigo)
        .animation(.linear(duration: 2), value: compoundTrigger)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: compoundTrigger ? 20 : 0))
        .scaleEffect(compoundTrigger ? 2 : 1)
        .animation(.spring(duration: 0.5, bounce: 0.5), value: compoundTrigger)
        List {
            Section("Compound animation") {
                Button("Compound me") {
                    compoundTrigger.toggle()
                }.frame(width: 150, height: 150)
                .background(compoundTrigger ? Color.green : Color.indigo)
                .foregroundStyle(.white)
                .scaleEffect(compoundTrigger ? 2 : 1)
                // This animation sometimes works inside List
                .animation(.linear(duration: 1), value: compoundTrigger)
            } // Section

            Section("Rotation animation") {
                Button("Rotate me") {
                    withAnimation(.spring(duration: 2, bounce: 0.5)) {
                        rotationAmount += 70
                    }
                }.padding(50)
                .background(.blue.gradient)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .frame(maxWidth: .infinity)
                .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 1, z: 0))
            } // Section

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
            } // Section
        } // VStack
    }
}

#Preview {
    ContentView()
}
