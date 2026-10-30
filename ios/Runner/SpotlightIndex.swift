import CoreSpotlight
import Flutter
import UniformTypeIdentifiers

/// Handles `replaceIndex` on the UI engine's "assistant" channel: AssistantIndexService
/// (lib/application/services/assistant_index_service.dart) sends every unlocked item, and this
/// replaces the app's Core Spotlight index with them, so locked content drops out.
/// Tapping a result opens its deep link (see AppDelegate).
final class SpotlightIndex: NSObject, FlutterPlugin {
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "assistant", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(SpotlightIndex(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "replaceIndex",
      let items = (call.arguments as? [String: Any])?["items"] as? [[String: Any]]
    else {
      result(FlutterMethodNotImplemented)
      return
    }
    guard #available(iOS 14.0, *), CSSearchableIndex.isIndexingAvailable() else {
      result(nil)
      return
    }
    let searchableItems = items.compactMap(Self.searchableItem)
    let index = CSSearchableIndex.default()
    index.deleteAllSearchableItems { error in
      if let error {
        result(FlutterError(code: "spotlight", message: error.localizedDescription, details: nil))
        return
      }
      index.indexSearchableItems(searchableItems) { error in
        result(
          error.map {
            FlutterError(code: "spotlight", message: $0.localizedDescription, details: nil)
          })
      }
    }
  }

  @available(iOS 14.0, *)
  private static func searchableItem(_ item: [String: Any]) -> CSSearchableItem? {
    guard let id = item["id"] as? String, let title = item["title"] as? String else { return nil }
    let attributes = CSSearchableItemAttributeSet(contentType: .text)
    attributes.title = title
    attributes.contentDescription = item["description"] as? String
    attributes.keywords = item["keywords"] as? [String]
    let searchable = CSSearchableItem(
      uniqueIdentifier: id,
      domainIdentifier: "perfect.\(item["type"] as? String ?? "content")",
      attributeSet: attributes)
    // When the coupon that unlocks the item ends, iOS removes it even if the app is not opened.
    // Without a date, items would expire after a month.
    if let expiresAt = item["expiresAt"] as? NSNumber {
      searchable.expirationDate = Date(timeIntervalSince1970: expiresAt.doubleValue / 1000)
    } else {
      searchable.expirationDate = .distantFuture
    }
    return searchable
  }
}
