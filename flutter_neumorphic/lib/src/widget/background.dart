import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/theme/neumorphic_theme.dart';

/// A container that takes the current [NeumorphicTheme] baseColor as backgroundColor
/// @see [NeumorphicTheme]
///
///
/// It can provide too a roundRect clip of the screen border using [borderRadius], [margin] and [backendColor]
///
/// ```
/// NeumorphicBackground(
///      borderRadius: BorderRadius.circular(12),
///      margin: EdgeInsets.all(12),
///      child: ...`
/// )
/// ```
@immutable
class NeumorphicBackground extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color backendColor;
  final BorderRadius? borderRadius;

  const NeumorphicBackground({Key? key, 
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backendColor = const Color(0xFF000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      color: backendColor,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: AnimatedContainer(
          color: NeumorphicTheme.baseColor(context),
          padding: padding,
          duration: const Duration(milliseconds: 100),
          child: child,
        ),
      ),
    );
  }
}
