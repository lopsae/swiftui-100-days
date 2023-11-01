//
// GuessTheFlag
//

import SwiftUI

struct ContentView: View {

    private static let flagsToShow = 3
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland",
        "Italy", "Nigeria", "Poland", "Spain",
        "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<flagsToShow)

    @State private var showingScore = false
    @State private var showingFinal = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var attempts = 0

    private let maxAttempts = 3


    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.medium))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.bold())
                    }
                    ForEach(0..<Self.flagsToShow, id: \.self) { index in
                        Button {
                            flagTapped(index: index)
                        } label: {
                            Image(countries[index])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                        }
                    }
                } // VStack
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title2)
                Text("Attempts left: \(maxAttempts - attempts)")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                Spacer()
            } // VStack
            .padding()
        } // ZStack
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: setNextStage)
        } message: {
            Text("Your current score is \(score)")
        }
        .alert("Game Complete", isPresented: $showingFinal) {
            Button("Restart", action: resetScore)
        } message: {
            Text("Your final score is \(score)")
        }
    } // body


    func flagTapped(index: Int) {
        attempts += 1
        showScore(index: index)
    }


    func showScore(index: Int) {
        if index == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }


    func setNextStage() {
        if attempts < maxAttempts {
            setNextFlagGuess()
        } else {
            showingFinal = true
        }


    }


    func setNextFlagGuess() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }


    func resetScore() {
        score = 0
        attempts = 0
        setNextFlagGuess()
    }

}

#Preview {
    ContentView()
}
