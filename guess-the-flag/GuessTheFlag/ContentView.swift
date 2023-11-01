//
// GuessTheFlag
//

import SwiftUI

struct ContentView: View {

    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland",
        "Italy", "Nigeria", "Poland", "Spain",
        "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""


    var body: some View {
        ZStack {
//            Color.blue.ignoresSafeArea()
            LinearGradient(
                colors: [.blue, .black],
                startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0...2, id: \.self) { index in
                    Button {
                        flagTapped(index: index)
                    } label: {
                        Image(countries[index])
                            .clipShape(.buttonBorder)
                            .shadow(radius: 5)
                    }
                }
            }
        } // ZStack
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Try again") {}
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is TODO")
        }
    } // body


    func flagTapped(index: Int) {
        if index == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }


    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
