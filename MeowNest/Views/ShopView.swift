import SwiftData
import SwiftUI

struct ShopView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [PlayerState]
    @Query(sort: \FurnitureItem.price) private var furniture: [FurnitureItem]

    private var player: PlayerState? { players.first }

    var body: some View {
        NavigationStack {
            ZStack {
                PixelPalette.background.ignoresSafeArea()

                List {
                    Section {
                        ResourceBar(player: player)
                            .listRowBackground(Color.clear)
                    }

                    Section("家具商店") {
                        ForEach(furniture) { item in
                            FurnitureShopRow(item: item, player: player) {
                                buy(item)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("商店")
        }
    }

    private func buy(_ item: FurnitureItem) {
        guard let player, !item.isUnlocked, player.coins >= item.price else { return }
        player.coins -= item.price
        item.isUnlocked = true
        player.toggleFurniture(item.id)
        try? modelContext.save()
    }
}

struct FurnitureShopRow: View {
    let item: FurnitureItem
    let player: PlayerState?
    let action: () -> Void

    var canBuy: Bool {
        guard let player else { return false }
        return !item.isUnlocked && player.coins >= item.price
    }

    var body: some View {
        HStack(spacing: 14) {
            FurnitureToken(item: item, size: 54)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(PixelPalette.ink)
                Text(item.isUnlocked ? "已拥有" : "\(item.price) 金币")
                    .font(.subheadline)
                    .foregroundStyle(PixelPalette.secondaryInk)
            }

            Spacer()

            Button(item.isUnlocked ? "已解锁" : "购买") {
                action()
            }
            .buttonStyle(.borderedProminent)
            .tint(item.isUnlocked ? .green : .orange)
            .disabled(!canBuy)
        }
        .padding(.vertical, 6)
    }
}
