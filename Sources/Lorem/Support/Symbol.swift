import Foundation

final class Symbol {
    static var names: [String] { shared.names }
    private static let shared: Symbol = .init()

    private var names: [String] = []

    init() {
        let url: URL

        if #available(iOS 16, tvOS 16, macOS 13, watchOS 9, *) {
            url = Bundle.module.url(forResource: "symbols-4", withExtension: "txt")!
        } else if #available(iOS 15, tvOS 15, macOS 12, watchOS 8, *) {
            url = Bundle.module.url(forResource: "symbols-3", withExtension: "txt")!
        } else if #available(iOS 14, tvOS 14, macOS 11, watchOS 7, *) {
            url = Bundle.module.url(forResource: "symbols-2", withExtension: "txt")!
        } else {
            url = Bundle.module.url(forResource: "symbols-1", withExtension: "txt")!
        }

        do {
            let document = try String(contentsOf: url)
            document.enumerateLines { line, _ in
                self.names.append(line)
            }
        } catch {
            print("Could not load symbols from: \(url)")
        }
    }
}
