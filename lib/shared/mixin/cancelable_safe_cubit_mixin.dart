import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A mixin designed to safeguard [Cubit] state emissions and manage disposable asynchronous workers.
///
/// This utility attaches directly onto your state managers to provide automated lifecycle cancellation gates,
/// preventing race conditions from overlapping async updates and eliminating bad state exceptions
/// caused by emitting payloads onto terminated (`isClosed`) memory nodes.
mixin CancelableSafeCubitMixin<S> on Cubit<S> {
  /// Holds the reference tracking pointer managing the active cancelable asynchronous execution block thread.
  CancelableOperation? _operation;

  /// Executes an asynchronous task inside an isolated, cancelable lifecycle wrapper.
  ///
  /// If a new asynchronous request is submitted before the previous one completes, the active
  /// historical operation is forcefully canceled immediately to mitigate racing state mutations.
  ///
  /// * [future]: The asynchronous data query task targeted for execution.
  ///
  /// Returns a `Future<T?>` resolving to the data outcome type [T], or `null` if aborted
  /// midway or if the parent [Cubit] closes prior to final execution.
  ///
  /// ### Example inside a Search/Filter Cubit:
  /// ```dart
  /// Future<void> onSearchTextChanged(String query) async {
  ///   safeEmit(SearchLoadingState());
  ///
  ///   // Automatically aborts previous pending search keystroke API calls if the user keeps typing
  ///   final results = await runCancelable<List<Product>>(
  ///     _searchRepository.queryProducts(query),
  ///   );
  ///
  ///   if (results != null) {
  ///     safeEmit(SearchSuccessState(results));
  ///   }
  /// }
  /// ```
  Future<T?> runCancelable<T>(Future<T> future) async {
    await _operation?.cancel();

    _operation = CancelableOperation.fromFuture(future);

    final result = await _operation!.valueOrCancellation();

    if (isClosed) {
      return null;
    }

    return result;
  }

  /// Conditionally emits a new [state] only if the host [Cubit] node context remains alive and open.
  ///
  /// Replaces the standard [emit] invocation inside delayed asynchronous execution code blocks
  /// to bypass bad memory exceptions if components unmount before queries complete.
  ///
  /// * [state]: The updated state variation block to deploy downstream.
  ///
  /// ### Example:
  /// ```dart
  /// void loadProfile() async {
  ///   final data = await _repo.fetchProfile();
  ///   // Safely updates UI even if the user leaves the screen during network lag
  ///   safeEmit(ProfileLoadedState(data));
  /// }
  /// ```
  void safeEmit(S state) {
    if (!isClosed) {
      emit(state);
    }
  }

  /// Intercepts the standard [Cubit] destruction sequence lifecycle pipeline.
  ///
  /// Ensures any active network transactions or worker threads managed by [runCancelable]
  /// are immediately aborted upon closure to clean up leaks cleanly.
  @override
  Future<void> close() async {
    await _operation?.cancel();
    return super.close();
  }
}
