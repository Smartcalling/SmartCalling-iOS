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
      url: "https://github.com/Smartcalling/SmartCalling-iOS/releases/download/1.6.7/SmartCalling.zip",
      checksum: "e24b02690afbb9ba822df2bc3b80b29afd124842eed5e4fab3e011c28c5aadc4"
    )
  ]
)
