import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'api_consumer.dart';
import 'interceptors/api_interceptors.dart';

/// A concrete implementation of the [ApiConsumer] interface powered by the [Dio] networking client.
///
/// This service encapsulates core HTTP operations, unifies multi-environment variables
/// via [FlavorConfig], and chains centralized interceptors to handle global tokens, logging,
/// and request/response pipelines seamlessly.
class DioConsumer extends ApiConsumer {
  /// The underlying [Dio] client instance managing connections and configurations.
  final Dio dio;

  /// Initializes the client and sets up core base architectures and interceptor pipelines.
  ///
  /// Dynamically maps the target endpoint base URL depending on the active running flavor configuration variables,
  /// and attaches standard middlewares ([ApiInterceptor] and [LoggingInterceptor]).
  ///
  /// * [dio]: An injected [Dio] instance, typically populated by your dependency injection engine.
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = FlavorConfig.instance.variables['baseUrl'];
    dio.interceptors.addAll([
      // ConnectivityInterceptor(sl<NetworkInfo>()),
      ApiInterceptor(),
      LoggingInterceptor(),
    ]);
  }

  /// Sends an HTTP **DELETE** request to the designated remote [path].
  ///
  /// Automatically determines payload transformations based on the [isFromData] switch flag.
  ///
  /// * [path]: The target endpoint URL string or sub-route query.
  /// * [data]: Optional parameters or key payloads mapped inside the request body.
  /// * [queryParameters]: Key-value URI parameter tokens appended directly onto the request URL.
  /// * [isFromData]: If `true`, builds a [FormData] boundary map layout payload for files/multipart streams. Defaults to `false`.
  ///
  /// Returns a [Future] containing the raw decompressed/parsed server response data payload body.
  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.delete(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  /// Sends an HTTP **GET** request to fetch specific remote assets from [path].
  ///
  /// * [path]: The target endpoint URL string or sub-route query.
  /// * [data]: Optional data properties packed into the body layout tree.
  /// * [queryParameters]: Key-value filtering URI parameter tokens appended directly onto the request URL.
  ///
  /// Returns a [Future] containing the parsed json response collection structure payload from the backend.
  @override
  Future get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  /// Sends an HTTP **PATCH** request to execute sub-property modifications on the remote resource [path].
  ///
  /// * [path]: The target endpoint URL string or sub-route query.
  /// * [data]: The fractional map data elements containing specific updates to commit.
  /// * [queryParameters]: Key-value URI parameter tokens appended directly onto the request URL.
  /// * [isFromData]: Automatically packs arguments as [FormData] when `true`. Defaults to `false`.
  ///
  /// Returns a [Future] containing the updated server model serialization response data.
  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.patch(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  /// Sends an HTTP **POST** request to insert new remote entities or trigger operations at [path].
  ///
  /// * [path]: The target endpoint URL string or sub-route query.
  /// * [data]: The payload content object values intended for server submission.
  /// * [queryParameters]: Key-value URI parameter tokens appended directly onto the request URL.
  /// * [isFromData]: Set to `true` to package media uploads or standard multi-field webforms cleanly. Defaults to `false`.
  ///
  /// Returns a [Future] containing the resulting server execution data payload model.
  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.post(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
