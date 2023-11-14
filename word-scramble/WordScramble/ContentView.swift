//
// WordScramble
//


import SwiftUI


struct ContentView: View {

    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""

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
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                } // Section

            } // List
            .navigationTitle("Word Scramble")
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
