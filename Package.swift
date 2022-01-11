// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "SmartCalling",
  platforms: [
    .iOS(.v12)
  ],
  products: [
    .library(name: "SmartCalling", targets: ["SmartCalling"])
  ],
  targets: [
    .binaryTarget(
      name: "SmartCalling",
      url: "https://github.com/Smartcalling/SmartCalling-iOS/releases/download/1.6.0/SmartCalling.zip",
      checksum: "6b07b3c2678a641d934f8788cbb8227580b55783c81e38bc128c9e7f2fd1d8cb"
    )
  ]
)
