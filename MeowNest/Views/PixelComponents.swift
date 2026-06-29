import SwiftUI

enum PixelPalette {
    static let background = Color(red: 0.95, green: 0.80, blue: 0.55)
    static let wall = Color(red: 0.96, green: 0.83, blue: 0.62)
    static let floor = Color(red: 0.70, green: 0.43, blue: 0.23)
    static let panel = Color(red: 1.00, green: 0.90, blue: 0.68)
    static let border = Color(red: 0.62, green: 0.37, blue: 0.18)
    static let ink = Color(red: 0.35, green: 0.20, blue: 0.11)
    static let secondaryInk = Color(red: 0.53, green: 0.36, blue: 0.22)
}

struct PixelRoomBackground: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                PixelPalette.wall

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 0.64, green: 0.82, blue: 0.90))
                    .frame(width: 124, height: 110)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(PixelPalette.border, lineWidth: 5)
                    )
                    .offset(x: 68, y: -58)

                Rectangle()
                    .fill(PixelPalette.border)
                    .frame(width: 5, height: 110)
                    .offset(x: 68, y: -58)

                Rectangle()
                    .fill(PixelPalette.border)
                    .frame(width: 124, height: 5)
                    .offset(x: 68, y: -58)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.48, green: 0.61, blue: 0.34))
                    .frame(width: 58, height: 90)
                    .offset(x: -118, y: -44)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.75, green: 0.50, blue: 0.27))
                    .frame(width: 150, height: 18)
                    .offset(x: -96, y: -102)
            }

            PixelPalette.floor
                .frame(height: 118)
                .overlay(
                    Ellipse()
                        .fill(Color(red: 0.58, green: 0.68, blue: 0.38))
                        .frame(width: 260, height: 104)
                        .offset(y: -22)
                )
        }
    }
}

struct RoomBaseImage: View {
    var body: some View {
        Image("room-base")
            .resizable()
            .scaledToFill()
    }
}

struct CatArtImage: View {
    let isHappy: Bool

    var body: some View {
        Image(isHappy ? "cat-happy" : "cat-default")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.16), radius: 8, y: 4)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct FurnitureToken: View {
    let item: FurnitureItem
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(PixelPalette.panel)
                .frame(width: size, height: size)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(PixelPalette.border, lineWidth: 2)
                )

            Image(item.assetName)
                .resizable()
                .scaledToFit()
                .padding(size * 0.08)
        }
    }
}
