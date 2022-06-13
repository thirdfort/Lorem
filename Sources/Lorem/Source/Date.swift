import Foundation

public extension Lorem where Content == Date {

    /// Returns a placeholder date within the past `20` years
    static var date: Date {
        date(within: 20, component: .year)
    }

    /// Returns a placeholder date within the specified calendar component value
    /// - Parameters:
    ///   - value: The value to use to offset the calendar component
    ///   - component: The calendar component to offset
    ///   - locale: The locale the `Calendar` should use
    static func date(within value: Int, component: DateComponent, locale: Locale = .init(identifier: "en_US_POSIX")) -> Date {
        let upper = Date()
        var calendar = Calendar.current
        calendar.locale = locale
        var components = DateComponents()

        switch component {
        case .minute:
            components.minute = -value
        case .hour:
            components.hour = -value
        case .day:
            components.day = -value
        case .week:
            components.weekOfYear = -value
        case .month:
            components.month = -value
        case .year:
            components.year = -value
        }

        let lower = calendar.date(byAdding: components, to: upper) ?? Date()
        let timeInterval = upper.timeIntervalSince(lower)
        let random = (0...Int(timeInterval)).randomElement()!
        return lower.addingTimeInterval(TimeInterval(random))
    }

    internal static func formatter(format: DateFormat) -> Formatter {
        let key = DateFormatKey(style: format)

        if let formatter = formatterCache[key] {
            return formatter
        }

        let formatter = format.formatter
        formatterCache[key] = formatter
        return formatter
    }
}

private var formatterCache: [DateFormatKey: Formatter] = [:]
private struct DateFormatKey: CustomStringConvertible, Hashable {
    var description: String

    init(style: DateFormat) {
        switch style {
        case .iso8601:
            description = "iso8601"
        case let .formatted(format):
            description = format
        case let .styled(date, time):
            description = "\(date)-\(time)"
        case let .relative(style):
            description = "\(style)"
        case .custom:
            description = "custom"
        }
    }
}

/// Represents various date styles
public enum DateStyle: String {
    /// Excludes the date part.
    case omitted
    /// Shows date components in their numeric form. For example, "10/21/2015".
    case numeric
    /// Shows date components in their abbreviated form if possible. For example, "Oct 21, 2015".
    case abbreviated
    /// Shows date components in their long form if possible. For example, "October 21, 2015".
    case long
    /// Shows the complete day. For example, "Wednesday, October 21, 2015".
    case complete

    internal var style: DateFormatter.Style {
        switch self {
        case .omitted:
            return .none
        case .numeric:
            return .short
        case .abbreviated:
            return .medium
        case .long:
            return .long
        case .complete:
            return .full
        }
    }

}

/// Represents various time styles
public enum TimeStyle: String {
    /// Excludes the time part.
    case omitted
    /// For example, "04:29 PM", "16:29".
    case shortened
    /// For example, "4:29:24 PM", "16:29:24".
    case standard
    /// For example, "4:29:24 PM PDT", "16:29:24 GMT".
    case complete

    internal var style: DateFormatter.Style {
        switch self {
        case .omitted:
            return .none
        case .shortened:
            return .short
        case .standard:
            return .medium
        case .complete:
            return .long
        }
    }
}

public enum RelativeStyle: String {
    case shortened
    case standard
    case complete
}

public enum DateFormat: Equatable {
    case iso8601
    case relative(_ style: RelativeStyle = .standard)
    case styled(date: DateStyle = .numeric, time: TimeStyle = .standard)
    case formatted(_ format: String)
    case custom(Formatter)

    internal var formatter: Formatter {
        switch self {
        case .iso8601:
            return ISO8601DateFormatter()
        case .relative(let style):
            let formatter = RelativeDateTimeFormatter()
            switch style {
            case .shortened:
                formatter.unitsStyle = .short
                formatter.dateTimeStyle = .numeric
            case .complete:
                formatter.unitsStyle = .full
                formatter.dateTimeStyle = .named
            case .standard:
                break
            }
            return formatter
        case .styled(let date, let time):
            let formatter = DateFormatter()
            formatter.dateStyle = date.style
            formatter.timeStyle = time.style
            return formatter
        case .formatted(let format):
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        case .custom(let formatter):
            return formatter
        }
    }
}

/// Represents various date components
public enum DateComponent: Equatable {
    /// Represents the `minute` calendar component
    case minute
    /// Represents the `hour` calendar component
    case hour
    /// Represents the `day` calendar component
    case day
    /// Represents the `week` calendar component
    case week
    /// Represents the `month` calendar component
    case month
    /// Represents the `year` calendar component
    case year
}
