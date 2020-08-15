//
//  ContentView.swift
//  Milestone2.MultiplicationTableQuiz
//
//  Created by camotsuc on 13.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedRange = 5
    @State private var selectedQuestions = 5
    @State private var questions = [5,10,15,20]
    @State private var gameStarted = false
    @State var gameQuestions = [String]()
    @State private var gameQuestions1 = [Int]()
    @State private var gameQuestions2 = [Int]()
    @State var answers = [Int]()
    @State private var arr = [1,2,3,4,5,6,7,8,9,10,11,12]
    var body: some View {
            NavigationView {
                VStack(spacing: 40) {
                    Text("Choose multiplication range")
                        .font(.title)
                    Picker(selection: $selectedRange, label: Text("Choose multiplication range")) {
                        ForEach(arr, id: \.self) { num in
                            Text("\(self.arr[num - 1])")
                                .font(.largeTitle)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("Choose number of questions")
                        .font(.title)
                    Picker(selection: $selectedQuestions, label: Text("Choose multiplication range")) {
                        ForEach(questions, id: \.self) { question in
                            Text("\(question)")
                                .font(.largeTitle)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    NavigationLink(destination: GameView(answers: self.answers, gameQuestions: self.gameQuestions), isActive: $gameStarted, label: {
                        Button(action: {
                            self.gameStarted = true
                            self.startGame(range: self.selectedRange, questions: self.selectedQuestions)
                        }) {
                            Text("Start the game")
                                .font(.system(size: 30))
                                .frame(width:200, height: 70)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    })
                }
                 .navigationBarTitle("Settings")
            }
    }
    
    
    func startGame(range: Int, questions: Int) {
        var state = false
        var count = -1
        self.gameQuestions1.removeAll()
        self.gameQuestions2.removeAll()
        self.answers.removeAll()
        self.gameQuestions.removeAll()
        while state == false {
            if self.gameQuestions2.count == questions {
                state = true
            } else {
                count += 1
                self.gameQuestions1.append(Int.random(in: 1...9))
                self.gameQuestions2.append(Int.random(in: 1...range))
                self.answers.append(gameQuestions1[count] * gameQuestions2[count])
                self.gameQuestions.append("How much will be \(self.gameQuestions2[count]) * \(self.gameQuestions1[count]) ?")
            }
        }
    }
}

struct GameView: View {
    var answers: [Int]
    var gameQuestions: [String]
    @State private var numbers = [["1","2","3"],["4","5","6"],["7","8","9"],["Sumbit","0","X"]]
    @State private var result = ""
    @State private var currentQuestion = 0
    @State private var hidden = true
    
    var body: some View {
        VStack(spacing: 10) {
            if self.answers.count == self.currentQuestion {
                Text("Congratulations!You're won.Go to the settings now and restart the game")
            } else {
                Text("\(self.gameQuestions[currentQuestion])")
                    .fontWeight(.black)
                    .font(.system(size: 24))
            }
            Text(result)
                .fontWeight(.black)
                .font(.system(size: 30))
                .padding(.all)
                .frame(width: 100, height: 50)
                .border(Color.black)
            Text("Wrong")
                .opacity(self.hidden ? 0.0 : 1.0)
            ForEach(numbers, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            if button == "Sumbit" {
                                if self.checkResult(result: self.result) {
                                    self.result = ""
                                    self.currentQuestion += 1
                                } else {
                                    self.hidden = false
                                }
                            } else if button == "X" {
                                self.result = ""
                                self.hidden = true
                            } else {
                                self.result += button
                            }
                        }) {
                            Text(button)
                                .font(.system(size: 30))
                                .frame(width:110, height: 70)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                    }
                }
            }
        }
        
    }
    func checkResult(result: String) -> Bool {
        if self.answers.count != self.currentQuestion {
            if Int(result) == self.answers[currentQuestion] {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
