import 'package:mottaina_eat/style/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    super.key,
    this.style,
    this.height,
    this.width,
    this.backgroundColor = ColorName.greySecondary,
    this.foregroundColor,
    this.side = BorderSide.none,
    this.isWithWidget = false,
    this.text,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.isMini = false,
    this.isBottomNavigationBar = false,
    this.circularColor,
    this.isFittedBox = false,
    this.isViewInsetsBottom = false,
    this.childWidget,
  });

  final String? text;
  final TextStyle? style;
  final double? height;
  final double? width;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final Color? circularColor;
  final BorderSide side;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? childWidget;
  final bool isMini;
  final bool isBottomNavigationBar;
  final bool isFittedBox;
  final bool isViewInsetsBottom;
  final bool isWithWidget;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            side: side,
          ),
          child: isWithWidget
              ? childWidget
              : FittedBox(
                  child: Text(
                    text!,
                    style: style ??
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isMini ? 14 : 16,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      );
}
