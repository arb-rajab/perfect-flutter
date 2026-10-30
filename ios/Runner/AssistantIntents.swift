import AppIntents
import Foundation
import app_links

// App Intents that let Siri, Shortcuts and Spotlight answer from the content the user unlocked
// in Perfect (iOS 16+). The work happens in Dart, through AssistantBridge; see AssistantChannel
// (lib/application/services/assistant_channel.dart) for the contract. Locked and expired
// content is never returned.

/// A piece of Perfect content; its id is its deep link, e.g. perfect://question/12.
@available(iOS 16.0, *)
struct ContentEntity: AppEntity {
  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Perfect content")
  static var defaultQuery = ContentEntityQuery()

  let id: String

  @Property(title: "Title")
  var title: String

  /// The correct answers of a question, the back of a flashcard, the answer of a FAQ, or an
  /// excerpt of a lesson, ebook or news item.
  @Property(title: "Answer")
  var answer: String

  /// question, flashcard, faq, term, ebook or news.
  @Property(title: "Type")
  var type: String

  /// Opens the content in Perfect.
  @Property(title: "Link")
  var link: URL

  var displayRepresentation: DisplayRepresentation {
    DisplayRepresentation(title: "\(title)", subtitle: "\(answer)")
  }

  init?(_ result: [String: Any]) {
    guard let deepLink = result["deepLink"] as? String, let url = URL(string: deepLink) else {
      return nil
    }
    id = deepLink
    title = result["title"] as? String ?? ""
    answer = result["answer"] as? String ?? ""
    type = result["type"] as? String ?? ""
    link = url
  }

  /// The entities in a `search` or `lookup` response, best match first.
  static func list(_ response: [String: Any]) -> [ContentEntity] {
    (response["results"] as? [[String: Any]] ?? []).compactMap { ContentEntity($0) }
  }
}

@available(iOS 16.0, *)
struct ContentEntityQuery: EntityStringQuery {
  /// Looks entities up again by deep link; content locked since is left out.
  func entities(for identifiers: [String]) async throws -> [ContentEntity] {
    let response = try await AssistantBridge.shared.call("lookup", ["deepLinks": identifiers])
    return ContentEntity.list(response)
  }

  func entities(matching string: String) async throws -> [ContentEntity] {
    let response = try await AssistantBridge.shared.call("search", ["query": string])
    return ContentEntity.list(response)
  }
}

/// Answers a question from Perfect's content without opening the app.
@available(iOS 16.0, *)
struct SearchContentIntent: AppIntent {
  static var title: LocalizedStringResource = "Search Perfect"
  static var description = IntentDescription(
    "Answers from the content you unlocked in Perfect: questions with their correct answers, flashcards, lessons, ebooks, FAQs and news."
  )

  @Parameter(title: "Question", requestValueDialog: "What do you want to look up in Perfect?")
  var query: String

  /// Up to five matches, best first; each has its answer text and the link that opens it.
  func perform() async throws -> some IntentResult & ReturnsValue<[ContentEntity]> & ProvidesDialog {
    let response = try await AssistantBridge.shared.call("search", ["query": query])
    let results = ContentEntity.list(response)
    guard let best = results.first else {
      // Said explicitly, so the assistant does not answer from elsewhere.
      return .result(value: [], dialog: "Perfect has no unlocked content that matches “\(query)”.")
    }
    return .result(value: results, dialog: "\(best.title): \(best.answer)")
  }
}

/// Opens content in Perfect. The app checks access again and shows the unlock screen for content
/// that is no longer unlocked.
@available(iOS 16.0, *)
struct OpenContentIntent: AppIntent {
  static var title: LocalizedStringResource = "Open in Perfect"
  static var description = IntentDescription("Opens content found by Search Perfect.")
  static var openAppWhenRun = true

  @Parameter(title: "Content")
  var content: ContentEntity

  @MainActor
  func perform() async throws -> some IntentResult {
    // The same path as a tapped perfect:// link: app_links -> DeepLinkCoordinator. app_links
    // keeps it as the initial link when the UI is not running yet.
    AppLinks.shared.handleLink(url: content.link)
    return .result()
  }
}

/// Siri phrases that work without setup. The query is asked for after the phrase, because
/// phrases cannot contain free text. For Arabic Siri, add an AppShortcuts.xcstrings with
/// Arabic phrases in Xcode.
@available(iOS 16.0, *)
struct PerfectShortcuts: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: SearchContentIntent(),
      phrases: [
        "Search \(.applicationName)",
        "Ask \(.applicationName)",
        "Look something up in \(.applicationName)",
      ])
  }
}
