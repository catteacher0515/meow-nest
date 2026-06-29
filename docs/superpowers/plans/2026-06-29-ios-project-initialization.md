# iOS Project Initialization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a native SwiftUI iOS project skeleton for Meow Nest that can run the first MVP loop with local state.

**Architecture:** Use a minimal SwiftUI app with SwiftData models for player progress, furniture inventory, and task completion. Keep the first implementation local-only with no account, no backend, no IAP, and no CloudKit.

**Tech Stack:** Swift, SwiftUI, SwiftData, Xcode project, iOS 17+

---

### Task 1: Create Xcode Project Skeleton

**Files:**
- Create: `MeowNest.xcodeproj/project.pbxproj`
- Create: `MeowNest/MeowNestApp.swift`
- Create: `MeowNest/ContentView.swift`
- Create: `MeowNest/Assets.xcassets/Contents.json`
- Create: `MeowNest/Assets.xcassets/AccentColor.colorset/Contents.json`
- Create: `MeowNest/Assets.xcassets/AppIcon.appiconset/Contents.json`

- [ ] Create a standard iOS SwiftUI app target named `MeowNest`.
- [ ] Configure generated Info.plist, bundle identifier `com.catteacher0515.meownest`, iOS deployment target `17.0`, and Swift 5.
- [ ] Verify with `xcodebuild -list -project MeowNest.xcodeproj`.

### Task 2: Add Local MVP Domain Model

**Files:**
- Create: `MeowNest/Models/GameModels.swift`

- [ ] Add SwiftData models for `PlayerState`, `FurnitureItem`, and `DailyTask`.
- [ ] Include seed data helpers for the initial player state, furniture list, and daily task.
- [ ] Keep model fields minimal: coins, selected furniture IDs, task completion, furniture unlock state.

### Task 3: Build Four MVP Screens

**Files:**
- Create: `MeowNest/Views/HomeView.swift`
- Create: `MeowNest/Views/TodayView.swift`
- Create: `MeowNest/Views/RoomView.swift`
- Create: `MeowNest/Views/ShopView.swift`
- Modify: `MeowNest/ContentView.swift`

- [ ] Create tab navigation for Home, Today, Room, and Shop.
- [ ] Home shows resource counters, room preview, current task card, and quick actions.
- [ ] Today lets the user complete the daily task and gain coins.
- [ ] Room displays selected furniture as a warm pixel-room inspired composition.
- [ ] Shop lets the user spend coins to unlock furniture and updates local state.

### Task 4: Verify Build

**Files:**
- No new files.

- [ ] Run `xcodebuild -list -project MeowNest.xcodeproj`.
- [ ] Run `xcodebuild -project MeowNest.xcodeproj -scheme MeowNest -destination 'generic/platform=iOS Simulator' build`.
- [ ] Commit the project skeleton and MVP loop.

