import SwiftUI
import Lorem

@available(iOS 14, *)
@available(macOS 12, *)
public struct SampleView: View {
    public init() { }
    
    public var body: some View {
        NavigationView {
            List {
                Section("Images") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            if #available(iOS 15, *) {
                                Lorem.asyncImage(size: 100) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    default:
                                        Rectangle()
                                            .foregroundColor(Color.primary.opacity(0.2))
                                    }
                                }

                                Lorem.asyncImage(source: .seed(0), size: 200, grayscale: true) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 200)
                                    default:
                                        Rectangle()
                                            .foregroundColor(Color.primary.opacity(0.2))
                                            .frame(width: 200, height: 200)
                                    }
                                }
                            } else {
                                Lorem.image
                                Lorem.image(ratio: 1, color: .accentColor)
                            }
                        }
                    }
                    .frame(height: 100)
                }

                Section("Colors") {
                    Cell("Any") {
                        HStack(spacing: 5) {
                            ForEach(0..<10) { _ in
                                Lorem.color(in: .any)
                            }
                        }
                    }

                    Cell("Grayscale") {
                        HStack(spacing: 5) {
                            ForEach(0..<10) { _ in
                                Lorem.color(in: .grayscale)
                            }
                        }
                    }

                    Cell("System") {
                        HStack(spacing: 5) {
                            ForEach(0..<10) { _ in
                                Lorem.color(in: .system)
                            }
                        }
                    }

                    Cell("Hues") {
                        HStack(spacing: 5) {
                            ForEach(0..<10) { _ in
                                Lorem.color(in: .hue(saturation: 0.5))
                            }
                        }
                    }
                }

                Section("Text") {
                    Cell("Title", Lorem.title)
                    Cell("Keywords", Lorem.keywords)
                    Cell("Sentence", Lorem.sentence)
                    Cell("Domain") { Lorem.url }
                    Cell("Email") { Lorem.email }
                    Cell("Tweet", Lorem.tweet)
                }

                Section("Dates") {
                    Cell("Relative", Lorem.date(within: 2, component: .week, format: .relative()))
                    Cell("Styled", Lorem.date(.styled(date: .numeric, time: .shortened)))
                    Cell("ISO 8601", Lorem.date(.iso8601))
                    Cell("Custom (HH:mm)", Lorem.date(.formatted("HH:mm")))
                }

                Section("Paragraphs") {
                    Cell("Single", Lorem.paragraph)
                    Cell("Two Paragraphs", Lorem.paragraphs(2, separator: "\n\n"))
                }

                Section("Data") {
                    Cell("Number of words", Lorem.Data.words.count)
                    Cell("Number of first names", Lorem.Data.firstNames.count)
                    Cell("Number of last names", Lorem.Data.lastNames.count)
                    Cell("Number of site domains", Lorem.Data.siteDomains.count)
                    Cell("Number of email domains", Lorem.Data.emailDomains.count)
                }
            }
            .font(.callout)
            #if os(iOS)
            .listStyle(.insetGrouped)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            #endif
            .navigationTitle("Lorem")
        }
        #if os(iOS)
        .navigationViewStyle(.stack)
        #endif
    }
}

struct Cell<Content: View>: View {
    let title: String
    let detail: Content

    init(_ title: String, _ detail: String) where Content == Text {
        self.title = title
        self.detail = Text(detail)
    }

    init<S: CustomStringConvertible>(_ title: String, _ detail: S) where Content == Text {
        self.title = title
        self.detail = Text(verbatim: "\(detail)")
    }

    init(_ title: String, @ViewBuilder _ detail: () -> Content) {
        self.title = title
        self.detail = detail()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.footnote.weight(.light))
                Spacer(minLength: 0)
            }

            detail
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 3)
    }
}

@available(iOS 14, *)
@available(macOS 12, *)
extension Section where Parent == AnyView, Footer == EmptyView, Content: View {
    init(_ header: String, @ViewBuilder _ content: () -> Content) {
        self.init {
            content()
        } header: {
            AnyView(
                Text(header)
                    .font(.footnote.weight(.medium))
                    .textCase(.none)
            )
        } footer: {
            EmptyView()
        }
    }
}

@available(iOS 14, *)
@available(macOS 12, *)
struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
