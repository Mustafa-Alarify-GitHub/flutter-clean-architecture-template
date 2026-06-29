import 'package:flutter/widgets.dart';

/// An extension providing utility layout transformers on [Widget]
/// to cleanly bridge the gap between standard boxes and specialized scrollable view contexts ([CustomScrollView]).
extension SliverExtensions on Widget {
  /// Transforms the current widget into a [SliverToBoxAdapter].
  ///
  /// Use this when you need to place a traditional box-model layout widget
  /// (like a [Container], [Card], or [Column]) inside a [CustomScrollView] alongside other sliver structures.
  ///
  /// ### Example:
  /// ```dart
  /// CustomScrollView(
  ///   slivers: [
  ///     const SliverAppBar(title: Text('Sliver Header')),
  ///     const MyStandardCard().toSliver(), // Instantly compatible with scroll view viewport
  ///   ],
  /// )
  /// ```
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);

  /// Transforms the current widget into a [SliverToBoxAdapter] wrapped with an [AnimatedSwitcher].
  ///
  /// Use this to smoothly transition visual states (such as switching out content layers or swapping states)
  /// natively on a sliver viewport boundary without forcing complex parent viewport structural recalculations.
  ///
  /// * [duration]: The timeline lifecycle window for completing animations. Defaults to `300 milliseconds`.
  /// * [transitionBuilder]: Custom entry/exit animation configurations. Defaults to [AnimatedSwitcher.defaultTransitionBuilder] (Fade transition).
  /// * [key]: Optional unique key to identify specific state nodes.
  ///
  /// ### Example:
  /// ```dart
  /// CustomScrollView(
  ///   slivers: [
  ///     isLoading
  ///         ? const LoadingWidget().toAnimatedSliver()
  ///         : const DataLoadedWidget().toAnimatedSliver(),
  ///   ],
  /// )
  /// ```
  SliverToBoxAdapter toAnimatedSliver({
    Duration duration = const Duration(milliseconds: 300),
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
    Key? key,
  }) {
    return SliverToBoxAdapter(
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder:
            transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
        key: key,
        child: this,
      ),
    );
  }
}
