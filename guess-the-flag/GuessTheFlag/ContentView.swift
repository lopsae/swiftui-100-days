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

    @State private var showingCorrectAlert = false
    @State private var showingIncorrectAlert = false
    @State private var showingFinalAlert = false

    @State private var selectedFlag: Int?

    @State private var score = 0
    @State private var attempts = 0

    private let maxAttempts = 3

    @State private var text = ""

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
                            withAnimation(.easeInOut(duration: 1), completionCriteria: .logicallyComplete) {
                                selectedFlag = index
                            } completion:  {
                                print("🎥 Animation completed")
                            }
                        } label: {
                            Image(countries[index])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                                .selectedFlag(index: index, selected: selectedFlag)
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

        // Correct flag alert
        .alert("Correct!", isPresented: $showingCorrectAlert) {
            Button("Continue", action: setNextStage)
        } message: {
            Text("Your current score is \(score)")
        }

        // Incorrect flag alert
        .alert("Incorrect...", isPresented: $showingIncorrectAlert) {
            Button("Continue", action: setNextStage)
        } message: {
            Text("Your current remains at \(score)")

        }

        // Complete game alert
        .alert("Game Complete", isPresented: $showingFinalAlert) {
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
            score += 1
            showingCorrectAlert = true
        } else {
            showingIncorrectAlert = true
        }
    }


    func setNextStage() {
        if attempts < maxAttempts {
            setNextFlagGuess()
        } else {
            showingFinalAlert = true
        }
    }


    func setNextFlagGuess() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = nil
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
