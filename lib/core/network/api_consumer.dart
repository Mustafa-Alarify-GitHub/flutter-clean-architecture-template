/// An abstract contract interface defining the standard HTTP communication layer.
///
/// This serves as an architectural abstraction layer over network interactions.
/// Concrete network clients (such as `DioConsumer` or `HttpConsumer`) must implement
/// this interface, allowing repositories to remain decoupled from underlying packages.
abstract class ApiConsumer {
  /// Sends an HTTP **GET** request to the designated remote [path].
  ///
  /// Use this method to retrieve resource assets or queries from the backend API.
  ///
  /// * [path]: The target URL endpoint or relative URI sub-route path.
  /// * [data]: Optional request body payload elements.
  /// * [queryParameters]: Key-value URI parameter tokens appended onto the path URL structure.
  ///
  /// Returns a `Future<dynamic>` representing the raw serialized server response payload.
  ///
  /// ### Example:
  /// ```dart
  /// final response = await apiConsumer.get(
  ///   '/products',
  ///   queryParameters: {'category': 'electronics', 'limit': 10},
  /// );
  /// ```
  Future<dynamic> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  /// Sends an HTTP **POST** request to the designated remote [path].
  ///
  /// Use this method to submit data payloads, upload files, or trigger mutating commands on the server.
  ///
  /// * [path]: The target URL endpoint or relative URI sub-route path.
  /// * [data]: The payload body data object (Map, String, or binary stream) to transfer.
  /// * [queryParameters]: Optional key-value URI parameter tokens appended onto the path.
  /// * [isFromData]: If `true`, flags the data object payload to process as a `Multipart/FormData` request (typically used for file uploads). Defaults to `false`.
  ///
  /// Returns a `Future<dynamic>` representing the raw serialized server response payload.
  ///
  /// ### Example:
  /// ```dart
  /// final response = await apiConsumer.post(
  ///   '/products/add',
  ///   data: {'title': 'New Shoes', 'price': 99.9},
  /// );
  /// ```
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });

  /// Sends an HTTP **PATCH** request to the designated remote [path].
  ///
  /// Use this method to perform partial resource modifications on an existing server item.
  ///
  /// * [path]: The target URL endpoint or relative URI sub-route path.
  /// * [data]: The fractional property map data containing updates to transmit.
  /// * [queryParameters]: Optional key-value URI parameter tokens appended onto the path.
  /// * [isFromData]: Flags whether to process payload arguments inside a `Multipart/FormData` layout boundary. Defaults to `false`.
  ///
  /// Returns a `Future<dynamic>` representing the raw serialized server response payload.
  ///
  /// ### Example:
  /// ```dart
  /// final response = await apiConsumer.patch(
  ///   '/products/12',
  ///   data: {'price': 79.9}, // Updates only the price parameter fields
  /// );
  /// ```
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });

  /// Sends an HTTP **DELETE** request to the designated remote [path].
  ///
  /// Use this method to destroy or remove data entities permanently off the backend servers.
  ///
  /// * [path]: The target URL endpoint or relative URI sub-route path.
  /// * [data]: Optional explicit parameter data structures necessary to process the request context.
  /// * [queryParameters]: Optional key-value URI parameter tokens appended onto the path.
  /// * [isFromData]: Flags whether to bind dynamic data inside a `Multipart/FormData` payload setup. Defaults to `false`.
  ///
  /// Returns a `Future<dynamic>` representing the raw serialized server response payload.
  ///
  /// ### Example:
  /// ```dart
  /// final response = await apiConsumer.delete('/products/12');
  /// ```
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
}
