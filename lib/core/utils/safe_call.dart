import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/failures.dart';
import 'logger.dart';

/// A functional programming wrapper that handles exceptions safely across asynchronous operation triggers.
///
/// This helper encapsulates execution boundaries (typically remote or local API calls), catches
/// expected network anomalies or structure parsing breakdowns, and maps them functional-style
/// inside an [Either] container object ([Left] containing a [Failure], [Right] containing data [T]).
///
/// * [call]: A closure functional block representing the vulnerable asynchronous task scheduled for execution.
///
/// Returns a [Future] holding an [Either] computational block signature.
///
/// ### Example inside a Repository Implementation:
/// ```dart
/// @override
/// Future<Either<Failure, List<ProductModel>>> getProducts() async {
///   return await safeCall<List<ProductModel>>(() async {
///     final response = await remoteDataSource.getProducts();
///     return response.map((json) => ProductModel.fromJson(json)).toList();
///   });
/// }
/// ```
Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on DioException catch (e, stackTrace) {
    AppLogger.error('DioException caught in safeCall', e, stackTrace);
    return Left(failureFromDioException(e));
  } on FormatException catch (e, stackTrace) {
    AppLogger.error('FormatException caught in safeCall', e, stackTrace);
    return Left(ServerFailure(e.message));
  } catch (e, stackTrace) {
    AppLogger.error('Unexpected exception caught in safeCall', e, stackTrace);
    return Left(ServerFailure(e.toString()));
  }
}

