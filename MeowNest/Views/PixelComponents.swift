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

struct CatPlaceholder: View {
    let isHappy: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 1.0, green: 0.88, blue: 0.70))
                .frame(width: 138, height: 118)
                .offset(y: 26)

            Circle()
                .fill(Color(red: 1.0, green: 0.92, blue: 0.78))
                .frame(width: 150, height: 132)

            Circle()
                .fill(Color(red: 0.94, green: 0.55, blue: 0.14))
                .frame(width: 58, height: 42)
                .offset(x: -35, y: -38)

            Triangle()
                .fill(Color(red: 1.0, green: 0.92, blue: 0.78))
                .frame(width: 42, height: 42)
                .offset(x: -50, y: -72)

            Triangle()
                .fill(Color(red: 1.0, green: 0.92, blue: 0.78))
                .frame(width: 42, height: 42)
                .offset(x: 50, y: -72)

            HStack(spacing: 38) {
                Circle().fill(PixelPalette.ink).frame(width: 14, height: 14)
                Circle().fill(PixelPalette.ink).frame(width: 14, height: 14)
            }
            .offset(y: -8)

            Text(isHappy ? "ᴗ" : "ω")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(PixelPalette.ink)
                .offset(y: 16)

            HStack(spacing: 78) {
                Circle().fill(Color.pink.opacity(0.45)).frame(width: 18, height: 12)
                Circle().fill(Color.pink.opacity(0.45)).frame(width: 18, height: 12)
            }
            .offset(y: 18)
        }
        .frame(width: 190, height: 190)
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
                .fill(item.color.opacity(0.9))
                .frame(width: size, height: size)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(PixelPalette.border, lineWidth: 2)
                )

            Image(systemName: item.systemImage)
                .font(.system(size: size * 0.42, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}
