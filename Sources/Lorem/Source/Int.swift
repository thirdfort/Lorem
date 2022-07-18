import Foundation

public enum AgeGroup {
    case child
    case teen
    case adult
    case elderly

    var range: ClosedRange<Int> {
        switch self {
        case .child: return 1...12
        case .teen: return 13...17
        case .adult: return 18...65
        case .elderly: return 65...100
        }
    }
}

public extension Lorem where Content == Int {
    typealias L = Lorem<Content>

    /// Returns a placeholder year between 1900 and the current year
    static var year: Content {
        let year = Calendar.current.component(.year, from: Date())
        return number(in: 1900...Content(year))
    }

    /// Returns a placeholder year in the specified range
    static func year(in range: ClosedRange<Int>) -> Content {
        Lorem<Int>.number(in: range)
    }

    /// Returns a placeholder age for an adult
    static var age: Content {
        AgeGroup.adult.range.randomElement()!
    }

    /// Returns a placeholder age within the specified age-group
    static func age(for group: AgeGroup) -> Content {
        group.range.randomElement()!
    }

    /// Returns a placeholder age from the specified reference
    static func age(year: Int) -> Content {
        let birthdate = DateComponents(calendar: .current, year: year).date ?? Date()
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = .year
        formatter.unitsStyle = .full
        let components: DateComponents = Calendar.current.dateComponents([.year], from: birthdate, to: Date())
        return components.year ?? 0
    }
}
