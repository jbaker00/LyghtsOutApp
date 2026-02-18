LyghtsOut iOS App (SwiftUI)

What this is
- A minimal SwiftUI signup app for LyghtsOut Lacrosse (version 1: email-based signups).
- Includes a SignupView that collects name, email, phone, session type, and notes, and sends a signup email.
- Uses a profile image (from the Instagram profile) as a starter graphic; replace or add more assets in Xcode's Assets.xcassets for production.

How to open
1. Open Xcode and create a new iOS App (App template) using SwiftUI and Swift.
2. Add the files in this folder (LyghtsOutApp/*.swift and Info.plist) to the new project (File > Add Files to "YourProject").
3. Set a valid bundle identifier and signing team in project settings.

Notes
- The app uses MessageUI to present an in-app mail composer when available; otherwise it opens the default Mail app via a mailto: link.
- Replace `contactEmail` in SignupView.swift with the real recipient email (the coach's email) before distributing.
- To use Instagram images directly, download images you have rights to and add them to Assets.xcassets or replace the placeholder remote URL in ContentView/SignupView.

Feedback
Tell me if you want a full, runnable .xcodeproj generated, or if you'd rather I commit these files into a new git repo structure and optionally add assets and a launch screen.