/// Centralized API configuration.
/// Pass the base URL at build time via:
///   flutter run --dart-define=API_BASE_URL=https://faymakash.daarasmart.com/api/
class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://faymakash.daarasmart.com/api/',
  );
}
