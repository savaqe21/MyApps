//
//  ContentView.swift
//  MultiplyQuest
//
//  Created by Fabian Leśniak on 20/08/2023.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var answerIsFocus: Bool
    
    @State private var isVisible = false
    @State private var alertTitle = ""
    
    @State private var score = 0
    
    private let digit = [1,2,3,4,5,6,7,8,9,10]
    @State private var x = 0
    @State private var y = 0
    @State private var answer = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .green]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("MultiplyQuest")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.heavy))
                    .padding(.bottom, 3)
                
                Text("Solve the equation")
                    .foregroundStyle(.indigo)
                    .font(.title3.weight(.bold))
                
                Spacer()
                VStack {
                    Text("You'r equation is")
                        .foregroundStyle(.indigo)
                        .font(.title.weight(.heavy))
                    
                    HStack {
                        Text("\(x) x \(y)")
                            .foregroundStyle(.white)
                            .font(.title.weight(.bold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    
                    VStack {
                        Text("Enter you'r answer :")
                            .foregroundStyle(.indigo)
                            .font(.title.weight(.bold))
                        TextField("Answer is...", value: $answer, formatter: NumberFormatter())
                            .border(.secondary)
                            .foregroundStyle(.white)
                            .font(.title)
                            .keyboardType(.decimalPad)
                            .focused($answerIsFocus)
                    }
                    .padding()
                        
                }
                .padding()
                VStack {
                    Text("You'r score")
                        .foregroundStyle(.indigo)
                        .font(.title2.weight(.heavy))
                    
                    Text("\(score)/10")
                        .foregroundStyle(.white)
                        .font(.title.weight(.heavy))
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                
                Spacer()
                HStack {
                    Spacer()
                    Button("Restart game", role: .destructive){
                        restartGame()
                    }
                    .font(.title2)
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    Button("Next example"){
                        skipQuestion()
                    }
                    .font(.title2)
                    .buttonStyle(.bordered)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear{
            startGame()
        }
        .alert(alertTitle, isPresented: $isVisible) {
                    Button("OK", role: .cancel) {
                        answer = 0
                    }
                }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    answerIsFocus = false
                    isCorrect()
                }
            }
        }
    }
    func startGame() {
        x = digit.randomElement() ?? 0
        y = digit.randomElement() ?? 0
    }
    
    func isCorrect() {
        if x*y == answer {
            score += 1
            alertTitle = "Correct"
            isVisible = true
            x = digit.randomElement() ?? 0
            y = digit.randomElement() ?? 0
        } else {
            score -= 1
            alertTitle = "Wrong"
            isVisible = true
            x = digit.randomElement() ?? 0
            y = digit.randomElement() ?? 0
        }
        
        if score == 10 {
            alertTitle = "You won"
            isVisible = true
            restartGame()
        }
    }
    
    func skipQuestion() {
        x = digit.randomElement() ?? 0
        y = digit.randomElement() ?? 0
        score -= 1
    }
    
    func restartGame() {
        x = digit.randomElement() ?? 0
        y = digit.randomElement() ?? 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
