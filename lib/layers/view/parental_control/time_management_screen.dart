import 'package:careflix_parental_control/core/app/state/app_state.dart';
import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/core/ui/custom_container.dart';
import 'package:careflix_parental_control/layers/bloc/rule/rule_cubit.dart';
import 'package:careflix_parental_control/layers/view/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/loaders/loading_overlay.dart';
import '../../../core/utils.dart';
import '../../../injection_container.dart';
import '../../data/model/rule.dart';

class TimeManagementScreen extends StatefulWidget {
  const TimeManagementScreen({super.key, this.withoutSaveButton = false});
  final bool withoutSaveButton;

  @override
  State<TimeManagementScreen> createState() => _TimeManagementScreenState();
}

class _TimeManagementScreenState extends State<TimeManagementScreen> {
  final _ruleCubit = sl<RuleCubit>();
  Rule? oldRule;
  RangeValues rangeValues = RangeValues(0, 24);
  List<DateTime> selectedDates = [];
  getTime(int time) {
    if (time < 12) {
      if (time == 0) {
        time += 12;
      }
      return "${time} Am";
    } else {
      if (time > 12) {
        time -= 12;
      }
      return "${time} ${time < 12 ? "Pm" : "Am"}";
    }
  }

  datePicker() {
    DateTime now = DateTime.now();
    return SfDateRangePicker(
      backgroundColor: Colors.transparent,
      minDate: now,
      maxDate: DateTime(
          now.year, now.month + 1, DateTime(now.year, now.month + 2, 0).day),
      selectionColor: Styles.colorPrimary,
      selectionTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      todayHighlightColor: Styles.colorPrimary,
      headerHeight: 50,
      monthViewSettings: DateRangePickerMonthViewSettings(
          firstDayOfWeek: 6,
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(color: Colors.white, fontSize: 16))),
      initialSelectedDates: selectedDates,
      allowViewNavigation: false,
      navigationMode: DateRangePickerNavigationMode.snap,
      showNavigationArrow: true,
      selectionMode: DateRangePickerSelectionMode.multiple,
      headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
          textStyle: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center),
      monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: TextStyle(color: Colors.white, fontSize: 18),
          todayTextStyle: TextStyle(color: Styles.colorPrimary),
          disabledDatesTextStyle: TextStyle(color: Colors.grey)),
      view: DateRangePickerView.month,
      onSelectionChanged: (selected) async {
        if (selected.value.length > selectedDates.length) {
          final date = selected.value.last;
          selectedDates.add(date);
        } else {
          List<DateTime> output = [];
          selectedDates.forEach((element) {
            if (!selected.value.contains(element)) {
              output.add(element);
            }
          });
          String date = output.first.toString().replaceRange(10, null, "");
          if (selectedDates.contains(output.first)) {
            print("allow");
            selectedDates.remove(output.first);
          } else {
            print("unblock");
            selectedDates.remove(output.first);
          }
        }
      },
    );
  }

  setData(Rule? rule) {
    print("sss");
    if (rule != null &&
        (oldRule == null || (oldRule != null && oldRule != rule))) {
      rangeValues =
          RangeValues(rule.openTime!.toDouble(), rule.closeTime!.toDouble());
      selectedDates = rule.blockedDates!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
      oldRule = rule;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context, listen: true);
    final Rule? rule = provider.rule;
    setData(rule);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Time Management"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<RuleCubit, RuleState>(
          bloc: _ruleCubit,
          listener: (context, state) async {
            if (state is RuleUploading) {
              LoadingOverlay.of(context).show();
            } else if (state is RuleUploaded) {
              LoadingOverlay.of(context).hide();
              await Provider.of<AppState>(context, listen: false).getRule();
            } else if (state is RuleUploadingError) {
              LoadingOverlay.of(context).hide();
              Utils.showSnackBar(context, state.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          verticalData(
                              "Open At", getTime(rangeValues.start.floor())),
                          verticalData("Total hours",
                              "${rangeValues.end.floor() - rangeValues.start.floor()} hours"),
                          verticalData(
                              "Close At", getTime(rangeValues.end.floor()))
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                            inactiveTickMarkColor: Colors.transparent,
                            activeTickMarkColor: Colors.transparent,
                            showValueIndicator: ShowValueIndicator.always),
                        child: RangeSlider(
                          min: 0,
                          max: 24,
                          values: rangeValues,
                          activeColor: Styles.colorPrimary,
                          labels: RangeLabels("${rangeValues.start.floor()} ",
                              "${rangeValues.end.floor()} "),
                          divisions: 24,
                          onChanged: (RangeValues value) {
                            if (value.start == value.end) {
                              return;
                            }
                            print("done");
                            setState(() {
                              rangeValues = value;
                            });
                          },
                        ),
                      ),
                      CommonSizes.vSmallSpace,
                      CustomContainer(
                          child: Column(
                            children: [
                              Text(
                                "Blocked Days",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              datePicker()
                            ],
                          ),
                          padding: 5.0),
                    ],
                  ),
                ),
                Visibility(
                  visible: !widget.withoutSaveButton,
                  child: ElevatedButton(
                    onPressed: () {
                      _ruleCubit.setRule(rule != null
                          ? rule.copyWith(
                              openTime: rangeValues.start.toInt(),
                              closeTime: rangeValues.end.toInt(),
                              blockedDates: selectedDates,
                            )
                          : Rule(
                              openTime: rangeValues.start.toInt(),
                              closeTime: rangeValues.end.toInt(),
                              blockedDates: selectedDates,
                            ));
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Styles.colorPrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column verticalData(String title, data) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        CommonSizes.vSmallestSpace5v,
        Text(
          data,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
