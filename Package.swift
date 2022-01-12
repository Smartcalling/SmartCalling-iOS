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
      url: "https://github.com/Smartcalling/SmartCalling-iOS/releases/download/1.6.1/SmartCalling.zip",
      checksum: "447c005e66d2af0a29f917a77790fe2c937a7e7f7e765d63a8bc39628e5dc14a"
    )
  ]
)
