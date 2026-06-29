import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A wrapper service that provides an abstraction layer for encrypted local data storage.
///
/// This service leverages [FlutterSecureStorage] to securely store sensitive data,
/// such as user authentications tokens, API secrets, or personal keys, using the
/// platform-specific secure hardware implementations (Keychain for iOS, Keystore for Android).
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  /// Initializes the service with an explicit configuration instance of [_secureStorage].
  ///
  /// This design allows for seamless mocking of storage operations during unit testing.
  SecureStorageService(this._secureStorage);

  /// Encrypts and writes a string [value] to disk mapped against a specific identifier [key].
  ///
  /// * [key]: The unique key index pointing to the safe record.
  /// * [value]: The raw string token value targeted for persistent hardware encryption.
  ///
  /// ### Example:
  /// ```dart
  /// await secureStorageService.write('access_token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...');
  /// ```
  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Decrypts and retrieves a stored record value associated with the designated [key].
  ///
  /// Returns a `Future<String?>` which resolves to the plain string token if found,
  /// or `null` if the reference target key does not exist inside storage entries.
  ///
  /// * [key]: The unique key index targeting the secure record.
  ///
  /// ### Example:
  /// ```dart
  /// final String? token = await secureStorageService.read('access_token');
  /// if (token != null) {
  ///   print('Successfully authenticated user session natively.');
  /// }
  /// ```
  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Permanently destroys a specific encrypted storage record reference index identified by [key].
  ///
  /// * [key]: The target identification label pointing to the record scheduled for immediate deletion.
  ///
  /// ### Example:
  /// ```dart
  /// await secureStorageService.delete('access_token'); // Removes individual key constraints
  /// ```
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Wipes out all stored entries and encrypted records contained within this secure memory storage container.
  ///
  /// Use this operation with caution during full application reset triggers or user explicit sign-out sequences.
  ///
  /// ### Example:
  /// ```dart
  /// void logoutUser() async {
  ///   await secureStorageService.clear(); // Complete security memory database reset
  /// }
  /// ```
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
