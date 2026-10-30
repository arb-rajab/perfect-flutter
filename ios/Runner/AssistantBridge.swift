import Flutter
import Foundation

/// Calls the Dart "assistant" MethodChannel (lib/application/services/assistant_channel.dart)
/// on a headless engine that runs `assistantMain` (lib/main.dart).
///
/// Siri can launch the app in the background to run an App Intent; the UI engine then never
/// starts, so the intents use this engine instead. It is started on the first call and kept for
/// the life of the process; calls wait until Dart reports "ready".
@MainActor
final class AssistantBridge {
  static let shared = AssistantBridge()

  /// Only the plugins `assistantMain` uses: shared_preferences (cached FAQs and news),
  /// device_info_plus and package_info_plus (the database key) and sqflite (the database
  /// folder). Registering every plugin would let some of them, such as firebase_messaging,
  /// take over app-wide delegates from the UI engine. Looked up by class name, so this file
  /// does not depend on how the plugins are built (CocoaPods or Swift Package Manager).
  private static let plugins = [
    "SharedPreferencesPlugin": "shared_preferences_foundation.SharedPreferencesPlugin",
    "FPPDeviceInfoPlusPlugin": "FPPDeviceInfoPlusPlugin",
    "FPPPackageInfoPlusPlugin": "FPPPackageInfoPlusPlugin",
    "SqflitePlugin": "SqflitePlugin",
  ]

  private var engine: FlutterEngine?
  private var channel: FlutterMethodChannel?
  private var ready = false
  private var pending: [(FlutterMethodChannel) -> Void] = []

  private init() {}

  /// Invokes `method` and returns Dart's result map; throws if Dart fails.
  func call(_ method: String, _ arguments: [String: Any]) async throws -> [String: Any] {
    try await withCheckedThrowingContinuation { continuation in
      whenReady { channel in
        channel.invokeMethod(method, arguments: arguments) { result in
          if let map = result as? [String: Any] {
            continuation.resume(returning: map)
          } else if let error = result as? FlutterError {
            continuation.resume(throwing: AssistantError(error.message ?? error.code))
          } else {
            // Also FlutterMethodNotImplemented.
            continuation.resume(throwing: AssistantError("\(method) returned \(String(describing: result))"))
          }
        }
      }
    }
  }

  private func whenReady(_ action: @escaping (FlutterMethodChannel) -> Void) {
    let channel = channel ?? start()
    if ready { action(channel) } else { pending.append(action) }
  }

  private func start() -> FlutterMethodChannel {
    let engine = FlutterEngine(name: "assistant", project: nil, allowHeadlessExecution: true)
    // The engine must run before plugins and channel handlers can be registered on it.
    engine.run(withEntrypoint: "assistantMain")
    for (key, className) in Self.plugins {
      guard let plugin = NSClassFromString(className) as? FlutterPlugin.Type,
        let registrar = engine.registrar(forPlugin: key)
      else {
        NSLog("AssistantBridge: plugin \(className) not found")
        continue
      }
      plugin.register(with: registrar)
    }
    let channel = FlutterMethodChannel(name: "assistant", binaryMessenger: engine.binaryMessenger)
    channel.setMethodCallHandler { [weak self] call, result in
      if call.method == "ready", let self {
        self.ready = true
        self.pending.forEach { $0(channel) }
        self.pending.removeAll()
      }
      result(nil)
    }
    self.engine = engine
    self.channel = channel
    return channel
  }
}

struct AssistantError: LocalizedError {
  let errorDescription: String?

  init(_ message: String) { errorDescription = message }
}
