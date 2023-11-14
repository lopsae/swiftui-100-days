//
// WordScramble
//


import SwiftUI


struct ContentView: View {

    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""

    @FocusState private var isTextFieldFocused

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingErrorAlert = false


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
            .onSubmit(addNewWord)
            .alert(errorTitle, isPresented: $showingErrorAlert) {
                Button("OK") { isTextFieldFocused = true }
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


    func isAlreadyUsed(word: String) -> Bool {
        return !usedWords.contains(word)
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


    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }

        guard isAlreadyUsed(word: answer) else {
            showErrorAlert(title: "Word already used", message: "Find a different one")
            return
        }

        guard isPermutationOfRoot(word: answer) else {
            showErrorAlert(title: "Word is not a permutation", message: "cannot spell '\(answer)' from '\(rootWord)'")
            return
        }

        guard isInDictionary(word: answer) else {
            showErrorAlert(title: "Word not in dictionary", message: "Word has to be in current use")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        isTextFieldFocused = true
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
