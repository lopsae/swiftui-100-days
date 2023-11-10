//
// WordScramble
//


import SwiftUI


struct ContentView: View {

    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""


    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
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


    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }


}

#Preview {
    ContentView()
}
