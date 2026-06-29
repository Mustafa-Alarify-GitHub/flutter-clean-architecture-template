import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// An abstract interface contract defining device internet connectivity checks.
///
/// This serves as an architectural abstraction layer to decouple data repositories
/// from specific third-party internet checking libraries, facilitating mock injections
/// during test suites execution.
abstract class NetworkInfo {
  /// Evaluates whether the hosting device currently holds active network throughput access.
  ///
  /// Resolves asynchronously to `true` if internet connection routing is verified,
  /// otherwise drops into `false`.
  ///
  /// ### Example:
  /// ```dart
  /// if (await networkInfo.isConnected) {
  ///   // Fetch directly from remote server endpoint api
  /// } else {
  ///   // Read data out of native offline cached storage boxes instead
  /// }
  /// ```
  Future<bool> get isConnected;
}

/// The concrete implementation of the [NetworkInfo] contract powered by [InternetConnection].
///
/// This class utilizes specific lookup hooks from the `internet_connection_checker_plus` ecosystem
/// to run physical ping packets check against verified DNS records.
class NetworkInfoImpl implements NetworkInfo {
  /// The underlying third-party client connection network checker instance dependency.
  final InternetConnection connectionChecker;

  /// Initializes the implementation service by injecting the target [connectionChecker].
  const NetworkInfoImpl(this.connectionChecker);

  /// Evaluates network accessibility status by checking against active web configurations.
  ///
  /// Leverages [InternetConnection.hasInternetAccess] to ensure the device isn't simply
  /// connected to a router/Wi-Fi, but has genuine, functional backhaul data routing access.
  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
