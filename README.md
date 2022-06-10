![ios](https://img.shields.io/badge/iOS-13-green)
![tv](https://img.shields.io/badge/tvOS-13-green)
![watchOS](https://img.shields.io/badge/iOS-6-green)
![mac](https://img.shields.io/badge/macOS-10.15-green)

# Lorem

Introducing Lorem, a placeholder generator library for iOS to help you rapidly prototype, build and test your iOS applications.

![Lorem sample]()

By leveraging Swift generics we're also able to provide a simple, consistent API to make it easier to discover and even find all references when you're ready to remove your placeholder data.

```swift
// When used in a context where a simple String is required
Lorem.title // return String

// But if we use the same code inside a SwiftUI View
var body: some View {
	Lorem.title // returns Text
}
```

## Features

Lorem supports various placeholder APIs, including:

- Strings
- Dates
- Images
- URLs
- SwiftUI View's

> While most features are supported across all platforms and version, some (like `AsyncImage`) are only available in supported environments.

## Advanced

Lorem provides access to its underlying placeholder data primitives, as well as a reusable composer that simplifies Lorem generation. This enables you to easily create custom Lorem placeholders for content where the library doesn't quite meet your needs.

```swift
let keywords = Lorem.Composer(
    Lorem.word,
    countRange: 5...15,
    separator: ", ",
    terminator: ""
)

// tempora, fugit, sit, molestias, suscipit, voluptate, et, numquam, et, voluptatem, et
```

## Installation

You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (**preferred**)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/Thirdfort/Lorem.git", .upToNextMinor(from: "1.0.0"))`