// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "RegexUtil",
    platforms: [.macOS(.v10_10)],
    products: [
        .library(name: "RegexUtil", targets: ["RegexUtil"])
    ],
    targets: [
        .target(
            name: "RegexUtil",
            path: "Sources"
        )
    ]
)
