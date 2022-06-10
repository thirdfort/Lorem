import SwiftUI

@available(iOS 15, *)
@available(tvOS 15, *)
@available(watchOS 8, *)
@available(macOS 12, *)
public extension Lorem where Content: View {

    /// Returns an async placeholder image that uses the `picsum.photos` API
    /// - Parameters:
    ///   - source: The image source to use for fetching the placeholder
    ///   - size: The desired size, for both the width and height dimencions, for this placeholder
    ///   - grayscale: If `true`, the placeholder will be returned as a grayscale image
    ///   - transcation: The transaction to use when the phase changes.
    ///   - content: A closure that takes the load phase as an input, and returns the view to display for the specified phase.
    static func asyncImage(source: ImageSource = .random, size: CGFloat, grayscale: Bool = false, transcation: Transaction = .init(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) -> some View {
        let url = Lorem<URL>.image(source: source, size: size, grayscale: grayscale)
        return AsyncImage(url: url, transaction: transcation, content: content)
    }

    /// Returns an async placeholder image that uses the `picsum.photos` API
    /// - Parameters:
    ///   - source: The image source to use for fetching the placeholder
    ///   - size: The desired size for this placeholder
    ///   - grayscale: If `true`, the placeholder will be returned as a grayscale image
    ///   - transcation: The transaction to use when the phase changes.
    ///   - content: A closure that takes the load phase as an input, and returns the view to display for the specified phase.
    static func asyncImage<C: View>(source: ImageSource = .random, size: CGSize, grayscale: Bool = false, transcation: Transaction = .init(), @ViewBuilder content: @escaping (AsyncImagePhase) -> C) -> some View {
        let url = Lorem<URL>.image(source: source, size: size, grayscale: grayscale)
        return AsyncImage(url: url, transaction: transcation, content: content)
    }

}

public extension Lorem where Content == Image {

    /// Returns a placeholder rectangle representing an image using the `systemGray4` color on iOS and `gray` otherwise
    static var image: some View { image() }

    /// Returns a placeholder rectangle representing an image, at the specified aspect ratio
    /// - Parameters:
    ///   - ratio: The aspect ratio to apply to this placeholder
    ///   - color: The color to apply to this placeholder. Defaults to `systemGray4`
    static func image(ratio: CGFloat? = nil, color: Color? = nil) -> some View {
        Rectangle()
#if os(iOS)
            .foregroundColor(color ?? .init(.systemGray4))
#else
            .foregroundColor(color ?? .init(.gray))
#endif
            .aspectRatio(ratio, contentMode: .fit)
    }
}

/// Represents various image source's
public enum ImageSource {
    /// Generates a random image
    case random
    /// Generates a random image, however the image returned will always be the same for this seed
    case seed(CustomStringConvertible)
}
