//
// Animations
//


import SwiftUI


struct AnimationExamples: View {

    @State private var dragOffset = CGSize.zero
    @State private var compoundTrigger = false
    @State private var rotationAmount = Double.zero
    @State private var scaleFactor = 1.0

    private let draggableWord = Array("Draggable")
    @State private var backgroundEnabled = false
    @State private var wordDragOffset = CGSize.zero


    var body: some View {
        List {
            Section("Word drag") {
                HStack(spacing: 0) {
                    let enumerated = Array(draggableWord.enumerated())
                    ForEach(enumerated, id: \.offset) { item in
                        let linearDelay = Animation.linear.delay(Double(item.offset) / 20)
                        Text(String(item.element))
                            .padding(5)
                            .font(.title)
                            .background(backgroundEnabled ? .blue : .red)
                            .offset(wordDragOffset)
                            .animation(linearDelay, value: wordDragOffset)
                    }
                    .gesture(DragGesture()
                        .onChanged { wordDragOffset = $0.translation }
                        .onEnded { _ in
                            wordDragOffset = .zero
                            backgroundEnabled.toggle()
                        }
                    )
                }.frame(maxWidth: .infinity, minHeight: 120)
            } // Section

            Section("Drag animation") {
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 150, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(dragOffset)
                    .gesture(DragGesture()
                        .onChanged { dragValue in
                            withAnimation(.interactiveSpring) {
                                dragOffset = dragValue.translation
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.bouncy) {
                                dragOffset = .zero
                            }
                        }
                    )
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
                Stepper("Scale amount", value: $scaleFactor.animation(.bouncy(duration: 2)), in: 1...10)
                // Text also animates when change comes from the stepper
                Text("scaleFactor: \(scaleFactor)")
                Button("Scale +1") {
                    scaleFactor += 1.0
                }.padding(50)
                .background(.red.gradient)
                .foregroundStyle(.white)
                .clipShape(.circle)
                // How is this knowing that it should animate?
                // Is $.animation() creating an animation transaction everytime it changes?
                .scaleEffect(scaleFactor)
                .frame(maxWidth: .infinity)
            } // Section

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
        } // List

        Button("Compound me") {
            compoundTrigger.toggle()
        }.frame(width: 150, height: 80)
        .background(compoundTrigger ? Color.green : Color.indigo)
        .animation(.linear(duration: 2), value: compoundTrigger)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: compoundTrigger ? 20 : 0))
        .scaleEffect(compoundTrigger ? 2 : 1)
        .animation(.spring(duration: 0.5, bounce: 0.5), value: compoundTrigger)
    }
}

#Preview {
    AnimationExamples()
}
