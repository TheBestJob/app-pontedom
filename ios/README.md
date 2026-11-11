# PonteDom for iOS

This folder contains the iOS application shell for the existing PonteDom mobile experience.

## Features
- Home, listings, map, property details, favorites and inquiries from the shared web app
- Polish / English / Italian localization from the shared app
- Persistent WebKit storage for favorites and language selection
- iOS back/forward gestures, external links in Safari and connection retry

The app loads https://thebestjob.github.io/app-pontedom/ and requires internet access. Updates to the shared app are visible in iOS without a new binary, subject to App Store rules. This is a WKWebView shell, not a separate native SwiftUI reimplementation.

## Build on macOS
1. Install Xcode and XcodeGen (brew install xcodegen).
2. From this directory run `xcodegen generate`.
3. Open `PonteDom.xcodeproj` in Xcode.
4. Select an iPhone simulator and run.
5. For a physical device or App Store submission, configure your own Apple Developer signing team and a unique bundle identifier.

## Important before App Store submission
Apple may reject apps that merely wrap a website under its minimum functionality guidelines. Add meaningful native iOS features before submission, test all flows on a real iPhone, provide proper app icons and screenshots, and review privacy disclosures and App Store rules. The shared site must remain reachable. No signed IPA is produced by this repository alone.
