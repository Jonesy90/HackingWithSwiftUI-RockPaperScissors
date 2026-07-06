//
//  ContentView.swift
//  HackingWithSwiftUI-RockPaperScissors
//
//  Created by Michael Jones on 04/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Text("Computer has played...")
                .font(.headline)
            Text(viewModel.moves[viewModel.computerChoice])
                .font(.system(size: 200))
            
            if viewModel.shouldWin {
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
                    Button(String(viewModel.moves[move])) {
                        viewModel.play(move)
                    }
                }
                .font(.system(size: 80))
            }
            
            Spacer()
            
            Text("Score: \(viewModel.playerScore)")
                .font(.subheadline)
            
            Spacer()
        }
        .alert("Game Over!", isPresented: $viewModel.showingResults) {
            Button("Play Again?", action: viewModel.resetGame)
        } message: {
            Text("Your score was: \(viewModel.playerScore)")
        }
    }
}

#Preview {
    ContentView()
}
