//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Akhmed on 24.08.23.
//

import SwiftUI

enum GameState {
    case ongoing, win, lose
}

struct ContentView: View {
    @State private var choices = ["👊", "✋", "✌️"]
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var userScore = 0
    @State private var round = 1
    @State private var gameState: GameState = .ongoing
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.5, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.55, blue: 0.16), location: 0.3)
            ], center: .top, startRadius: 700, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Text("Раунд \(round) / 10")
                    .font(.headline)
                    .padding()
                
                Text("Выбор приложения:")
                    .font(.largeTitle)
                    .padding()
                Text(choices[appChoice])
                    .font(.system(size: 60))
                    .padding()
                    .background(.regularMaterial)
                    .foregroundStyle(.secondary)
                    .clipShape(Circle())
                
                Text("Вам нужно \(shouldWin ? "проиграть" : "победить")!")
                    .font(.headline)
                    .padding()
                
                if gameState == .ongoing {
                    HStack {
                        ForEach(0..<3) { number in
                            Button(action: {
                                userTapped(number)
                            }) {
                                Text(choices[number])
                                    .font(.system(size: 60))
                                    .padding()
                                    .background(.regularMaterial)
                                    .foregroundStyle(.secondary)
                                    .clipShape(Circle())
                            }
                            .disabled(gameState != .ongoing)
                        }
                    }
                } else {
                    Text(gameState == .win ? "Вы выиграли!" : "Вы проиграли.")
                        .font(.title)
                        .padding()
                }
                
                Text("Счет: \(userScore)")
                    .font(.title)
                    .padding()
                
                if round > 10 || gameState != .ongoing {
                    Button(action: restartGame) {
                        Text("Играть снова")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func userTapped(_ number: Int) {
        if (shouldWin && (number + 1) % 3 == appChoice) ||
            (!shouldWin && (appChoice + 1) % 3 == number) {
            userScore += 1
            gameState = .win
        } else {
            gameState = .lose
        }
        
        nextRound()
    }
    
    func nextRound() {
        if round < 10 {
            appChoice = Int.random(in: 0..<3)
            shouldWin = Bool.random()
            round += 1
            gameState = .ongoing
        } else {
            gameState = userScore >= 5 ? .win : .lose
        }
    }
    
    func restartGame() {
        round = 1
        userScore = 0
        nextRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}









