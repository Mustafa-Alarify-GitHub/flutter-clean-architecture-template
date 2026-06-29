import 'package:flutter/material.dart';

/// An extension that provides convenient wrapper methods on [Widget]
/// to easily handle tap and gesture actions without nesting boilerplate widgets.
extension OnTapExtension on Widget {
  /// Wraps the current widget with an [InkWell] to provide visual material ripple ripples upon interaction.
  ///
  /// Use this method when you want to trigger an action and give the user feedback with a ripple effect.
  ///
  /// * [onTap]: The callback function executed when the widget is pressed.
  /// * [key]: An optional [Key] to uniquely identify the widget.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   width: 100,
  ///   height: 50,
  ///   color: Colors.blue,
  ///   child: const Text('Submit'),
  /// ).onTap(() {
  ///   print('Button Pressed with Material Ripple!');
  /// });
  /// ```
  Widget onTap(VoidCallback onTap, {Key? key}) {
    return InkWell(key: key, onTap: onTap, child: this);
  }

  /// Wraps the current widget with a [GestureDetector] for raw, non-visual tap tracking.
  ///
  /// Use this method when you need structural gesture interaction without enforcing material themes
  /// or visual ripple effects.
  ///
  /// * [onTap]: The callback function executed when the widget is tapped.
  /// * [key]: An optional [Key] to uniquely identify the widget.
  /// * [behavior]: Controls how hit testing behaves during gesture detection (e.g., [HitTestBehavior.opaque]).
  ///
  /// ### Example:
  /// ```dart
  /// Image.asset('assets/logo.png').onTapGesture(() {
  ///   print('Image Clicked cleanly without ripple effect.');
  /// }, behavior: HitTestBehavior.opaque);
  /// ```
  Widget onTapGesture(
    VoidCallback onTap, {
    Key? key,
    HitTestBehavior? behavior,
  }) {
    return GestureDetector(
      key: key,
      behavior: behavior,
      onTap: onTap,
      child: this,
    );
  }
}
