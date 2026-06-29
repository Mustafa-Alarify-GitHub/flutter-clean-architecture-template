import 'package:flutter/material.dart';

/// An extension on [BuildContext] providing streamlined, chainable accessors
/// for global application themes, screen layout constraints, typography configurations, and basic navigational routing rules.
extension ContextExtensions on BuildContext {
  // ===========================================================================
  // Theme Accessors
  // ===========================================================================

  /// Provides instantaneous access to the current scoped global [ThemeData].
  ///
  /// ### Example:
  /// ```dart
  /// final primaryColor = context.theme.primaryColor;
  /// ```
  ThemeData get theme => Theme.of(this);

  /// Exposes the global active context color palette structure defined inside [ThemeData.colorScheme].
  ///
  /// ### Example:
  /// ```dart
  /// Container(color: context.colors.surface);
  /// ```
  ColorScheme get colors => theme.colorScheme;

  /// Exposes the current global typographic structural text guidelines defined inside [ThemeData.textTheme].
  ///
  /// ### Example:
  /// ```dart
  /// Text('Styled Text', style: context.text.displayLarge);
  /// ```
  TextTheme get text => theme.textTheme;

  // ===========================================================================
  // Viewport Sizing Layouts
  // ===========================================================================

  /// Retrieves the absolute physical [Size] profile of the active device display screen via [MediaQuery].
  Size get screenSize => MediaQuery.of(this).size;

  /// Extracts the precise current viewport layout width constraint of the hosting window.
  ///
  /// ### Example:
  /// ```dart
  /// Container(width: context.width * 0.5); // Allocates exactly 50% of the active device width.
  /// ```
  double get width => screenSize.width;

  /// Extracts the precise current viewport layout height constraint of the hosting window.
  ///
  /// ### Example:
  /// ```dart
  /// Container(height: context.height * 0.25); // Allocates exactly 24% of the active device height.
  /// ```
  double get height => screenSize.height;

  // ===========================================================================
  // Typography Shortcut Subsets
  // ===========================================================================

  /// Returns the default global font style guideline mapped to [TextTheme.titleLarge].
  TextStyle get title => text.titleLarge!;

  /// Returns the default global font style guideline mapped to [TextTheme.titleMedium].
  TextStyle get subtitle => text.titleMedium!;

  /// Returns the default global font style guideline mapped to [TextTheme.bodyMedium].
  TextStyle get body => text.bodyMedium!;

  /// Returns the default global font style guideline mapped to [TextTheme.bodySmall].
  TextStyle get caption => text.bodySmall!;

  // ===========================================================================
  // Imperative Routing / Navigation
  // ===========================================================================

  /// Pops the topmost route off the current [Navigator] stack, returning an optional data payload.
  ///
  /// * [result]: The optional parameter object payload routed back to the initial stack request invoke.
  ///
  /// ### Example:
  /// ```dart
  /// context.pop<bool>(true);
  /// ```
  void pop<T>([T? result]) => Navigator.pop(this, result);

  /// Pushes a new view component widget onto the [Navigator] stack utilizing a native [MaterialPageRoute].
  ///
  /// * [page]: The destination UI screen widget component to transition into view.
  ///
  /// ### Example:
  /// ```dart
  /// context.push(const ProfileDetailsPage());
  /// ```
  Future<T?> push<T>(Widget page) {
    return Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }
}
