//
// ViewsAndModifiers
//


import SwiftUI


struct RedCapsuleModifier: ViewModifier {

    func body(content: Content) -> some View {
        return content
            .font(.subheadline)
            .foregroundStyle(.white)
            .padding()
            .background(.red)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }

}


extension View {

    func redCapsule() -> some View {
        modifier(RedCapsuleModifier())
    }

}

