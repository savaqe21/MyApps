//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Fabian Leśniak on 05/08/2023.
//

import SwiftUI

struct ContentView: View {
    private let options = ["✊", "✋", "✌️"]
    
    @State private var winLoss = Bool.random()
    @State private var correnctOption = Int.random(in: 0...2)
    
    @State private var score = 0

    @State private var showAlertLose = false
    @State private var showAlertWin = false
    @State private var showAlertEnd = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .yellow]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                Spacer(minLength: 30)
                VStack{
                    Text("RockPaperScissors")
                        .foregroundStyle(.white)
                        .font(.title.weight(.heavy))
                    
                    Text("Choose the correct option")
                        .foregroundStyle(.yellow)
                        .font(.headline.weight(.heavy))
                }
                .padding()
                
                HStack{
                    VStack{
                        Text("Choice of AI")
                            .foregroundStyle(.white)
                            .font(.title2.weight(.heavy))
                        
                        Text("\(options[correnctOption])")
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.heavy))
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(5)
                    
                    VStack{
                        Text("You have to")
                            .foregroundStyle(.white)
                            .font(.title2.weight(.heavy))
                        
                        Text(winLoss == true ? "WIN" : "LOSS")
                            .foregroundStyle(winLoss == true ? .green : .red)
                            .font(.largeTitle.weight(.heavy))
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(5)
                }
                .padding()
                
                VStack{
                    Spacer()
                    
                    Text("Your score is")
                        .foregroundStyle(.white)
                        .font(.title.weight(.heavy))
                        .padding(.bottom)
                    
                    Text("\(score)/10")
                        .foregroundStyle(.purple)
                        .font(.largeTitle.weight(.heavy))
                        .padding(.top)
                    
                    Spacer()
                    
                }
                .padding()
                
                HStack {
                    ForEach (0..<3 ) { number in
                        Button {
                            game(number)
                        } label: {
                            Text("\(options[number])")
                        }
                        .font(.system(size: 60))
                        .buttonStyle(.bordered)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 40)
            }
            
        }
        .alert("Try again!", isPresented: $showAlertLose) {
            Button("OK", role: .cancel) { gameContinue() }
            Button("Restart", role: .destructive){ gameReset()  }
        } message: {
            Text("You have chosen a bad option.")
        }
        .alert("Good job!", isPresented: $showAlertWin) {
            Button("OK", role: .cancel) { gameContinue() }
            Button("Restart", role: .destructive){ gameReset()  }
        } message: {
            Text("You have chosen a good option.")
        }
        .alert("Good job!", isPresented: $showAlertEnd) {
            Button("Play again", role: .cancel){ gameReset() }
        } message: {
            Text("Your score is \(score)/10 you won the game!")
        }
    }
    
    func game(_ num: Int){
        if (correnctOption == num) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        } else if (correnctOption == 0 && winLoss == true && num == 1) {
            showAlertWin = true
            score += 1
        } else if (correnctOption == 0 && winLoss == true && num == 2) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        } else if (correnctOption == 0 && winLoss == false && num == 1) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        } else if (correnctOption == 0 && winLoss == false && num == 2) {
            showAlertWin = true
            score += 1
        } else if (correnctOption == 1 && winLoss == true && num == 0) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        } else if (correnctOption == 1 && winLoss == true && num == 2) {
            showAlertWin = true
            score += 1
        } else if (correnctOption == 1 && winLoss == false && num == 0) {
            showAlertWin = true
            score += 1
        } else if (correnctOption == 1 && winLoss == false && num == 2) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        } else if (correnctOption == 2 && winLoss == true && num == 0) {
            showAlertWin = true
            score += 1
        } else if (correnctOption == 2 && winLoss == true && num == 1) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        } else if (correnctOption == 2 && winLoss == false && num == 0) {
            showAlertLose = true
            if (score > 0) {
                score -= 1
            }
        }
        else if (correnctOption == 2 && winLoss == false && num == 1) {
            showAlertWin = true
            score += 1
        }
    }
    
    func gameContinue() {
        winLoss = Bool.random()
        correnctOption = Int.random(in: 0...2)
        if score == 10 {
            showAlertEnd = true
        }
    }
    
    func gameReset() {
        winLoss = Bool.random()
        correnctOption = Int.random(in: 0...2)
        score = 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
