import SwiftUI

public protocol Palette {
    var color: Color { get }
}

public extension Palette where Self == RGB {
    /// Represents colors in the RGB range
    static var rgb: Self { .init() }
}

public extension Palette where Self == Grayscale {
    /// Represents colors in the `neutral` grayscale range
    static var grayscale: Self { .init(temperature: .neutral) }

    /// Represents colors in the grayscale range, using the specified temperature
    /// - Parameter temperature: The temperature of the value. Defaults to `neutral`
    static func grayscale(_ temperature: Grayscale.Temperature) -> Self { .init(temperature: temperature) }
}

public extension Palette where Self == System {
    /// Represents system colors on the current platform (e.g. systemRed, systemBlue, etc.). These colors are well suited for both light/dark modes (where applicable)
    static var system: Self { .init() }
}

public extension Palette where Self == HSB {
    /// Represents colors in the HSB range where the saturation is `0.6` and brightness is `0.9`
    static var hue: Self { .init(saturation: nil, brightness: nil) }

    /// Represents colors in the HSB range with the specified saturation and brightness
    /// - Parameters:
    ///   - saturation: The saturation value to apply in the range `0...1`. Defaults to `0.6`
    ///   - brightness: The brightness value to apply in the range `0...1`. Defaults to `0.9`
    static func hue(saturation: CGFloat? = nil, brightness: CGFloat? = nil) -> Self {
        .init(saturation: saturation, brightness: brightness)
    }
}

/// Represents colors in the RGB range
public struct RGB: Palette {
    public var color: Color {
        let r = (0...255).randomElement()!
        let g = (0...255).randomElement()!
        let b = (0...255).randomElement()!

        let red = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue = CGFloat(b) / 255

        return Color(red: red, green: green, blue: blue)
    }
}

/// Represents colors in the grayscale range
public struct Grayscale: Palette {
    public enum Temperature: Hashable {
        case warm
        case neutral
        case cool
    }

    let temperature: Temperature

    public var color: Color {
        let d = (5...250).randomElement()!
        let delta = CGFloat(d) / 255

        switch temperature {
        case .neutral:
            let b = (2...98).randomElement()!
            let delta = CGFloat(b) / 100
            return Color(white: delta)
        case .cool:
            return Color(red: delta - 0.005, green: delta + 0.016, blue: delta + 0.032)
        case .warm:
            return Color(red: delta + 0.016, green: delta + 0.016, blue: delta)
        }
    }
}

/// Represents system colors on the current platform (e.g. systemRed, systemBlue, etc.). These colors are well suited for both light/dark modes (where applicable)
public struct System: Palette {
    public var color: Color {
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

/// Represents colors in the HSB range
public struct HSB: Palette {
    let saturation: CGFloat?
    let brightness: CGFloat?

    public var color: Color {
        let h = (0...360).randomElement()!
        let hue = CGFloat(h) / 360
        return Color(hue: hue, saturation: saturation ?? 0.6, brightness: brightness ?? 0.9)
    }
}
