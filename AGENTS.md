# Repository Guidelines

## Project Structure & Modules
- `lib/`: Flutter app code. Entry is `lib/main.dart`; features live in folders like `auth/`, `receipts/`, `groups/`, `shared/`, `service/`, `utils/`, and `home/`.
- `api/`: Local OpenAPI Dart package (Dio client). Consumed via `pubspec.yaml` as `openapi: { path: api }`. Do not hand‑edit generated sources; see `api/README.md` for regeneration details.
- `assets/` and `fonts/`: Static resources declared in `pubspec.yaml`.
- Platform targets: `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/`.

## Build, Test, and Dev Commands
- Install deps: `flutter pub get`
- Run app (device/emulator): `flutter run -d <deviceId>` (e.g., `emulator-5554`)
- Analyze code: `dart analyze` (or `flutter analyze`)
- Format code: `dart format .`
- Test app: `flutter test`
- Test API package: `cd api && dart test`
- Build release: `flutter build apk` | `flutter build ios` | `flutter build web`

## Coding Style & Naming
- Indentation: 2 spaces; keep lines reasonably short; prefer trailing commas for clean Flutter diffs.
- Files/folders: `lower_snake_case.dart` (e.g., `receipt_editor_page.dart`).
- Classes/enums: `PascalCase`; methods/fields: `camelCase`; library‑private symbols prefixed with `_`.
- Lints: `flutter_lints` (configured via `analysis_options.yaml`). Ensure `dart analyze` is clean before PRs.

## Testing Guidelines
- Location: App tests under `test/` (create if missing); API client tests live in `api/test/`.
- Naming: `*_test.dart` (e.g., `receipt_repository_test.dart`).
- Scope: Add unit tests for services/utils and widget tests for screens; include happy path and error states. Aim to cover new/changed code.

## Commit & Pull Requests
- Commits: Imperative, concise subject (e.g., "fix: handle empty totals" or "refactor: unify item/share UI"). Reference issues (`#123`) when relevant.
- PRs: Include a clear summary, linked issues, screenshots/screencasts for UI changes, and any migration notes. PRs must pass `dart format`, `dart analyze`, and tests for both root and `api/`.

## Security & Configuration
- Do not commit secrets or tokens. Use `flutter_secure_storage` for sensitive values and keep environment/config out of VCS.
- Avoid editing generated code in `api/`; regenerate instead when the backend schema changes.

