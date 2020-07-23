//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by bixbow on 21.07.2020.
//  Copyright © 2020 Robert Pliev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var tappedCountry = ""
    @State private var userScore = 0
    
    @State private var scoreTitle = ""
    
   
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Choose flag of ")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.tappedCountry = self.countries[number]
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Text("Your score is \(userScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        }
        
            
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("This is flag of \(tappedCountry)"), dismissButton: .default(Text("Countinue")) {
                self.askQuestion()
                })
        }
        
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            countries.shuffle()
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
