import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS)
@available(iOS 14, *)
@available(watchOS 7, *)
@available(tvOS 14, *)
public extension Lorem where Content == UIColor {

    /// Returns a random placeholder color
    static var color: Content {
        .init(Lorem<Color>.color)
    }

    /// Returns a placeholder color, generated from the specified palette
    /// - Parameter palette: The color palette used to generate the color
    static func color(_ palette: ColorPalette) -> Content {
        .init(Lorem<Color>.color(palette))
    }

}
#endif

#if os(macOS)
@available(macOS 11, *)
public extension Lorem where Content == NSColor {

    /// Returns a random placeholder color
    static var color: Content {
        .init(Lorem<Color>.color)
    }

    /// Returns a placeholder color, generated from the specified palette
    /// - Parameter palette: The color palette used to generate the color
    static func color(_ palette: ColorPalette) -> Content {
        .init(Lorem<Color>.color(palette))
    }

}
#endif

public extension Lorem where Content == Color {

    /// Returns a random placeholder color
    static var color: Content {
        ColorPalette.any.color
    }

    /// Returns a placeholder color, generated from the specified palette
    /// - Parameter palette: The color palette used to generate the color
    static func color(_ palette: ColorPalette) -> Content {
        palette.color
    }

}

/// Represents the available color palettes for generating consistent color values
public enum ColorPalette {
    /// Generates a RGB color value
    case any
    /// Generates a hue color value, using the specified saturation and brightness if provided
    /// - Parameter saturation: The saturation value to apply, in the range `0...1`. Defaults to a random value
    /// - Parameter brightness: The brightness value to apply, in the range `0...1`. Defaults to `0.9`
    case hue(saturation: CGFloat? = nil, brightness: CGFloat? = nil)
    /// Generates a grayscale color value
    case grayscale
    /// Generates a pre-defined system color value that's color-scheme aware. (e.g. blue, red, green, etc.)
    case system

    var color: Color {
        switch self {
        case .any:
            let r = (0...255).randomElement()!
            let g = (0...255).randomElement()!
            let b = (0...255).randomElement()!

            let red = CGFloat(r) / 255
            let green = CGFloat(g) / 255
            let blue = CGFloat(b) / 255

            return Color(red: red, green: green, blue: blue)
        case .hue(let saturation, let brightness):
            let h = (0...360).randomElement()!
            let s = (0...100).randomElement()!

            let hue = CGFloat(h) / 360
            let sat = CGFloat(s) / 100

            return Color(hue: hue, saturation: saturation ?? sat, brightness: brightness ?? 0.9)
        case .grayscale:
            let b = (5...95).randomElement()!
            let brightness = CGFloat(b) / 100
            return Color(hue: 1, saturation: 0, brightness: brightness)
        case .system:
#if os(iOS) || os(tvOS)
            var colors: [UIColor] = [
                .systemRed, .systemBlue, .systemPink, .systemTeal,
                .systemBrown, .systemIndigo, .systemOrange,
                .systemPurple, .systemIndigo, .systemGreen, .systemYellow
            ]

            if #available(iOS 15, tvOS 15, *) {
                colors.append(contentsOf: [.systemCyan, .systemMint])
            }

            return Color(colors.randomElement()!)
#elseif os(watchOS)
            var colors: [UIColor] = [
                .red, .green, .blue, .cyan, .yellow,
                .magenta, .orange, .purple, .brown
            ]

            return Color(colors.randomElement()!)
#else
            let colors: [NSColor] = [
                .systemRed, .systemGreen, .systemBlue, .systemOrange,
                .systemYellow, .systemBrown, .systemPink, .systemPurple,
                .systemMint, .systemTeal, .systemIndigo
            ]

            return Color(colors.randomElement()!)
#endif
        }
    }
}
