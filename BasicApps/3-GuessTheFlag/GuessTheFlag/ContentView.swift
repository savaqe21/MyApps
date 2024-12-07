//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fabian Leśniak on 29/07/2023.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 21)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingResult = false
    @State private var resultTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .indigo]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("GuessTheFlag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                            .foregroundColor(.indigo)
                        Text(countries[correctAnswer])
                            .font(.title.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    
                    ForEach (0..<3 ) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .modifier(FlagImage())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Button("Restart", role: .destructive, action: reset)
                    .buttonStyle(.bordered)
                    .padding(1)
                    .font(.title3.weight(.semibold))
            }
            .padding()
        }
        .alert(resultTitle, isPresented: $showingResult) {
            Button("Play again", role: .cancel, action: reset)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 5
            contin()
        } else {
            score -= 5
            contin()
        }
        
        if score >= 30 {
            resultTitle = "You won"
            showingResult = true
        } else if score <= -10 {
            resultTitle = "You lose"
            showingResult = true
        }
        
    }
    
    func contin() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
