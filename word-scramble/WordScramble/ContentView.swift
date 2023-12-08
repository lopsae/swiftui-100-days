//
// WordScramble
//


import SwiftUI


struct ContentView: View {

    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var totalScore = 0

    @FocusState private var isTextFieldFocused

    @State private var errorMessage: String? // = "Test error"


    var body: some View {
        NavigationStack {
            List {
                VStack {
                    Text("Write words using the letters in")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                    Text(rootWord)
                        .font(.title)
                        .frame(maxWidth: .infinity)
                } // VStack

                Section {
                    TextField("Enter your word", text: $newWord)
                        .focused($isTextFieldFocused)
                        .textInputAutocapitalization(.never)
                        .multilineTextAlignment(.center)
                        .autocorrectionDisabled()
                } // Section

                if let errorMessage {
                    Section {
                        VStack(alignment: .center, spacing: 5) {
                            Image(systemName: "exclamationmark.triangle")
                            Text(errorMessage)
                        }.frame(maxWidth: .infinity)
                        .foregroundStyle(.warning)
                    }
                }

                Section {
                    if totalScore > 0 {
                        Text("Total score: \(totalScore)")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                } // Section

            } // List
            .navigationTitle("Word Scramble")
            .toolbar {
                Button("Reset Game") {
                    withAnimation {
                        startGame()
                    }
                }
            }
            .onAppear(perform: startGame)
            .onSubmit(submitNewWord)
        } // NavigationStack


    } // body


    func startGame() {
        guard let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsUrl)
        else {
            fatalError("Could not load starting words from bundle")
        }

        let allWords = startWords.components(separatedBy: .newlines)

        rootWord = allWords.randomElement() ?? "silkworm"
        newWord = ""
        usedWords = []
        totalScore = 0
        errorMessage = nil

        isTextFieldFocused = true
    }


    func isMinimalLength(word: String) -> Bool {
        return word.count >= 3
    }


    func isAlreadyUsed(word: String) -> Bool {
        return usedWords.contains(word)
    }


    func isPermutationOfRoot(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let found = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: found)
            } else {
                return false
            }
        }

        return true
    }


    func isInDictionary(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }


    func submitNewWord() {
        _ = attemptAddNewWord()
        isTextFieldFocused = true
    }


    func attemptAddNewWord() -> Bool {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var localErrorMessage: String?
        
        if answer.count <= 0 {
            localErrorMessage = "Empty words are not allowed"
        } else if !isMinimalLength(word: answer) {
            localErrorMessage = "Word should have at least 3 letters"
        } else if isAlreadyUsed(word: answer) {
            localErrorMessage = "Word already used"
        } else if !isPermutationOfRoot(word: answer) {
            localErrorMessage = "Word is not a permutation"
        } else if !isInDictionary(word: answer) {
            localErrorMessage = "Word not in dictionary"
        }

        if let localErrorMessage {
            withAnimation {
                errorMessage = localErrorMessage
            }
            return false
        }

        withAnimation {
            totalScore += answer.count
            usedWords.insert(answer, at: 0)
            errorMessage = nil
        }

        newWord = ""
        return true
    }

}


struct WarningStyle: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        Color.red
    }
}

extension ShapeStyle where Self == WarningStyle {
    static var warning: WarningStyle {
        WarningStyle()
    }
}

#Preview {
    let view = ContentView()
    return view
}
