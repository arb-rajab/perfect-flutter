# Device assistants (Gemini, Siri)

Gemini on Android and Siri on iOS can answer questions from the content the
user unlocked, and open it in the app. They never see locked or expired
content. The app does not offer "ask about this screen": there is no
`onProvideAssistContent`/`onProvideAssistData` and no current-screen
`NSUserActivity`. Screenshot protection is unchanged.

## How it works

```
Gemini ─ AppFunctions ─┐                       ┌─ AssistantSearchService (unlocked content only)
                       ├─ AssistantBridge ─────┤
Siri ─── App Intents ──┘  (headless engine,    └─ ContentAccessService (link checks)
                          `assistantMain`)
                                │  "assistant" MethodChannel (AssistantChannel)
Open in app ── perfect:// link ─┴─► app_links ─► DeepLinkCoordinator (checks access again)
```

- **`AssistantChannel`** (`lib/application/services/assistant_channel.dart`)
  is the `assistant` MethodChannel:
  - `search({query, limit?})` returns up to 5 results, best match first. Each
    result has `type`, `id`, `title`, `answer` (up to 800 characters: the
    correct answers of a question, the back of a flashcard, the FAQ answer, or
    an excerpt), `snippet` and `deepLink`. When nothing matches, `status` is
    `noMatch`, with an empty list and a message saying the app has no answer.
  - `open({deepLink})` returns `opened`, `locked`, `expired`, `unavailable`
    or `invalid`. In the UI engine it also opens the link.
  - `lookup({deepLinks})` returns the same results for links that are still
    unlocked. iOS uses it to look entities up again by id.
- **Background cold start.** The assistant can start the app without its UI
  (an AppFunction runs in a service; Siri can launch the app in the
  background). The native `AssistantBridge` therefore runs the Dart entry point
  `assistantMain` in its own headless engine. That engine registers only the
  four plugins it needs (shared_preferences, device_info_plus,
  package_info_plus, sqflite). Calls wait until Dart reports `ready`. The
  engine never creates or migrates the database: if the app has not set it up
  yet, the call fails and asks the user to open the app once.
- **Opening** always goes through a `perfect://<type>/<id>` link, which
  `DeepLinkCoordinator` (PR #4) handles. On a cold start it opens the content
  over Home. Access is checked again, so content locked since the search opens
  the coupon or contact flow. Flutter's own deep-link handler is now off on
  both platforms (`flutter_deeplinking_enabled`, `FlutterDeepLinkingEnabled`),
  as app_links requires. Without that, every link would be routed twice. Other
  app links (`/q/<uuid>`) keep their route through the coordinator.

## Android

| Piece | Where | Needs |
| --- | --- | --- |
| AppFunctions `searchContent(query)`, `openContent(link)` | `android/app/src/main/kotlin/.../PerfectAppFunctions.kt`, `res/xml/app_metadata.xml` | Android 16 (API 36)+, `androidx.appfunctions:1.0.0-beta01`, compileSdk 37 |
| Headless engine | `AssistantBridge.kt` | – |
| `perfect://` scheme, App Links for content paths on `perfect-app.com` | `AndroidManifest.xml` | `assetlinks.json` on the domain for App Links |
| App shortcuts (Add coupon, FAQ, Contact us) | `res/xml/shortcuts.xml` → `perfect://coupon`, `perfect://faq`, `perfect://contact` | Android 7.1+ |

- `openContent` returns a `PendingIntent` to `MainActivity` with the link. It
  throws `AppFunctionInvalidArgumentException` for a link that isn't the app's,
  and `AppFunctionElementNotFoundException` for content that isn't on the
  device. Agents receive other failures as `AppFunctionAppUnknownException`.
- **Gemini availability.** Gemini only calls third-party AppFunctions for apps
  in Google's AppFunctions early access program (private preview as of 2026).
  Until Perfect is onboarded, test with `adb` (see below). Other agents that
  hold `EXECUTE_APP_FUNCTIONS` can call the functions on any Android 16+
  device.
- **Fallbacks.** On Android 15 or lower, or without an agent that calls
  AppFunctions, the app shortcuts and `perfect://` links still work.

```sh
adb shell cmd app_function list-app-functions | grep -A 20 edu.perfect
# Use the function id that list-app-functions prints, e.g.:
adb shell "cmd app_function execute-app-function --package edu.perfect \
  --function 'edu.perfect.BasePerfectAppFunctionService#searchContent' \
  --parameters '{\"query\": \"الميتوكوندريا\"}'"
adb shell am start -a android.intent.action.VIEW -d "perfect://question/1" edu.perfect
adb shell am start -a android.intent.action.VIEW -d "perfect://coupon" edu.perfect
```

## iOS

| Piece | Where | Needs |
| --- | --- | --- |
| `SearchContentIntent` (returns `[ContentEntity]` with answer and link, and speaks the best answer), `OpenContentIntent`, `ContentEntity` | `ios/Runner/AssistantIntents.swift` | iOS 16+, Xcode 14+ |
| Siri phrases: "Search Perfect", "Ask Perfect", "Look something up in Perfect" | `PerfectShortcuts` in the same file | iOS 16+ |
| Headless engine | `ios/Runner/AssistantBridge.swift` | – |
| Core Spotlight index | `ios/Runner/SpotlightIndex.swift`, `lib/application/services/assistant_index_service.dart` | iOS 14+ |
| `perfect` URL scheme | `Info.plist` `CFBundleURLTypes` | – |
| Universal Links | `Runner.entitlements` (unchanged: `perfect-app.com`, `perfect-app.scienceontheweb.net`) | The domains' `apple-app-site-association` must list the content paths (`/term/*`, `/question/*`, …) |

- **Spotlight.** `AssistantIndexService` (UI engine, iOS only) indexes up to
  2,000 unlocked items: terms and ebooks, then FAQs, flashcards and questions.
  News is left out. Each item has a title, a description (its answer or an
  excerpt) and keywords (the names of its term and the term's ancestors). The
  service replaces the whole index whenever the items change. It checks on
  app start, on resume, and 3 s after writes to the access or content tables
  (coupons, syncs, downloads). It also rebuilds once a week in case iOS
  cleared the index. Each item expires when the coupon that unlocks it ends, so
  iOS removes it on time even if the app is never opened again. Tapping a
  result opens its deep link.
- **Fallbacks.** On iOS 13–15 there are no App Intents. Spotlight (14+) and
  links still work. The phrases are English only: for Arabic Siri, add an
  `AppShortcuts.xcstrings` string catalog with Arabic phrases in Xcode. Siri
  reads the `title: answer` dialog in the voice of its language.

## Known limitations

- Images, YouTube-video and folder terms aren't results, as in PR #4.
- The headless engine stays alive for the life of the process once started.
- The index and search read the same encrypted database as the UI. Both now
  set `busy_timeout`, so one waits for the other's lock instead of failing.
