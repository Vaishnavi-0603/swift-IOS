# Assignment I: MatchMarkers
## CS193P iOS Application Development — Spring 2025

---

## Overview

This project implements the **MatchMarkers** SwiftUI view for the CodeBreaker game, as required in Assignment 1 of CS193P (Stanford iOS Application Development).

**MatchMarkers** displays the result of a player's guess in a CodeBreaker-style game, showing how many pegs were:
- **Exact** — correct color in the correct position (large filled dot)
- **Inexact** — correct color but wrong position (small filled dot)
- **No Match** — color not in the secret code (small empty/outlined dot)

---

## Required Tasks — Completion Status

| # | Task | Status |
|---|------|--------|
| 1 | Get the CodeBreaker app working as demonstrated in lecture (MatchMarkers view typed from scratch) | ✅ Done |
| 2 | Enhance `#Preview` of `MatchMarkers` to show dummy pegs next to it (`MatchMarkersPreview` helicopter view) | ✅ Done |
| 3 | Make `MatchMarkers` work for Arrays of 3, 4, 5, and 6 Match values | ✅ Done |
| 4 | Update `#Preview` to exercise many `Array<Match>` configurations with all Match types | ✅ Done |
| 5 | `#Preview` shows 3, 4, 5, or 6 dummy pegs matching the array size | ✅ Done |
| 6 | `#Preview` works in both Dark Mode and Light Mode | ✅ Done (uses `.primary` color) |

---

## Files

```
MatchMarkers/
├── MatchMarkersApp.swift     # @main app entry point
├── Match.swift               # Match enum (.exact, .inexact, .nomatch)
├── MatchMarkers.swift        # MatchMarkers View + MatchMarkersPreview + #Preview
├── ContentView.swift         # Main app screen demonstrating MatchMarkers in context
└── Info.plist                # App configuration

MatchMarkers.xcodeproj/      # Xcode project
Package.swift                # Swift Package (for reference)
```

---

## Key Design Decisions

### MatchMarkers View
- Two-column layout mirrors a real CodeBreaker peg board
- Sizes: large dot (18pt) for `.exact`, small dot (10pt) for `.inexact`/`.nomatch`
- Uses `Color.primary` so markers automatically adapt to Dark/Light Mode (Task 6)
- Supports 3–6 match values by computing `half = ceil(count/2)` for column split

### MatchMarkersPreview (Helicopter View)
- Per the hint: instead of adding repeated lines to `#Preview`, a dedicated "helicopter" view (`MatchMarkersPreview`) wraps dummy pegs and `MatchMarkers` together
- The number of dummy pegs always equals `matches.count` (Task 5)
- `#Preview` simply stacks multiple `MatchMarkersPreview` instances to exercise all configurations

### Match Enum
- Three cases: `.exact`, `.inexact`, `.nomatch`
- Plain Swift enum (no raw values needed — used only for pattern matching in `MatchMarkers`)

---

## How to Open in Xcode

1. Clone this repository
2. Open `MatchMarkers.xcodeproj` in **Xcode 16** (required)
3. Select an iPhone Simulator (iOS 17+)
4. Press **⌘R** to build and run
5. Open `MatchMarkers.swift` and click the **Preview** button to see the `#Preview` canvas

> ⚠️ Xcode 16 or later is required. Earlier versions will not work with Swift 6 syntax.

---

## Screenshots

The `#Preview` canvas will display multiple rows of:
- Colored dummy pegs (representing the player's guess)
- MatchMarker dots (representing exact/inexact/nomatch results)

...grouped by peg count (3, 4, 5, and 6 pegs), in both Light and Dark Mode.

---

*Assignment 1 — CS193P Spring 2025*
