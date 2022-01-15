//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kiselov, Oleksandr on 1/13/22.
//

import SwiftUI

struct ContentView: View {
    let maxQuestions = 8
    @State private var showingScore = false
    @State private var questionCount = 1
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
                                    "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isAnimated = false
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        // .foregroundColor(.white)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImageView(country: countries[number])
                                .opacity(isAnimated && number != correctAnswer ? 0.25 : 1.0)
                                .rotation3DEffect(isAnimated && number == correctAnswer ? .degrees(360) : .degrees(0),
                                                  axis: (0, 1, 0))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func flagTapped(_ number: Int) {
        withAnimation {
            isAnimated = true
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            score = max(0, score-1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            showingScore = true
        })
    }
    func askQuestion() {
        isAnimated = false
        if questionCount == 0 {
            score = 0
        }
        questionCount += 1
        if questionCount > maxQuestions {
            restart()
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func restart() {
        scoreTitle = "Press Continue to restart"
        showingScore = true
        questionCount = 0
        isAnimated = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
