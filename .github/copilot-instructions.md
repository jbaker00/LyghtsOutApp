# Copilot Instructions for LyghtsOutApp

Summary
- Minimal SwiftUI iOS app for signing up users and sending email via MessageUI.

Build
- Open the Xcode project in Xcode: open LyghtsOutApp.xcodeproj
- Command-line build (works without workspace):
  xcodebuild -project LyghtsOutApp.xcodeproj -scheme LyghtsOutApp -sdk iphonesimulator -configuration Debug build

Run (Simulator)
- From Xcode: select a simulator and run the app.
- From command line, to launch tests or run on a specific simulator use xcodebuild with -destination.

Tests
- This repo does not include test targets. If tests are added, run the full test suite with:
  xcodebuild test -project LyghtsOutApp.xcodeproj -scheme LyghtsOutApp -destination 'platform=iOS Simulator,name=iPhone 14'
- To run a single test (replace TestTarget/TestClass/testMethod):
  xcodebuild test -project LyghtsOutApp.xcodeproj -scheme LyghtsOutApp -destination 'platform=iOS Simulator,name=iPhone 14' -only-testing:TestTarget/TestClass/testMethod

Lint
- No linting configuration is included. To add SwiftLint, install it and run:
  swiftlint

High-level architecture
- Entry point: LyghtsOutApp.swift (App) creates a WindowGroup and shows ContentView.
- ContentView.swift: simple NavigationView that hosts SignupView.
- SignupView.swift: main UI for collecting name, email, phone, session type and notes; builds email body and triggers MailView or mailto: fallback.
- MailView.swift: UIViewControllerRepresentable wrapper around MFMailComposeViewController that handles delegate callbacks.
- Info.plist: basic app metadata and CFBundleIcons references an icon named `lyghtsout` (update Assets or app bundle accordingly).
- Assets: this repo does not include an Assets.xcassets AppIcon set; production apps should add an AppIcon asset with required sizes and update project settings.

Key conventions and repo-specific notes
- contactEmail constant (SignupView.swift) must be updated to the real recipient before distribution.
- profileImageURL in SignupView is intentionally a remote placeholder; prefer adding images to Assets.xcassets for offline reliability.
- UI helpers: SignupView defines local helpers (cardSection, inputRow, sectionHeader, label) used throughout; follow those patterns when adding views.
- Mail handling: uses MessageUI when available, falls back to mailto: URL if MFMailComposeViewController can't send mail.
- App icon: Info.plist's CFBundleIconFiles includes `lyghtsout`; to display a proper icon, add lyghtsout.jpg/png to the app bundle or, preferably, create an AppIcon set in Assets.xcassets and update Info.plist/project settings.
- Minimal project: the repo provides Swift source and Info.plist but no .xcodeproj with signing, schemes or Asset catalogs — import into an Xcode project and configure bundle identifier, signing team, and assets before release.

Where to look next
- README.md contains usage notes and reminders (replace contactEmail, add assets).

Other AI assistant configs
- No CLAUDE.md, .cursorrules, AGENTS.md, .windsurfrules, or AIDER/CLINE config files were found in the repository root.

MCP servers
- Would you like help configuring any MCP servers (e.g., device/simulator test runners) for this iOS project?

Summary
- Created .github/copilot-instructions.md describing build/test commands, architecture, and repo-specific conventions. If you want additional sections (e.g., release checklist, icon asset generation scripts), say which one to add.
