import SwiftData
import SwiftUI

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [PlayerState]
    @Query private var tasks: [DailyTask]

    private var player: PlayerState? { players.first }
    private var task: DailyTask? { tasks.first }

    var body: some View {
        NavigationStack {
            ZStack {
                PixelPalette.background.ignoresSafeArea()

                VStack(spacing: 22) {
                    CatArtImage(isHappy: task?.isCompleted == true)
                        .frame(height: 190)

                    VStack(spacing: 10) {
                        Text(task?.isCompleted == true ? "今天已经完成啦" : "今天只做一小步")
                            .font(.title2.bold())
                            .foregroundStyle(PixelPalette.ink)

                        Text(task?.title ?? "完成今天的一小步")
                            .font(.body)
                            .foregroundStyle(PixelPalette.secondaryInk)
                    }

                    Button {
                        completeTask()
                    } label: {
                        HStack {
                            Image(systemName: task?.isCompleted == true ? "checkmark.circle.fill" : "sparkles")
                            Text(task?.isCompleted == true ? "已领取奖励" : "完成并获得 30 金币")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(task?.isCompleted == true ? .green : .orange)
                    .disabled(task?.isCompleted == true)

                    Text(task?.isCompleted == true ? "小屋又变温暖了一点。" : "不需要很多，只要开始一下。")
                        .font(.callout)
                        .foregroundStyle(PixelPalette.secondaryInk)

                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("今日")
        }
    }

    private func completeTask() {
        guard let player, let task, !task.isCompleted else { return }
        task.isCompleted = true
        player.coins += task.rewardCoins
        player.stars += 1
        try? modelContext.save()
    }
}
