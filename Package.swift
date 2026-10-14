// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Note: This Package.swift is provided for reference only.
// The actual project is built using Xcode (MatchMarkers.xcodeproj).

import PackageDescription

let package = Package(
    name: "MatchMarkers",
    platforms: [
        .iOS(.v17)
    ],
    targets: [
        .target(
            name: "MatchMarkers",
            path: "MatchMarkers"
        )
    ]
)
