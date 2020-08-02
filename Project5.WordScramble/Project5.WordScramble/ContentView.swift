import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                GeometryReader { fullView in
                    List(self.usedWords, id: \.self) { word in
                        GeometryReader { geometry in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(Color(
                                        red: Double(geometry.frame(in: .global).minY / fullView.size.height),
                                        green: 0.545,
                                        blue: 0.465))
                                
                                Text(word)
                                    .foregroundColor(Color(
                                        red: Double(geometry.frame(in: .global).minY / fullView.size.height),
                                        green: 0.555,
                                        blue: 0.455))
                            }
                            .frame(width: fullView.size.width, alignment: .leading)
                            .offset(x: (geometry.frame(in: .global).minY - (fullView.size.height) > 8
                                ? geometry.frame(in: .global).minY - (fullView.size.height)
                                : 8),
                                    y: 0)
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("\(word), \(word.count) letters"))
                        }
                    }
                }
                
                Text("Score: \(userScore)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button(action: { self.startGame() }) {
                Text("Start game")
            })
                .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert.init(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            userScore -= answer.count
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            userScore -= answer.count
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) && answer.count > 3 else {
            userScore -= answer.count
            wordError(title: "Word not possible", message: "That isn't real word")
            return
        }
        
        if isOriginal(word: answer) || isPossible(word: answer) || (isReal(word: answer) && answer.count > 3) {
            userScore += answer.count
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) && rootWord != newWord
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
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
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
