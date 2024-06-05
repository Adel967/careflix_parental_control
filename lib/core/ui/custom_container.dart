import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:flutter/cupertino.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.child, required this.padding, this.radius});
  final Widget child;
  final double padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: Styles.colorPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(radius ?? 15),
            border: Border.all(color: Styles.colorPrimary, width: 2)),
        child: child);
  }
}
