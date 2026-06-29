import SwiftData
import SwiftUI

struct HomeView: View {
    @Query private var players: [PlayerState]
    @Query private var tasks: [DailyTask]
    @Query(sort: \FurnitureItem.name) private var furniture: [FurnitureItem]

    private var player: PlayerState? { players.first }
    private var task: DailyTask? { tasks.first }

    var body: some View {
        NavigationStack {
            ZStack {
                PixelPalette.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        ResourceBar(player: player)
                        RoomPreview(player: player, furniture: furniture)
                        TaskCard(task: task)
                        UnlockedShelf(player: player, furniture: furniture)
                    }
                    .padding(18)
                }
            }
            .navigationTitle("喵窝")
        }
    }
}

struct ResourceBar: View {
    let player: PlayerState?

    var body: some View {
        HStack(spacing: 10) {
            ResourcePill(icon: "heart.fill", value: player?.hearts ?? 0, tint: .pink)
            ResourcePill(assetName: "icon-coin", value: player?.coins ?? 0, tint: .orange)
            ResourcePill(assetName: "icon-star", value: player?.stars ?? 0, tint: .yellow)
        }
    }
}

struct ResourcePill: View {
    var icon: String?
    var assetName: String?
    let value: Int
    let tint: Color

    init(icon: String, value: Int, tint: Color) {
        self.icon = icon
        self.assetName = nil
        self.value = value
        self.tint = tint
    }

    init(assetName: String, value: Int, tint: Color) {
        self.icon = nil
        self.assetName = assetName
        self.value = value
        self.tint = tint
    }

    var body: some View {
        HStack(spacing: 6) {
            if let assetName {
                Image(assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
            } else if let icon {
                Image(systemName: icon)
                    .foregroundStyle(tint)
            }
            Text("\(value)")
                .font(.headline.monospacedDigit())
                .foregroundStyle(PixelPalette.ink)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(PixelPalette.panel)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(PixelPalette.border, lineWidth: 2)
        )
    }
}

struct RoomPreview: View {
    let player: PlayerState?
    let furniture: [FurnitureItem]

    var body: some View {
        ZStack {
            RoomBaseImage()

            VStack {
                Spacer()

                CatArtImage(isHappy: false)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 92)
            }
        }
        .frame(height: 420)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(PixelPalette.border, lineWidth: 3)
        )
    }
}

struct TaskCard: View {
    let task: DailyTask?

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task?.isCompleted == true ? "checkmark.seal.fill" : "star.square.fill")
                .foregroundStyle(task?.isCompleted == true ? .green : .orange)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(task?.title ?? "完成今天的一小步")
                    .font(.headline)
                    .foregroundStyle(PixelPalette.ink)
                Text(task?.isCompleted == true ? "今天的小屋已经收到奖励" : "完成后获得 30 金币")
                    .font(.subheadline)
                    .foregroundStyle(PixelPalette.secondaryInk)
            }

            Spacer()
        }
        .padding(16)
        .background(PixelPalette.panel)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(PixelPalette.border, lineWidth: 2)
        )
    }
}

struct UnlockedShelf: View {
    let player: PlayerState?
    let furniture: [FurnitureItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("已拥有家具")
                .font(.headline)
                .foregroundStyle(PixelPalette.ink)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(furniture.filter(\.isUnlocked)) { item in
                        FurnitureToken(item: item, size: 64)
                    }
                }
            }
        }
        .padding(16)
        .background(PixelPalette.panel.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
