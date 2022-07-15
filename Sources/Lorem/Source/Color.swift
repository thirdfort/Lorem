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
    static func color(_ palette: Palette) -> Content {
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
    static func color(_ palette: Palette) -> Content {
        .init(Lorem<Color>.color(palette))
    }

}
#endif

public extension Lorem where Content == Color {

    /// Returns a random placeholder color
    static var color: Content {
        RGB().color
    }

    /// Returns a placeholder color, generated from the specified palette
    /// - Parameter palette: The color palette used to generate the color
    static func color(_ palette: Palette) -> Content {
        palette.color
    }

}
