//
//  WeSplit
//

import SwiftUI

struct PlaygroundView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("🛠")
            Text("Padded text!")
            Text("Padded text 2!")
            Text("Padded text 3!")
        }
    }
}

struct PlaygroundView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            PlaygroundView()
        }
    }
}
