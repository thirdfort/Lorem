import Foundation

public extension Lorem where Content == String {
    typealias L = Lorem<Content>

    /// Returns a placeholder for representing a single word
    static var word: String {
        words(1)
    }

    /// Returns a placeholder for representing the specified number of words
    /// - Parameters:
    ///   - count: The number of times a word should be generated
    ///   - separator: The separator to use when composing these words
    static func words(_ count: Int, separator: String = " ") -> String {
        Composer(L.Data.words.randomElement()!, count: count, separator: separator)
    }

    /// Returns a placeholder for representing the specified number of words
    /// - Parameters:
    ///   - countRange: The number of times a word should be generated, the actual count will be a random value in the provided range
    ///   - separator: The separator to use when composing these words
    static func words(_ countRange: ClosedRange<Int>, separator: String = " ") -> String {
        Composer(L.Data.words.randomElement()!, countRange: countRange, separator: separator)
    }

    /// Returns a placeholder for representing a title, containing 2 to 5 words
    static var title: String {
        let wordsInTitle = (2...5).randomElement()!
        return words(wordsInTitle).capitalized
    }

    /// Returns a placeholder for representing a title, containing the specified number of words
    static func title(_ count: Int) -> String {
        words(count).capitalized
    }

    /// Returns a placeholder for representing a title, containing the specified number of words
    /// - Parameter countRange: The number of times a word should be generated, the actual count will be a random value in the provided range
    static func title(_ countRange: ClosedRange<Int>) -> String {
        words(countRange).capitalized
    }

    /// Returns a placeholder for representing a person's first name
    static var firstName: String {
        L.Data.firstNames.randomElement()!
    }

    /// Returns a placeholder for representing a person's last name
    static var lastName: String {
        L.Data.lastNames.randomElement()!
    }

    /// Returns a placeholder for representing a person's name
    static var name: String {
        "\(firstName) \(lastName)"
    }

    /// Returns a placeholder for representing a single sentence, containing 5 to 10 words
    static var sentence: String {
        Composer(word, countRange: 5...10, separator: " ", terminator: ".").capitalizingFirstLetter
    }

    /// Returns a placeholder for representing the specified number of sentences
    /// - Parameters:
    ///   - count: The number of times a sentence should be generated
    ///   - separator: The separator to use when composing these sentences
    static func sentences(_ count: Int, separator: String = " ") -> String {
        Composer(sentence, count: count, separator: separator)
    }

    /// Returns a placeholder for representing the specified number of sentences
    /// - Parameters:
    ///   - countRange: The number of times a sentence should be generated, the actual count will be a random value in the provided range
    ///   - separator: The separator to use when composing these sentences
    static func sentences(_ countRange: ClosedRange<Int>, separator: String = " ") -> String {
        Composer(sentence, countRange: countRange, separator: separator)
    }

    /// Returns a placeholder for representing a single paragraph, containing 2 to 5 sentences
    static var paragraph: String {
        sentences(2...5)
    }

    /// Returns a placeholder for representing the specified number of paragraphs
    /// - Parameters:
    ///   - count: The number of times a paragraph should be generated
    ///   - separator: The separator to use when composing these paragraphs
    static func paragraphs(_ count: Int, separator: String = "\n") -> String {
        Composer(paragraph, count: count, separator: separator)
    }

    /// Returns a placeholder for representing the specified number of paragraphs
    /// - Parameters:
    ///   - count: The number of times a paragraph should be generated, the actual count will be a random value in the provided range
    ///   - separator: The separator to use when composing these paragraphs
    static func paragraphs(_ countRange: ClosedRange<Int>, separator: String = "\n") -> String {
        Composer(paragraph, countRange: countRange, separator: separator)
    }

    /// Returns a placeholder URL
    static var url: String {
        "http://" + L.Data.siteDomains.randomElement()! + "/"
    }

    /// Returns a placeholder email address
    static var email: String {
        let delimiter = ["", ".", "-", "_"].randomElement()!
        let domain = L.Data.emailDomains.randomElement()!
        return (firstName + delimiter + lastName + "@" + domain).lowercased()
    }

    /// Returns a 140 character placeholder representing a tweet
    static var tweet: String {
        L.Data.tweets.randomElement()!
    }

    /// Returns a set of placeholder keywords, containing 5 to 10 words
    static var keywords: String {
        Composer(word, countRange: 5...10, separator: ", ")
    }

    /// Returns a set of placeholder keywords for representing the specified number of words
    /// - Parameter count: The number of times a word should be generated
    static func keywords(_ count: Int) -> String {
        Composer(word, count: count, separator: ", ")
    }

    /// Returns a set of placeholder keywords for representing the specified number of words
    /// - Parameter countRange: The number of times a word should be generated, the actual count will be a random value in the provided range
    static func keywords(_ countRange: ClosedRange<Int>) -> String {
        Composer(word, countRange: countRange, separator: ", ")
    }

    /// Returns a placeholder date, within the past 20 years, using the ISO8601 format
    static var date: Content {
        date(within: 20, component: .year, format: .iso8601)
    }

    /// Returns a placeholder date, within the past 20 years, using the specified format
    /// - Parameter format: The format to apply to the date
    static func date(_ format: DateFormat) -> String {
        date(within: 20, component: .year, format: format)
    }

    /// Returns a placeholder date using the specified configuration
    /// - Parameters:
    ///   - value: The value to use to offset the calendar component
    ///   - component: The calendar component to offset
    ///   - locale: The locale the `Calendar` should use
    ///   - format: The format to apply to the date
    static func date(within value: Int, component: DateComponent, locale: Locale = .init(identifier: "en_US_POSIX"), format: DateFormat) -> String {
        let date = Lorem<Date>.date(within: value, component: component, locale: locale)
        return Lorem<Date>.formatter(format: format).string(for: date) ?? ""
    }

    /// Returns a placeholder age for an adult
    static var age: Content {
        age(for: .adult)
    }

    /// Returns a placeholder age within the specified age-group
    static func age(for group: AgeGroup) -> Content {
        let age = Lorem<Int>.age(for: group)
        return "\(age)"
    }

    /// Returns a placeholder age from the specified reference
    static func age(year: Int) -> Content {
        let age = Lorem<Int>.age(year: year)
        return "\(age)"
    }

}
