import Foundation
import CoreGraphics

public extension Lorem where Content == URL {

    /// Returns a placeholde URL
    static var url: Content {
        .init(string: Lorem<String>.url)!
    }

    /// Returns a placeholder email address
    static var email: Content {
        .init(string: Lorem<String>.email)!
    }

    /// Returns a placeholder image URL using the `picsum.photos` API
    static var image: Content {
        image(source: .random, size: 300, grayscale: false)
    }

    /// Returns a placeholder image URL using the `picsum.photos` API
    /// - Parameters:
    ///   - source: The image source to specify when generating the URL
    ///   - size: The desired size, for both width and height, for this placeholder
    ///   - grayscale: If `true`, the URL will specify a grayscale variant should be provided
    static func image(source: ImageSource, size: CGFloat, grayscale: Bool) -> URL {
        image(source: source, size: .init(width: size, height: size), grayscale: grayscale)
    }

    /// Returns a placeholder image URL using the `picsum.photos` API
    /// - Parameters:
    ///   - source: The image source to specify when generating the URL
    ///   - size: The desired size for this placeholder
    ///   - grayscale: If `true`, the URL will specify a grayscale variant should be provided
    static func image(source: ImageSource, size: CGSize, grayscale: Bool) -> URL {
        var comps = URLComponents(string: "https://picsum.photos")!
        var queries: [URLQueryItem] = []

        if grayscale {
            queries.append(.init(name: "grayscale", value: nil))
        }

        comps.queryItems = queries

        var url = comps.url!

        switch source {
        case let .seed(seed):
            url.appendPathComponent("seed")
            url.appendPathComponent("\(seed)")
        case .random:
            break
        }

        return url
            .appendingPathComponent("\(Int(size.width))")
            .appendingPathComponent("\(Int(size.height))")
    }

}
