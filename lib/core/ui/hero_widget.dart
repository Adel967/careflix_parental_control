import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.child, required this.tag});
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: tag,
        child: Material(
          type: MaterialType.transparency,
          child: child,
        ));
  }
}
