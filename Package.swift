// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SDSAdMobView",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SDSAdMobView",
            targets: ["SDSAdMobView"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "11.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SDSAdMobView",
            dependencies: [.product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads",
                                    condition: .when(platforms: [.iOS]))]
        )
    ]
)
