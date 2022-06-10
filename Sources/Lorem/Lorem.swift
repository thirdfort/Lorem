import SwiftUI

/// Represents a namespace for placeholder content
public struct Lorem<Content>: RawRepresentable {
    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

/// Provides SwiftUI support
extension Lorem: View where Content == Text {
    public var body: some View {
        Text(rawValue)
    }
}
