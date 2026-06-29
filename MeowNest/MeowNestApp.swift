import SwiftData
import SwiftUI

@main
struct MeowNestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            PlayerState.self,
            FurnitureItem.self,
            DailyTask.self
        ])
    }
}
