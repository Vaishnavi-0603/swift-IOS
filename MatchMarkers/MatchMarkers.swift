//
//  MatchMarkers.swift
//  MatchMarkers
//
//  CS193P iOS Application Development - Spring 2025
//  Assignment I: MatchMarkers
//
//  MatchMarkers is a SwiftUI View that displays the result of one guess row
//  in the CodeBreaker game. It shows match indicators (dots) based on the
//  Array<Match> passed to it.
//
//  Required Tasks addressed:
//    Task 1  - Core MatchMarkers view built from scratch
//    Task 2  - #Preview includes dummy pegs in a "helicopter" MatchMarkersPreview View
//    Task 3  - Works for 3, 4, 5, and 6 Match values
//    Task 4  - Preview exercises many Array<Match> configurations
//    Task 5  - Preview shows 3, 4, 5, or 6 dummy pegs matching array size
//    Task 6  - Adapts to Dark/Light Mode automatically via .primary color
//

import SwiftUI

// MARK: - MatchMarkers View

struct MatchMarkers: View {
    // The matches to display; supports 3 through 6 elements
    var matches: [Match]

    // Layout constants
    private let largeSize: CGFloat = 18
    private let smallSize: CGFloat = 10
    private let spacing: CGFloat = 4

    var body: some View {
        // Arrange markers in two columns, just like a real CodeBreaker peg board
        // First column: first half of matches
        // Second column: second half of matches
        let half = (matches.count + 1) / 2  // ceil(count / 2)

        HStack(spacing: spacing) {
            // Left column
            VStack(spacing: spacing) {
                ForEach(0..<half, id: \.self) { index in
                    markerView(for: matches[index])
                }
            }
            // Right column
            VStack(spacing: spacing) {
                ForEach(half..<matches.count, id: \.self) { index in
                    markerView(for: matches[index])
                }
                // If left column has one more item, pad right column with blank space
                if matches.count % 2 != 0 {
                    Spacer()
                        .frame(width: largeSize, height: largeSize)
                }
            }
        }
    }

    // Returns a single marker circle for the given Match value
    @ViewBuilder
    private func markerView(for match: Match) -> some View {
        switch match {
        case .exact:
            // Large filled circle — correct color, correct position
            Circle()
                .fill(Color.primary)
                .frame(width: largeSize, height: largeSize)
        case .inexact:
            // Small filled circle — correct color, wrong position
            Circle()
                .fill(Color.primary)
                .frame(width: smallSize, height: smallSize)
                .frame(width: largeSize, height: largeSize)  // center within large frame
        case .nomatch:
            // Small empty circle — color not present in code
            Circle()
                .stroke(Color.primary, lineWidth: 1.5)
                .frame(width: smallSize, height: smallSize)
                .frame(width: largeSize, height: largeSize)  // center within large frame
        }
    }
}

// MARK: - MatchMarkersPreview (Helicopter View)
//
// This "helicopter" view is used exclusively in the #Preview to show
// MatchMarkers in its "native environment" — surrounded by dummy pegs,
// just like it would appear in a real CodeBreaker game row.

struct MatchMarkersPreview: View {
    var matches: [Match]

    // Dummy peg colors — used only for preview context
    private let pegColors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
    // Large peg size (same visual scale as the real game pegs)
    private let pegSize: CGFloat = 36

    var body: some View {
        HStack(spacing: 8) {
            // Show one dummy peg per match slot (since each peg might be a Match,
            // you'd never have 5 pegs unless there were 5 spots)
            ForEach(0..<matches.count, id: \.self) { index in
                Circle()
                    .fill(pegColors[index % pegColors.count])
                    .frame(width: pegSize, height: pegSize)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
            }

            Spacer()

            // The actual MatchMarkers view — this is what we're previewing
            MatchMarkers(matches: matches)
                .padding(.horizontal, 4)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .systemBackground).opacity(0.001))  // transparent — inherits bg
        )
    }
}

// MARK: - #Preview
//
// Task 2: Enhanced preview shows dummy pegs next to MatchMarkers
// Task 3 & 4: Exercises Arrays of 3, 4, 5, and 6 Match values
//             with a variety of .exact, .inexact, .nomatch values
// Task 5: Number of dummy pegs matches the number of Match values
// Task 6: Works in both Dark Mode and Light Mode

#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 2) {
            // ── 4-peg configurations (standard CodeBreaker) ──
            Text("4 Pegs")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
                .padding([.top, .leading], 12)

            MatchMarkersPreview(matches: [.exact, .exact, .exact, .exact])
            MatchMarkersPreview(matches: [.exact, .exact, .exact, .inexact])
            MatchMarkersPreview(matches: [.exact, .exact, .inexact, .inexact])
            MatchMarkersPreview(matches: [.exact, .exact, .inexact, .nomatch])
            MatchMarkersPreview(matches: [.exact, .exact, .nomatch, .nomatch])
            MatchMarkersPreview(matches: [.exact, .inexact, .inexact, .nomatch])
            MatchMarkersPreview(matches: [.exact, .nomatch, .nomatch, .nomatch])
            MatchMarkersPreview(matches: [.inexact, .inexact, .inexact, .inexact])
            MatchMarkersPreview(matches: [.nomatch, .nomatch, .nomatch, .nomatch])

            Divider().padding(.horizontal, 12)

            // ── 3-peg configurations ──
            Text("3 Pegs")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
                .padding([.top, .leading], 12)

            MatchMarkersPreview(matches: [.exact, .exact, .exact])
            MatchMarkersPreview(matches: [.exact, .inexact, .nomatch])
            MatchMarkersPreview(matches: [.nomatch, .nomatch, .nomatch])

            Divider().padding(.horizontal, 12)

            // ── 5-peg configurations ──
            Text("5 Pegs")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
                .padding([.top, .leading], 12)

            MatchMarkersPreview(matches: [.exact, .exact, .exact, .exact, .exact])
            MatchMarkersPreview(matches: [.exact, .exact, .inexact, .inexact, .nomatch])
            MatchMarkersPreview(matches: [.nomatch, .nomatch, .nomatch, .nomatch, .nomatch])

            Divider().padding(.horizontal, 12)

            // ── 6-peg configurations ──
            Text("6 Pegs")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
                .padding([.top, .leading], 12)

            MatchMarkersPreview(matches: [.exact, .exact, .exact, .exact, .exact, .exact])
            MatchMarkersPreview(matches: [.exact, .exact, .exact, .inexact, .inexact, .nomatch])
            MatchMarkersPreview(matches: [.inexact, .inexact, .nomatch, .nomatch, .nomatch, .nomatch])
            MatchMarkersPreview(matches: [.nomatch, .nomatch, .nomatch, .nomatch, .nomatch, .nomatch])
        }
    }
}
