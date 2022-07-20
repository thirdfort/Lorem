import Foundation

extension String {
    var capitalizingFirstLetter: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
}

public extension Lorem where Content == String {

    /// Composes strings, using the specified separator and terminator to generate more complex `String` representations
    /// - Parameters:
    ///   - value: An autoclosure that's excuted for each `count` allowing you to provide a unique string value to be composed
    ///   - count: The number of `value`'s to add to the composed `String`
    ///   - separator: The separator used to form the composed string
    ///   - terminator: The terminator used to suffix the string
    static func Composer(_ value: @autoclosure () -> String, count: Int, separator: String, terminator: String = "") -> Content {
        var result = ""

        for index in 0..<count {
            result += value()

            if (index < count - 1) {
                result += separator
            } else {
                result += terminator
            }
        }

        return result
    }
    /// Composes strings, using the specified separator and terminator to generate more complex `String` representations
    /// - Parameters:
    ///   - value: An autoclosure that's excuted for each `count` allowing you to provide a unique string value to be composed
    ///   - countRange: A `ClosedRange` where a random number is taken from to decide the number of `value`'s to add to the composed `String`
    ///   - separator: The separator used to form the composed string
    ///   - terminator: The terminator used to suffix the string
    static func Composer(_ value: @autoclosure () -> String, countRange: ClosedRange<Int>, separator: String, terminator: String = "") -> Content {
        var result = ""
        let count = countRange.randomElement() ?? 1

        for index in 0..<count {
            result += value()

            if (index < count - 1) {
                result += separator
            } else {
                result += terminator
            }
        }

        return result
    }

}
