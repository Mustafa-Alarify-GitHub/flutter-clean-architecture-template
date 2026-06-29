import 'package:flutter/material.dart';

/// An extension that provides clean, chaining utility methods on [Widget]
/// to rapidly apply spatial padding configurations without structural nesting.
extension PaddingExtension on Widget {
  
  /// Wraps the current widget with [Padding] using customized or uniform padding spaces.
  ///
  /// * [value]: Explicit configuration dimensions. Defaults to [EdgeInsets.all(8)].
  ///
  /// ### Example:
  /// ```dart
  /// const Text('Hello').padding(const EdgeInsets.symmetric(vertical: 12, horizontal: 16));
  /// ```
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Padding(padding: value, child: this);

  /// Wraps the current widget with symmetric horizontal padding.
  ///
  /// * [value]: Horizontal padding thickness. Defaults to `8`.
  ///
  /// ### Example:
  /// ```dart
  /// const Text('Horizontal').paddingHorizontal(16.0);
  /// ```
  Widget paddingHorizontal([double value = 8]) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  /// Wraps the current widget with symmetric vertical padding.
  ///
  /// * [value]: Vertical padding thickness. Defaults to `8`.
  ///
  /// ### Example:
  /// ```dart
  /// const Text('Vertical').paddingVertical(24.0);
  /// ```
  Widget paddingVertical([double value = 8]) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );
}

/// An extension that provides quick flexible expansion methods on [Widget] 
/// when placed inside linear flex structures like [Row], [Column], or [Flex].
extension ExpandedExtension on Widget {
  
  /// Wraps the current widget with an [Expanded] layout modifier.
  ///
  /// * [flex]: The structural distribution factor sizing this widget relative to siblings. Defaults to `1`.
  ///
  /// ### Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Container(height: 50, color: Colors.red),
  ///     const MyMainContent().expanded(flex: 2),
  ///   ],
  /// )
  /// ```
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);
}

/// An extension providing declarative, reactive visibility switches on [Widget].
extension VisibilityExtension on Widget {
  
  /// Returns the current widget if [isVisible] is true; otherwise, returns an empty [SizedBox.shrink].
  ///
  /// This optimizes UI tree cleanups by swapping out hidden components immediately.
  ///
  /// * [isVisible]: Condition dictating whether to display the component.
  ///
  /// ### Example:
  /// ```dart
  /// const CircularProgressIndicator().visible(isLoading == true);
  /// ```
  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();
}

/// An extension to easily wrap a [Widget] with structural outer spatial margins.
extension MarginExtension on Widget {
  
  /// Wraps the current widget inside a [Container] to apply target layout margins.
  ///
  /// * [value]: Absolute margin dimension boundaries. Defaults to [EdgeInsets.all(8)].
  ///
  /// ### Example:
  /// ```dart
  /// const Card().margin(const EdgeInsets.only(top: 20));
  /// ```
  Widget margin([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Container(margin: value, child: this);
}

/// An extension to manage alignment placements of a [Widget].
extension AlignExtension on Widget {
  
  /// Wraps the current widget with an [Align] modifier to dictate its position within its parent boundaries.
  ///
  /// * [alignment]: Exact positioning anchor coordinate. Defaults to [Alignment.center].
  ///
  /// ### Example:
  /// ```dart
  /// const Text('Right Aligned').align(Alignment.centerRight);
  /// ```
  Widget align([Alignment alignment = Alignment.center]) =>
      Align(alignment: alignment, child: this);
}

/// An extension to safeguard [Widget] elements from screen notches, status bars, and hardware cutouts.
extension SafeAreaExtension on Widget {
  
  /// Wraps the current widget inside a [SafeArea] structure.
  ///
  /// * [top]: Avoids overlapping top hardware/status notifications. Defaults to `true`.
  /// * [bottom]: Avoids overlapping bottom system navigation indicators. Defaults to `true`.
  /// * [left]: Protects left device edge boundaries. Defaults to `true`.
  /// * [right]: Protects right device edge boundaries. Defaults to `true`.
  ///
  /// ### Example:
  /// ```dart
  /// const MyCustomScaffoldBody().withSafeArea(bottom: false);
  /// ```
  Widget withSafeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(top: top, bottom: bottom, left: left, right: right, child: this);
}

/// An extension to cleanly position a [Widget] directly in the absolute center of its parent space.
extension CenterExtension on Widget {
  
  /// Wraps the current widget with a [Center] alignment component.
  ///
  /// ### Example:
  /// ```dart
  /// const Text('Centered Text').center();
  /// ```
  Widget center() => Center(child: this);
}