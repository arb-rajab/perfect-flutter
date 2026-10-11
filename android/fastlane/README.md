# Fastlane (Google Play)

Uploads the store screenshots in `play_screenshots/` (phone, 7" and 10" tablet)
to the Play Console listing, so they don't need to be uploaded by hand.

## One-time setup

1. Install Ruby and Bundler, then from `android/` run `bundle install`.
2. In Google Cloud, create a **service account** and download a JSON key.
3. In Play Console go to **Users and permissions** (or **Setup → API access**),
   invite the service account's email and give it permission to manage the
   store presence / edit the store listing.
4. Keep the key **out of git** and point to it:

   ```
   export PLAY_JSON_KEY_FILE=/path/to/play-service-account.json
   ```

## Usage (from `android/`)

```
# Dry run: validates the upload without publishing
VALIDATE=1 bundle exec fastlane screenshots

# Upload (replaces the existing screenshots)
bundle exec fastlane screenshots

# Another language listing (default is ar)
PLAY_LOCALE=en-US bundle exec fastlane screenshots
```

Screenshots are shown in file name order. To regenerate the images:

```
for d in phone tablet_7 tablet_10; do
  GEN_SCREENSHOTS=1 SHOT_DIR=play_screenshots flutter test test/store_screenshots_test.dart --plain-name $d
done
```
