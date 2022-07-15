import SwiftUI

@available(iOS 13, tvOS 13, macOS 11, watchOS 6, *)
public extension Lorem where Content == String {
    /// Returns a random SF-Symbol image name
    static var systemImage: String {
        Symbol.names.randomElement() ?? ""
    }
}
