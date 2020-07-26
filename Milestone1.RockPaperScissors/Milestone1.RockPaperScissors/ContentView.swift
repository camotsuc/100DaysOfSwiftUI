//
//  ContentView.swift
//  Milestone1.RockPaperScissors
//
//  Created by camotsuc on 26.07.2020.
//  Copyright © 2020 Robert Pliev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let gameTools = ["Rock", "Paper", "Scissors"]
    let gameToolsEmoji = ["🗿","🔖","✂️"]
    @State private var gameToolChoise = ""
    @State private var gameResultChoise = Bool.random()
    @State private var score = 0
    @State private var showAlert = false
    @State private var gameTool = ["Rock", "Paper", "Scissors"].randomElement()
    var resultChoise: String {
        if self.gameResultChoise == false {
            return "Lose"
        } else {
            return "Win"
        }
    }
    
    func restartGame() {
        if score == 10 {
            showAlert = true
            score = 0
        }
        gameResultChoise = Bool.random()
        gameTool = ["Rock", "Paper", "Scissors"].randomElement()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white,.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("App chooses \(gameTool ?? "") and you need to \(resultChoise)")
                VStack(spacing: 20) {
                    ForEach(0 ..< gameTools.count) { tool in
                        Button(action: {
                            self.checkResult(tool, self.gameTools.firstIndex(of: self.gameTool ?? "")!)
                        }) {
                            gameButtons(emojies: self.gameToolsEmoji[tool])
                        }
                    }
                }
                Text("Your score is \(score)")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Congrats,you won"), message: Text(""), dismissButton: .default(Text("Restart")) {
                
                })
        }
    }
    
    func checkResult(_ i: Int, _ gameTool: Int) {
        let index = i
        switch gameTool {
        case 2:
            if gameResultChoise && score <= 10 {
                if index == gameTool {
                    score += 0
                    restartGame()
                } else if index == gameTool - 1 {
                    score += 1
                    restartGame()
                } else if index == gameTool - 2 {
                    score += 1
                    restartGame()
                }
            }else if !gameResultChoise && score <= 10 {
                if index == gameTool {
                    score += 0
                    restartGame()
                } else if index == gameTool - 1 {
                    score -= 1
                    restartGame()
                } else if index == gameTool - 2 {
                    score += 1
                    restartGame()
                }
                break
            }
        default:
            if gameResultChoise && score <= 10{
                if index == gameTool {
                    score += 0
                    restartGame()
                } else if index == gameTool + 1 {
                    score += 1
                    restartGame()
                } else if index == gameTool + 2 {
                    score += 1
                    restartGame()
                }
                else if index ==  gameTool - 1 {
                    score += 1
                    restartGame()
                }
            } else if !gameResultChoise && score <= 10  {
                if index == gameTool {
                    score += 0
                    restartGame()
                } else if index == gameTool + 1 {
                    score += 1
                    restartGame()
                } else if index == gameTool + 2 {
                    score += 1
                    restartGame()
                } else if index ==  gameTool - 1 {
                    score += 1
                    restartGame()
                }
            }
        }
        if score == 10 {
            showAlert = true
            restartGame()
        }
    }
}
struct gameButtons: View {
    var emojies: String
    var body: some View {
        Text(emojies)
            .frame(width: 150, height: 150)
            .font(.system(size: 60))
            .border(Color.black, width: 5)
            .cornerRadius(10)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

