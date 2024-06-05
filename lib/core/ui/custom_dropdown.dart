import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configuration/styles.dart';

typedef OnChanged = void Function(dynamic value);

class CustomDropDown<T> extends StatelessWidget {
  CustomDropDown({
    required this.hintText,
    required this.dropDownItems,
    this.onChanged,
    this.selectedItemBuilder,
    this.titleTextStyle,
    this.padding,
    this.verticalDropdownPadding,
    this.horizontalDropdownPadding,
    this.dropdownKey,
    this.textKey,
    this.color,
    this.autoValidateMode,
    this.validator,
    this.selectedValue,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final OnChanged? onChanged;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final List<DropdownMenuItem> dropDownItems;
  final TextStyle? titleTextStyle;
  final double? padding;
  final Key? dropdownKey, textKey;
  final double? verticalDropdownPadding;
  final double? horizontalDropdownPadding;
  final Color? color;
  final String? Function()? validator;
  final AutovalidateMode? autoValidateMode;
  final T? selectedValue;

  late final InputBorder inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: color ?? Styles.backgroundColor,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      iconSize: 90.r,
      isExpanded: true,
      hint: Center(
        widthFactor: 1,
        child: Text(
          hintText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Styles.fontSize5,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          key: textKey,
        ),
      ),
      focusColor: Colors.transparent,
      decoration: InputDecoration(
          border: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          fillColor: color ??
              (Theme.of(context).textTheme == ThemeMode.dark
                  ? Theme.of(context).dividerColor
                  : Theme.of(context).dividerColor.withOpacity(0.2)),
          filled: true,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: Styles.fontSize6,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalDropdownPadding ?? 48.h,
            vertical: verticalDropdownPadding ?? 0,
          ),
          errorBorder: inputBorder.copyWith(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          focusedErrorBorder: inputBorder.copyWith(
              borderSide: BorderSide(
            color: Colors.red,
          ))),
      autovalidateMode: autoValidateMode,
      selectedItemBuilder: selectedItemBuilder,
      items: dropDownItems,
      value: selectedValue,
      onChanged: onChanged,
    );
  }
}
