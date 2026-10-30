const int listItemsInitialCount = 10;

/// Master switch for screenshot / screen-capture protection (FLAG_SECURE on
/// Android, the screen protector on iOS). While false, every screenshot policy
/// call is a no-op and the platform is never asked to block capture, so
/// assistant access ("ask about this screen") works everywhere. Set to true to
/// restore the per-screen protection rules.
const bool kScreenCaptureProtectionEnabled = false;
