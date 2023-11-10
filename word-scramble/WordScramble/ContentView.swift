//
// WordScramble
//


import SwiftUI


struct ContentView: View {

    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingErrorAlert = false


    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()   
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            } // List
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .onSubmit(addNewWord)
            .alert(errorTitle, isPresented: $showingErrorAlert) {
                // Default OK button
            } message: {
                Text(errorMessage)
            }
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


    func isWordOriginal(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }


    func isWordPossible(_ word: String) -> Bool {
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


    func isWordReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }


    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }

        guard isWordOriginal(answer) else {
            showErrorAlert(title: "Word already used", message: "Be more original")
            return
        }

        guard isWordPossible(answer) else {
            showErrorAlert(title: "Word is not possible", message: "You cannot spell that word from '\(rootWord)'")
            return
        }

        guard isWordReal(answer) else {
            showErrorAlert(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }


    func showErrorAlert(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingErrorAlert = true
    }


}

#Preview {
    ContentView()
}
