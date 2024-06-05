import 'package:careflix_parental_control/core/configuration/assets.dart';
import 'package:careflix_parental_control/core/ui/save_cancel_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../configuration/styles.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {Key? key, required this.message, this.isWithWarningLogo = false})
      : super(key: key);
  final String message;
  final bool isWithWarningLogo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60.0.r)),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              isWithWarningLogo
                  ? Column(
                      children: [
                        Image.asset(
                          AssetsLink.WARNING_LOGO,
                          width: 80.h,
                          height: 80.h,
                        ),
                        CommonSizes.vSmallSpace,
                      ],
                    )
                  : SizedBox.shrink(),
              Text(
                message,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              CommonSizes.vSmallSpace,
              SaveCancelButtons(
                onSavePressed: () {
                  Navigator.of(context).pop(true);
                },
                primaryText: S.of(context).yes,
                secondaryText: S.of(context).no,
                onCancelPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
