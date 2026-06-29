import 'package:shared_preferences/shared_preferences.dart';

/// A wrapper service that abstracts and manages local persistent key-value caching.
///
/// This service leverages [SharedPreferences] to store simple data primitives
/// (such as app preferences, current theme configurations, or onboard onboarding flags)
/// directly onto disk asynchronously.
class SharedPreferencesService {
  static SharedPreferences? _preferences;

  /// Initializes the underlying native platform instance framework.
  ///
  /// This must be called asynchronously at application bootstrap (typically inside `main.dart`)
  /// before attempting any transactional interactions with memory registers.
  ///
  /// ### Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await SharedPreferencesService.init();
  ///   runApp(const MyApp());
  /// }
  /// ```
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Private helper getter ensuring that storage operations are not triggered
  /// prior to calling the synchronous setup lifecycle [init].
  SharedPreferences get _prefs {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _preferences!;
  }

  /// Persists a primitive [String] value locally mapped against a unique [key].
  ///
  /// Returns a `Future<bool>` indicating whether the write operation committed successfully.
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.saveString('username', 'Mustafa_Salem');
  /// ```
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Retrieves a persistent [String] record value mapped against the unique [key].
  ///
  /// Returns `null` if the reference target index cannot be allocated.
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Persists a primitive [bool] layout flag locally mapped against a unique [key].
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.saveBool('is_dark_mode', true);
  /// ```
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Retrieves a persistent [bool] layout configuration flag mapped against the unique [key].
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Persists a primitive [int] numerical counter value locally mapped against a unique [key].
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.saveInt('app_launch_count', 5);
  /// ```
  Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Retrieves a persistent [int] numerical counter value mapped against the unique [key].
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Persists a primitive [double] fractional numeric value locally mapped against a unique [key].
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.saveDouble('text_scale_ratio', 1.25);
  /// ```
  Future<bool> saveDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// Retrieves a persistent [double] fractional numeric value mapped against the unique [key].
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// Persists a linear [List] collection array of [String] values locally mapped against a unique [key].
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.saveStringList('recent_searches', ['flutter', 'clean architecture', 'di']);
  /// ```
  Future<bool> saveStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// Retrieves a linear [List] collection array of [String] tokens mapped against the unique [key].
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// Permanently removes a specific individual key-value mapping constraints reference out of storage space.
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.remove('cached_user_profile');
  /// ```
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Sweeps and flushes all recorded key-value configuration values held across this persistence cache instance.
  ///
  /// ### Example:
  /// ```dart
  /// await sharedPrefsService.clear();
  /// ```
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  /// Evaluates whether a target [key] registration reference constraint node exists within the memory lookup stack.
  ///
  /// Returns `true` if allocated, otherwise resolves to `false`.
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
