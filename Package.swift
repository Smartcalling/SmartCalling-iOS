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
      url: "https://github.com/Smartcalling/SmartCalling-iOS/releases/download/1.6.2/SmartCalling.zip",
      checksum: "a5c9d8b7ab18e8e02f3a89bd549f5f3ff574d8659af92829ab4d8e16f6ae6cf4"
    )
  ]
)
