import SwiftUI
import Lorem

@available(iOS 14, *)
@available(macOS 12, *)
public struct SampleView: View {
    public init() { }
    
    public var body: some View {
        NavigationView {
            List {
                Section { } header: {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            if #available(iOS 15, *) {
                                Text(Lorem.Composed("", 1, separator: ""))
                                
                                Lorem.asyncImage(size: 200) { phase in
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
                    .cornerRadius(13)
                    .overlay(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                    )
                    .frame(height: 200)
                    .padding(.horizontal, -16)
                }
                .padding(.top, 10)

                Section("Colors") {
                    Cell("Any") {
                        HStack(spacing: 5) {
                            ForEach(0..<4) { _ in
                                Lorem.color(in: .any)
                            }
                        }
                    }

                    Cell("Grayscale") {
                        HStack(spacing: 5) {
                            ForEach(0..<4) { _ in
                                Lorem.color(in: .grayscale)
                            }
                        }
                    }

                    Cell("System") {
                        HStack(spacing: 5) {
                            ForEach(0..<4) { _ in
                                Lorem.color(in: .system)
                            }
                        }
                    }

                    Cell("Hues") {
                        HStack(spacing: 5) {
                            ForEach(0..<4) { _ in
                                Lorem.color(in: .hue(saturation: 0.5))
                            }
                        }
                    }
                }

                Section {
                    Lorem.title
                }

                Section("Titles") {
                    Cell("Title", Lorem.title)
                }

                Section("Dates") {
                    Cell("Relative", Lorem.date(within: 2, component: .week, format: .relative()))
                    Cell("Formatted", Lorem.date(.formatted("HH:mm")))
                    Cell("Styled", Lorem.date(.styled(date: .numeric, time: .shortened)))
                    Cell("iSO 8601", Lorem.date(.iso8601))
                }

                Section("Web") {
                    Cell("Domain") { Lorem.url }
                    Cell("Email") { Lorem.email }
                    Cell("Tweet", Lorem.tweet)
                }

                Section("Names") {
                    Cell("Number of first names", Lorem.Data.firstNames.count)
                    Cell("Number of last names", Lorem.Data.lastNames.count)
                    Cell("Name", Lorem.name)
                }

                Section("Words") {
                    Cell("Number of words", Lorem.Data.words.count)
                    Cell("Five Words", Lorem.words(5))
                }

                Section("Sentences") {
                    Cell("Single", Lorem.sentence)
                    Cell("Two Sentences", Lorem.sentences(2))
                }

                Section("Paragraphs") {
                    Cell("Single", Lorem.paragraph)
                    Cell("Two Paragraphs", Lorem.paragraphs(2, separator: "\n\n"))
                }
            }
            .font(.callout)
            #if os(iOS)
            .listStyle(.insetGrouped)
            .navigationBarTitleDisplayMode(.inline)
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
