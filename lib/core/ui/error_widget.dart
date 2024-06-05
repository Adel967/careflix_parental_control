import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../configuration/assets.dart';
import '../configuration/styles.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final double width;
  final double height;
  final String message;
  final String? buttonLabel;
  final VoidCallback func;

  const ErrorWidgetScreen(
      {required this.message,
      this.width = 250,
      this.buttonLabel,
      this.height = 300,
      required this.func,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 70.w),
            padding: EdgeInsets.symmetric(horizontal: 130.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  AssetsLink.WARNING_LOGO,
                  width: 250.h,
                  height: 250.h,
                ),
                CommonSizes.vSmallSpace,
                Text(
                  message,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                CommonSizes.vBigSpace,
                FractionallySizedBox(
                  widthFactor: .6,
                  child: FilledButton(
                      onPressed: func,
                      style: FilledButton.styleFrom(
                          backgroundColor: Styles.colorPrimary),
                      child: Text(
                        buttonLabel ?? S.of(context).reload,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                      )),
                ),
                CommonSizes.vBigSpace,
              ],
            )),
      );
}
