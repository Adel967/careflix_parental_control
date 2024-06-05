import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText({super.key, required this.textWidget});
  final Text textWidget;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: textWidget,
    );
  }
}
