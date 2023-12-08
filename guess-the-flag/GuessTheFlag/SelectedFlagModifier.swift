//
// GuessTheFlag
//


import SwiftUI


struct SelectedFlagModifier: ViewModifier {

    let selection: Selection

    func body(content: Content) -> some View {
        let rotation: Angle = selection == .selected
            ? .zero
            : .degrees(360)

        let opacity = selection == .faded
            ? 0.3
            : 1.0
        let scale = selection == .faded
            ? 0.8
            : 1.0

        content
            .opacity(opacity)
            .scaleEffect(scale)
            .rotation3DEffect(rotation, axis: (x: 0.0, y: 1.0, z: 0.0))
    }


    enum Selection {
        case initial, selected, faded
    }

}


extension View {

    func selectedFlag(selection: SelectedFlagModifier.Selection) -> some View {
        modifier(SelectedFlagModifier(selection: selection))
    }

    func selectedFlag(index: Int, selected: Int?) -> some View {
        let selection: SelectedFlagModifier.Selection
        if let selected {
            selection = selected == index
                ? .selected
                : .faded
        } else {
            selection = .initial
        }

        return self.selectedFlag(selection: selection)
    }

}

