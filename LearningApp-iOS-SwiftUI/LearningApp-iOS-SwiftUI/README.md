# LearningApp

## 1. Architecture
The app uses SwiftUI with **MVVM + Repository Pattern**. Views render state, ViewModels contain presentation/business logic, and repositories isolate API/local-storage concerns. Protocols make the data layer easy to mock in tests.

## 2. Offline Support
Courses are fetched from the mock API and saved as JSON under the app's Application Support directory using `FileManager`. If the API fails after a successful load, the repository returns the cached courses. Lesson completion is also persisted to the cache.

## 3. Security
In production, authentication/refresh tokens should be stored in the **iOS Keychain**. Tokens should never be placed in `UserDefaults` or plain files.

## 4. Scale
For 1M users and hundreds of courses I would add:
- Server-side pagination, filtering, and incremental sync.
- SwiftData/Core Data for larger local datasets and indexed queries.
- HTTP caching, retry/backoff, request cancellation, and image caching.
- Observability: crash reporting, metrics, tracing, and structured logs.
- Horizontally scalable APIs, database indexing, CDN/API gateway, and rate limiting.

## 5. Android
I would use **Kotlin + Jetpack Compose + MVVM + Repository + Retrofit + Room + Coroutines + Hilt**. The repository/domain boundaries can remain conceptually the same while the UI and persistence implementations use Android-native APIs.
