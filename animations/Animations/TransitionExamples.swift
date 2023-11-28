//
// Animations
//


import SwiftUI


struct TransitionExamples: View {

    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Bouncy animate") {
                withAnimation(.bouncy) {
                    isShowingRed.toggle()
                }
            }.buttonStyle(.bordered)

            Button("Default animate") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }.buttonStyle(.bordered)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }

        } // VStack
    } // Body

}


#Preview {
    TransitionExamples()
}

