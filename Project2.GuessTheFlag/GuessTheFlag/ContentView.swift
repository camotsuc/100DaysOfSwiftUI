//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by camotsuc on 21.07.2020.
//  Copyright © 2020 Robert Pliev. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var tappedCountry = ""
    @State private var userScore = 0
    @State private var opacityAmount = 1.0
    @State private var rotationAmount = 0.0
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
                        FlagImage(image: self.countries[number])
                    }
                    .opacity(number == self.correctAnswer ? 1 : self.opacityAmount)
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotationAmount : 0),
                        axis: (x: 0, y: 1, z: 0))
                }
                Text("Your score is \(userScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                if showingScore == true {
                    Text("This was flag of \(tappedCountry)")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                }
                Spacer()
            }
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            countries.shuffle()
            rotationAmount = 0.0
            withAnimation(.interactiveSpring()) {
                self.opacityAmount = 0.25
            }
            withAnimation(.interpolatingSpring(stiffness: 30, damping: 15)) {
                self.rotationAmount = 360
            }
            askQuestion()
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
            showingScore = true
            askQuestion()
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation(.interactiveSpring()) {
            self.opacityAmount = 1
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
