import SwiftData
import SwiftUI

struct RoomView: View {
    @Query private var players: [PlayerState]
    @Query(sort: \FurnitureItem.name) private var furniture: [FurnitureItem]

    private var player: PlayerState? { players.first }

    var body: some View {
        NavigationStack {
            ZStack {
                PixelPalette.background.ignoresSafeArea()

                VStack(spacing: 16) {
                    RoomPreview(player: player, furniture: furniture)
                        .padding(.horizontal, 18)

                    Text("当前小屋")
                        .font(.headline)
                        .foregroundStyle(PixelPalette.ink)

                    Text("已解锁家具会出现在这里，后续替换为真实像素素材。")
                        .font(.callout)
                        .foregroundStyle(PixelPalette.secondaryInk)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    Spacer()
                }
            }
            .navigationTitle("房间")
        }
    }
}
