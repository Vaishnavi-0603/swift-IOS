//
//  ContentView.swift
//  MatchMarkers
//
//  CS193P iOS Application Development - Spring 2025
//  Assignment I: MatchMarkers
//
//  ContentView acts as the main screen of the app.
//  It demonstrates MatchMarkers in a scrollable list, showing
//  how the component looks inside a real application UI.
//

import SwiftUI

struct ContentView: View {
    // Sample game state — a few guess rows showing a variety of match patterns
    let sampleGuesses: [[Match]] = [
        [.exact, .exact, .exact, .exact],
        [.exact, .exact, .inexact, .nomatch],
        [.exact, .inexact, .inexact, .inexact],
        [.inexact, .inexact, .nomatch, .nomatch],
        [.nomatch, .nomatch, .nomatch, .nomatch],
    ]

    // Dummy peg colors for the game rows
    let pegColors: [[Color]] = [
        [.red, .red, .red, .red],
        [.red, .blue, .green, .yellow],
        [.orange, .red, .blue, .green],
        [.purple, .yellow, .red, .orange],
        [.blue, .blue, .green, .purple],
    ]

    private let pegSize: CGFloat = 40

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(hue: 0.6, saturation: 0.3, brightness: 0.15),
                             Color(hue: 0.7, saturation: 0.2, brightness: 0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Game board rows
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(0..<sampleGuesses.count, id: \.self) { row in
                                gameRow(
                                    pegs: pegColors[row],
                                    matches: sampleGuesses[row]
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                    }
                }
            }
            .navigationTitle("CodeBreaker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color(hue: 0.6, saturation: 0.3, brightness: 0.15),
                for: .navigationBar
            )
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    // A single game row: colored pegs on the left, MatchMarkers on the right
    @ViewBuilder
    private func gameRow(pegs: [Color], matches: [Match]) -> some View {
        HStack(spacing: 10) {
            // Peg circles
            HStack(spacing: 8) {
                ForEach(0..<pegs.count, id: \.self) { i in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [pegs[i].opacity(0.9), pegs[i].opacity(0.5)],
                                center: .topLeading,
                                startRadius: 2,
                                endRadius: pegSize
                            )
                        )
                        .frame(width: pegSize, height: pegSize)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 1, y: 2)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                }
            }

            Spacer()

            // MatchMarkers
            MatchMarkers(matches: matches)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ContentView()
}
