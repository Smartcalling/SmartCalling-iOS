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
      url: "https://github.com/Smartcalling/SmartCalling-iOS/releases/download/1.5.1/SmartCalling.zip",
      checksum: "cd93b0c0940ae29be1de48683e9680e58e79f377a17a0b369bd18999c04a5673"
    )
  ]
)
