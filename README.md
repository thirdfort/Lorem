![ios](https://img.shields.io/badge/iOS-13-green)
![tv](https://img.shields.io/badge/tvOS-13-green)
![watchOS](https://img.shields.io/badge/iOS-6-green)
![mac](https://img.shields.io/badge/macOS-10.15-green)

# Lorem

Introducing Lorem, a placeholder generator library for iOS to help you rapidly prototype, build and test your iOS applications.

![Lorem sample](https://github.com/thirdfort/Lorem/blob/main/Demo/Resources/lorem.png?raw=true)

By leveraging Swift generics we're also able to provide a simple, consistent API to make it easier to discover and even find all references when you're ready to remove your placeholder data.

```swift
// When used in a context where a simple String is required
Lorem.title // return String

// But if we use the same code inside a SwiftUI View
var body: some View {
    Lorem.title // returns Text
}
```

## Why?

Lorem placeholder content is extremely useful when prototyping or even while building your apps while live data is unavailable or just not feasible to access yet. 

Its also incredibly useful when running both manual and automation test suites, as it allows for a more controlled and/or varied set of values to be tested, revealing layout and other issues that may have been missed or difficult to reproduce otherwise.

Lastly, Lorem data is more clearly _placeholder_ data, which can help stakeholders and other team members better identify where live-data is yet to be implemented.

## Features

Lorem supports various placeholder APIs, including:

- Strings
- Dates
- URLs
- Images
- Colors
- SwiftUI View's

> While most features are supported across all platforms and version, some (like `AsyncImage`) are only available in supported environments.

## Usage

The most basic usage can be achieved using simple `String`:

```swift
Lorem.word
Lorem.sentence
Lorem.paragraph
Lorem.title
Lorem.name
Lorem.url
Lomem.email
Lorem.date
```

Since Lorem supports Swift Generics, you can also use it in more contexts:

```swift
let url: URL = Lorem.url
let date: Date = Lorem.date
```

Which also means all of the APIs are also available conveniently in SwiftUI

```swift
Lorem.title  // Text
Lorem.color  // Color
Lorem.image  // Image
```

Primitives are also available which allows for usage in more scenarios, including UIKit:

```swift
Lorem.url    // URL
Lorem.date   // Date
Lorem.color  // Color, UIColor, NSColor
Lorem.image  // Image, UIImage, NSImage
```

## Advanced

Lorem provides access to its underlying placeholder data primitives, as well as a reusable composer that simplifies text generation. This enables you to easily create custom Lorem placeholders for content where the library doesn't quite meet your needs.

```swift
let keywords = Lorem.Composer(
    Lorem.word,
    countRange: 5...15,
    separator: ", ",
    terminator: ""
)

// tempora, fugit, sit, molestias, suscipit, voluptate, et, numquam, et, voluptatem, et
```

Additionally, Lorem provides convenient access to its data sources, so you can build placeholders with the same data used to build the API.

```swift
Lorem.Data.words
Lorem.Data.firstNames
Lorem.Data.lastNames
Lorem.Data.siteDomains
Lorem.Data.emailDomains
// etc
```

## Installation

You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (**preferred**)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/Thirdfort/Lorem.git", .upToNextMinor(from: "1.0.0"))`