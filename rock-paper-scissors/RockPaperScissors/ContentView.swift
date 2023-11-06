//
// RockPaperScissors
//


import SwiftUI


struct ContentView: View {

    @State private var computerHand = Hand.allCases.randomElement()!
    @State private var userShouldWin = true

    @State private var score = 0
    @State private var attempts = 0

    var body: some View {
        VStack {
            Text("The computer has chosen")
            Text(computerHand.emoji)
                .font(.largeTitle)
                .padding()
                .background(.blue.gradient)
                .clipShape(.circle)
        } .padding() // VStack

        VStack {
            Text("Choose to")
            Text(userShouldWin ? "Win" : "Lose").font(.title)
            HStack {
                ForEach(Hand.allCases, id: \.rawValue) { item in
                    Button {
                        challenge(with: item)
                    } label: {
                        Text(item.emoji).font(.largeTitle)
                    }
                    .buttonStyle(.bordered)
                } // ForEach
            } // HStack
        } .padding() // VStack

        VStack {
            Text("Score: \(score)")
            Text("Attempts: \(attempts)")
        }.padding() // VStack
    } // body

    func challenge(with userHand: Hand) {

        if userShouldWin {
            if userHand.beats(computerHand) { score += 1 }
        } else {
            if computerHand.beats(userHand) { score += 1 }
        }

        attempts += 1
        setNextHand()
    }


    func setNextHand() {
        computerHand = Hand.allCases.randomElement()!
        userShouldWin.toggle()
    }

}

#Preview {
    ContentView()
}
