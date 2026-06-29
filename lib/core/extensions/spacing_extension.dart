import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';

/// An extension on numeric types ([num]) providing convenient, screen-responsive layout spacers
/// and semantic dividers utilizing the [flutter_screenutil] sizing ecosystem.
extension SpacingExtension on num {
  /// Creates a responsive horizontal whitespace spacer box.
  ///
  /// The width automatically scales using screen-util's `.w` notation to adjust across device viewport widths.
  ///
  /// ### Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     const Text('Left'),
  ///     16.width, // Responsive horizontal gap
  ///     const Text('Right'),
  ///   ],
  /// )
  /// ```
  SizedBox get width => SizedBox(width: w);

  /// Creates a responsive vertical whitespace spacer box.
  ///
  /// The height automatically scales using screen-util's `.h` notation to adjust across device viewport heights.
  ///
  /// ### Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     const Text('Header Title'),
  ///     24.height, // Responsive vertical padding gap
  ///     const Text('Body content subtitle text goes here'),
  ///   ],
  /// )
  /// ```
  SizedBox get height => SizedBox(height: h);

  /// Generates a horizontal [Divider] encapsulated inside a custom height bounding constraint.
  ///
  /// The height bounds scale adaptively via `.h`, inheriting its color token directly from [AppColors.divider].
  ///
  /// ### Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     const Text('Item One'),
  ///     12.hDivider, // Horizontal dividing line wrapped in 12-logical-pixel scaled vertical container boundaries
  ///     const Text('Item Two'),
  ///   ],
  /// )
  /// ```
  Widget get hDivider => SizedBox(
    height: h,
    child: Divider(height: 0.h, color: AppColors.divider),
  );

  /// Generates a [VerticalDivider] encapsulated inside a custom width bounding constraint.
  ///
  /// The width bounds scale adaptively via `.w`, inheriting its color token directly from [AppColors.divider].
  ///
  /// ### Example:
  /// ```dart
  /// IntrinsicHeight(
  ///   child: Row(
  ///     children: [
  ///       const Text('Column A'),
  ///       20.vDivider, // Vertical structural separating line surrounded by a 20-pixel scaled box
  ///       const Text('Column B'),
  ///     ],
  ///   ),
  /// )
  /// ```
  Widget get vDivider => SizedBox(
    width: w,
    child: VerticalDivider(width: 0.w, color: AppColors.divider),
  );
}
