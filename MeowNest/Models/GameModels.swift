import Foundation
import SwiftData
import SwiftUI

@Model
final class PlayerState {
    var coins: Int
    var hearts: Int
    var stars: Int
    var selectedFurnitureIDs: String

    init(coins: Int = 120, hearts: Int = 5, stars: Int = 0, selectedFurnitureIDs: String = "lamp-green,pillow-yellow") {
        self.coins = coins
        self.hearts = hearts
        self.stars = stars
        self.selectedFurnitureIDs = selectedFurnitureIDs
    }

    var selectedIDs: Set<String> {
        get {
            Set(selectedFurnitureIDs.split(separator: ",").map(String.init))
        }
        set {
            selectedFurnitureIDs = newValue.sorted().joined(separator: ",")
        }
    }

    func toggleFurniture(_ id: String) {
        var ids = selectedIDs
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
        selectedIDs = ids
    }
}

@Model
final class FurnitureItem {
    @Attribute(.unique) var id: String
    var name: String
    var price: Int
    var systemImage: String
    var assetName: String
    var paletteName: String
    var isUnlocked: Bool

    init(id: String, name: String, price: Int, systemImage: String, assetName: String, paletteName: String, isUnlocked: Bool = false) {
        self.id = id
        self.name = name
        self.price = price
        self.systemImage = systemImage
        self.assetName = assetName
        self.paletteName = paletteName
        self.isUnlocked = isUnlocked
    }

    var color: Color {
        switch paletteName {
        case "sage":
            return Color(red: 0.56, green: 0.68, blue: 0.45)
        case "honey":
            return Color(red: 0.94, green: 0.70, blue: 0.28)
        case "wood":
            return Color(red: 0.63, green: 0.39, blue: 0.20)
        case "rose":
            return Color(red: 0.90, green: 0.48, blue: 0.54)
        default:
            return Color(red: 0.82, green: 0.64, blue: 0.42)
        }
    }
}

@Model
final class DailyTask {
    @Attribute(.unique) var id: String
    var title: String
    var rewardCoins: Int
    var isCompleted: Bool

    init(id: String = "daily-start", title: String = "完成今天的一小步", rewardCoins: Int = 30, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.rewardCoins = rewardCoins
        self.isCompleted = isCompleted
    }
}

enum SeedData {
    static func ensureSeeded(
        context: ModelContext,
        players: [PlayerState],
        furniture: [FurnitureItem],
        tasks: [DailyTask]
    ) {
        if players.isEmpty {
            context.insert(PlayerState())
        }

        if tasks.isEmpty {
            context.insert(DailyTask())
        }

        if furniture.isEmpty {
            furnitureSeeds.forEach { context.insert($0) }
        }

        try? context.save()
    }

    static var furnitureSeeds: [FurnitureItem] {
        [
            FurnitureItem(id: "lamp-green", name: "绿色台灯", price: 40, systemImage: "lamp.desk.fill", assetName: "furniture-lamp-green", paletteName: "sage", isUnlocked: true),
            FurnitureItem(id: "chair-green", name: "绿色单人椅", price: 80, systemImage: "chair.lounge.fill", assetName: "furniture-chair-green", paletteName: "sage"),
            FurnitureItem(id: "bookcase", name: "小书柜", price: 90, systemImage: "books.vertical.fill", assetName: "furniture-bookcase", paletteName: "wood"),
            FurnitureItem(id: "pillow-yellow", name: "黄色抱枕", price: 30, systemImage: "square.fill", assetName: "furniture-pillow-yellow", paletteName: "honey", isUnlocked: true),
            FurnitureItem(id: "plant", name: "小盆栽", price: 50, systemImage: "leaf.fill", assetName: "furniture-plant", paletteName: "sage"),
            FurnitureItem(id: "wall-art", name: "墙面挂画", price: 60, systemImage: "photo.fill", assetName: "furniture-wall-art", paletteName: "rose")
        ]
    }
}
