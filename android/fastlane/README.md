# Fastlane (Google Play)

Uploads the store screenshots in `play_screenshots/` (phone, 7" and 10" tablet)
to the Play Console listing. It is meant to run from the **GitHub Actions
workflow** `.github/workflows/play-screenshots.yml`, so no key file is ever
stored on a machine.

## One-time setup

1. In Google Cloud, create a **service account** and a JSON key.
2. In Play Console (**Users and permissions**) invite the service account's email
   and let it manage the store presence / edit the store listing.
3. In GitHub: **Settings -> Secrets and variables -> Actions -> New repository
   secret**, name `PLAY_JSON_KEY_DATA`, value = the full JSON content of the key.
   Then delete the downloaded key file.

## Run

GitHub -> **Actions -> Play Store screenshots -> Run workflow**:

- `upload` off: only generates the screenshots and attaches them as an artifact.
- `upload` on + `validate_only` on (default): dry run against Play, nothing is published.
- `upload` on + `validate_only` off: replaces the screenshots on the listing.
- `locale`: listing language (default `ar`).

(GitHub only lists a workflow in the Actions tab once the file is on the default branch.)

`Appfile` reads the key from the `PLAY_JSON_KEY_DATA` environment variable
(`json_key_data_raw`), so the same lane also works anywhere that variable is set:

```
cd android && VALIDATE=1 bundle exec fastlane screenshots
```
