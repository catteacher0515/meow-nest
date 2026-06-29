import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [PlayerState]
    @Query private var furniture: [FurnitureItem]
    @Query private var tasks: [DailyTask]

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("小屋", systemImage: "house.fill")
                }

            TodayView()
                .tabItem {
                    Label("今日", systemImage: "checkmark.seal.fill")
                }

            RoomView()
                .tabItem {
                    Label("房间", systemImage: "sofa.fill")
                }

            ShopView()
                .tabItem {
                    Label("商店", systemImage: "cart.fill")
                }
        }
        .task {
            SeedData.ensureSeeded(
                context: modelContext,
                players: players,
                furniture: furniture,
                tasks: tasks
            )
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [
            PlayerState.self,
            FurnitureItem.self,
            DailyTask.self
        ], inMemory: true)
}
