//
//  Match.swift
//  MatchMarkers
//
//  CS193P iOS Application Development - Spring 2025
//  Assignment I: MatchMarkers
//
//  Defines the Match enum used in the CodeBreaker game.
//  A Match represents how well a guessed peg color matches the secret code.
//

import Foundation

// Match represents the result of comparing a guessed peg to the secret code:
//   .exact    - correct color in correct position (filled/large dot)
//   .inexact  - correct color but wrong position (filled/small dot)
//   .nomatch  - color not in the code at all (empty/small dot)
enum Match {
    case exact
    case inexact
    case nomatch
}
