import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../injection_container.dart';
import '../configuration/styles.dart';

class SaveCancelButtons extends StatelessWidget {
  const SaveCancelButtons({
    required this.onSavePressed,
    this.onCancelPressed,
    this.primaryText,
    this.secondaryText,
    this.isPrimaryOnStart = true,
    this.primaryButtonKey,
    this.secondaryButtonKey,
    this.isSecondaryShown = true,
    this.primaryPadding,
    this.secondaryPadding,
    this.radius,
    this.primaryColor,
    Key? key,
  }) : super(key: key);
  final VoidCallback onSavePressed;
  final VoidCallback? onCancelPressed;
  final String? primaryText, secondaryText;
  final bool isPrimaryOnStart, isSecondaryShown;
  final Key? primaryButtonKey, secondaryButtonKey;
  final EdgeInsets? primaryPadding, secondaryPadding;
  final double? radius;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: isPrimaryOnStart
            ? IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FilledButton(
                          key: primaryButtonKey,
                          onPressed: onSavePressed,
                          style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              backgroundColor:
                                  primaryColor ?? Styles.colorPrimary),
                          child: Text(
                            primaryText ?? S.of(context).save,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          )),
                    ),
                    if (isSecondaryShown) CommonSizes.hSmallerSpace,
                    if (isSecondaryShown)
                      Expanded(
                        child: FilledButton(
                            key: secondaryButtonKey,
                            onPressed: onCancelPressed,
                            style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 40.h),
                                backgroundColor: Colors.white),
                            child: Text(
                              secondaryText ?? S.of(context).cancel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                      ),
                  ],
                ),
              )
            : IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (isSecondaryShown)
                        Expanded(
                          child: FilledButton(
                              key: secondaryButtonKey,
                              onPressed: onCancelPressed,
                              style: FilledButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  backgroundColor: Colors.grey.shade400),
                              child: Text(
                                secondaryText ?? S.of(context).cancel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                              )),
                        ),
                      if (isSecondaryShown) CommonSizes.hSmallerSpace,
                      Expanded(
                        child: FilledButton(
                            key: primaryButtonKey,
                            onPressed: onSavePressed,
                            style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 40.h),
                                backgroundColor:
                                    primaryColor ?? Styles.colorPrimary),
                            child: Text(
                              primaryText ?? S.of(context).save,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                      ),
                    ]),
              ),
      );
}
