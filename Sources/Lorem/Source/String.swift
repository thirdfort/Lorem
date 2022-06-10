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
        Composed(L.Data.words.randomElement()!, count, separator: separator)
    }

    /// Returns a placeholder for representing a title
    static var title: String {
        let wordsInTitle = (2...7).randomElement()!
        return words(wordsInTitle).capitalized
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

    /// Returns a placeholder for representing a single sentence
    static var sentence: String {
        let wordsInSentence = (4...16).randomElement()!
        return Composed(word, wordsInSentence, separator: " ", terminator: ".").capitalizingFirstLetter
    }

    /// Returns a placeholder for representing the specified number of sentences
    /// - Parameters:
    ///   - count: The number of times a sentence should be generated
    ///   - separator: The separator to use when composing these sentences
    static func sentences(_ count: Int, separator: String = " ") -> String {
        Composed(sentence, count, separator: separator)
    }

    /// Returns a placeholder for representing a single paragraph
    static var paragraph: String {
        let sentencesInParagraph = (3...9).randomElement()!
        return sentences(sentencesInParagraph)
    }

    /// Returns a placeholder for representing the specified number of paragraphs
    /// - Parameters:
    ///   - count: The number of times a paragraph should be generated
    ///   - separator: The separator to use when composing these paragraphs
    static func paragraphs(_ count: Int, separator: String = "\n") -> String {
        Composed(paragraph, count, separator: separator)
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

}
