//
//  ContentView.swift
//  WordScramble
//
//  Created by Aidan Bergerson on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            addNewWord()
                        }
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                    
                }
            }
            .navigationTitle(rootWord)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("New Game") {
                        newGame()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("Score: \(score)")
                }
            }
            .onAppear(perform: {
                startGame()
            })
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            errorMessage(title: "Word used already", message: "This word has been already used, pick another!")
            return
        }
        
        guard isPossible(word: answer) else {
            errorMessage(title: "Word not possible", message: "You cannot spell that word from '\(rootWord)'")
            return
        }
        
        guard isReal(word: answer) else {
            errorMessage(title: "Word not recognize", message: "You cannot make up words")
            return
        }
        
        guard newWord.count > 2 else {
            errorMessage(title: "Too Short", message: "You must type in 3 or more characters")
            return
            }
        
        guard newWord != rootWord else {
            errorMessage(title: "Cannot use initial word", message: "You cannot use the root word, use your brain")
            return
        }
    
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        
        addScore()
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func errorMessage(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func newGame() {
        usedWords = [String]()
        newWord = ""
        startGame()
    }
    
    func addScore() {
        addNewWord()
        score += 1
    }
}

#Preview {
    ContentView()
}
