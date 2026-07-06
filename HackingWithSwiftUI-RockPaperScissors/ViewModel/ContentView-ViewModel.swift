//
//  ContentView-ViewModel.swift
//  HackingWithSwiftUI-RockPaperScissors
//
//  Created by Michael Jones on 06/07/2026.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        /// Creates a property to store the three possible moves as emojis (Rock, Paper and Scissors).
        let moves = ["🪨", "📰", "✂️"]
        
        /// A random Bool value to determine if the play should try to win or lose the game.
        var shouldWin: Bool = Bool.random()
        /// A random Int value to determine which move the computer has chosen.
        var computerChoice: Int = Int.random(in: 0...2)
        
        /// Keeps track of the players score.
        var playerScore = 0
        /// Keeps track on the number of questions asked.
        var questionCount = 1
        /// Property to keep track of when to show the alert once the question count has reached 10.
        var showingResults = false
        
        
        /// Handles the logic to if a score should be awarded or deducted from the 'playerScore'.
        /// - Parameter choice: The players choice.
        func play(_ choice: Int) {
            /// Winning moves (it is in reverse order of 'moves').
            let winningMoves = [1, 2, 0]
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
        
        /// A function to reset the game.
        func resetGame() {
            computerChoice = Int.random(in: 0...2)
            shouldWin = Bool.random()
            questionCount = 0
            playerScore = 0
        }
    }
}
