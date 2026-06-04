//
//  ContentView.swift
//  HackingWithSwiftUI-RockPaperScissors
//
//  Created by Michael Jones on 04/06/2026.
//

import SwiftUI

struct ContentView: View {
    //TODO: Create a property to store the three possible moves: rock, paper, and scissors.
    let moves = ["🪨", "📰", "✂️"]
    
    //TODO: You’ll need to create two @State properties to store the app’s current choice and whether the player should win or lose.
    @State private var shouldWin: Bool = Bool.random() // A random Bool value to determine if the play should try to win or lose the game.
    @State private var computerChoice = Int.random(in: 0...2) // A random Int value to determine which move the computer has chosen.
    
    @State private var playerScore = 0 // Keeps track of the players score.
    @State private var questionCount = 1 // Keeps track of the number of questions asked.
    @State private var showingResults = false // Property keep track of when to show the alert once the question count has reached 10.
    
    var body: some View {
        //TODO: Create a VStack showing the player’s score, the app’s move, and whether the player should win or lose. You can use if shouldWin to return one of two different text views.
        VStack(spacing: 10) {
            Spacer()
            
            Text("Computer has played...")
                .font(.headline)
            Text(moves[computerChoice])
                .font(.system(size: 200))
            
            if shouldWin {
                Text("Which one wins?")
                    .foregroundStyle(.green)
                    .font(.title)
            } else {
                Text("Which on loses?")
                    .foregroundStyle(.red)
                    .font(.title)
            }
            
            HStack {
                ForEach(0..<3) { move in
                    Button(String(moves[move])) {
                        play(move)
                    }
                }
                .font(.system(size: 80))
            }
            
            Spacer()
            
            Text("Score: \(playerScore)")
                .font(.subheadline)
            
            Spacer()
        }
        .alert("Game Over!", isPresented: $showingResults) {
            Button("Play Again?", action: resetGame)
        } message: {
            Text("Your score was: \(playerScore)")
        }
    }
    
    /// Handles the logic to if a score should be awarded or deducted from the 'playerScore'.
    /// - Parameter choice: The players choice, taken from which they made (Rock, Paper or Scissors).
    private func play(_ choice: Int) {
        //TODO: ...look for a way to simplify your logic such as an array of which items beat each move. For example, if your moves array was ["Rock", "Paper", "Scissors"] your array of winning moves would be ["Paper", "Scissors", "Rock"].
        let winningMoves = [1, 2, 0] // The winning moves, it is the reverse order of 'moves'.
        var didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        
        if questionCount == 10 {
            showingResults = true
        } else {
            shouldWin = Bool.random()
            computerChoice = Int.random(in: 0...2)
            questionCount += 1
        }
    }
    
    private func resetGame() {
        computerChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        questionCount = 0
        playerScore = 0
    }
}

#Preview {
    ContentView()
}
