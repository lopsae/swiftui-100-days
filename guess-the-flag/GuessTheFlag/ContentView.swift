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
                    ForEach(0...2, id: \.self) { index in
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
                Text("Score: TODO")
                    .foregroundStyle(.white)
                    .font(.title2)
                Spacer()
            } // VStack
            .padding()
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
