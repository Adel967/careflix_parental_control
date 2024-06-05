import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/core/enum.dart';
import 'package:careflix_parental_control/layers/data/model/duration_rule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/state/app_state.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/ui/custom_container.dart';
import '../../../../core/utils.dart';
import '../../../../injection_container.dart';
import '../../../bloc/rule/rule_cubit.dart';
import '../../../data/model/rule.dart';

class DurationRuleCreator extends StatefulWidget {
  DurationRuleCreator({super.key, this.durationRule});

  final DurationRule? durationRule;

  @override
  State<DurationRuleCreator> createState() => _DurationRuleCreatorState();
}

class _DurationRuleCreatorState extends State<DurationRuleCreator> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  int hours = 0;
  int minutes = 0;
  List<WeekDay> selectedDays = [];
  List<WeekDay> disabledDays = [];

  final _ruleCubit = sl<RuleCubit>();

  setData(Rule? rule) async {
    if (rule != null) {
      if (rule.durationRules != null && rule.durationRules!.isNotEmpty) {
        disabledDays.clear();
        await Future.forEach(rule.durationRules!, (element) {
          disabledDays.add(element.weekDay);
        });
      }
    }
  }

  List<DurationRule> getDurationRules() {
    List<DurationRule> list = [];
    for (WeekDay weekDay in selectedDays) {
      list.add(DurationRule(
          weekDay: weekDay, hour: hours, minute: minutes, active: true));
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final provider = Provider.of<AppState>(context, listen: false);
    final Rule? rule = provider.rule;
    setData(rule);
    if (widget.durationRule != null) {
      hours = widget.durationRule!.hour;
      minutes = widget.durationRule!.minute;
    }
    hourController = FixedExtentScrollController(initialItem: hours);
    minuteController =
        FixedExtentScrollController(initialItem: (minutes / 10).round());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context, listen: true);
    final Rule? rule = provider.rule;
    setData(rule);
    return Dialog(
      backgroundColor: Styles.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: BlocListener<RuleCubit, RuleState>(
        bloc: _ruleCubit,
        listener: (context, state) async {
          if (state is RuleUploading) {
            LoadingOverlay.of(context).show();
          } else if (state is RuleUploaded) {
            await Provider.of<AppState>(context, listen: false).getRule();
            LoadingOverlay.of(context).hide();
            Navigator.of(context).pop();
          } else if (state is RuleUploadingError) {
            LoadingOverlay.of(context).hide();
            Utils.showSnackBar(context, state.error);
          }
        },
        child: CustomContainer(
          radius: 30,
          padding: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Time Duration",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              CommonSizes.vSmallestSpace5v,
              Text(
                "${hours < 10 ? hours.toString().padLeft(2, "0") : hours}:${minutes < 10 ? minutes.toString().padLeft(2, "0") : minutes} ${hours > 1 ? "hours" : "hour"}",
                style: TextStyle(color: Styles.colorPrimary, fontSize: 30),
              ),
              CommonSizes.vSmallestSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: hourController,
                          useMagnifier: false,
                          itemExtent: 64,
                          onSelectedItemChanged: (index) {
                            hours = index;
                            setState(() {});
                          },
                          looping: true,
                          children: List.generate(
                              11,
                              (index) => Center(
                                    child: Text(
                                      (index).toString(),
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      const Text(
                        ":",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: minuteController,
                          useMagnifier: false,
                          itemExtent: 64,
                          onSelectedItemChanged: (index) {
                            minutes = index * 10;
                            setState(() {});
                          },
                          looping: true,
                          children: List.generate(
                              6,
                              (index) => Center(
                                    child: Text(
                                      (index * 10).toString(),
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.2,
                indent: 40,
                endIndent: 40,
                color: Styles.colorPrimary,
              ),
              CommonSizes.vSmallestSpace,
              widget.durationRule != null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        getWeekDaysList().length,
                        (index) {
                          WeekDay weekDay = getWeekDaysList()[index];
                          return Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 3,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (disabledDays.contains(weekDay)) {
                                        Utils.showSnackBar(context,
                                            "You already have created a rule for this day!");
                                      } else {
                                        if (selectedDays.contains(weekDay)) {
                                          selectedDays.remove(weekDay);
                                        } else {
                                          selectedDays.add(weekDay);
                                        }
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color:
                                                selectedDays.contains(weekDay)
                                                    ? Styles.colorPrimary
                                                    : Styles.colorPrimary
                                                        .withOpacity(0.2),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Styles.colorPrimary,
                                                width: 1)),
                                        child: Center(
                                          child: Text(
                                            weekDay
                                                .toShortString()
                                                .substring(0, 1),
                                            style: TextStyle(
                                              color:
                                                  disabledDays.contains(weekDay)
                                                      ? Colors.grey
                                                      : Colors.white,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList()),
              CommonSizes.vSmallestSpace,
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (widget.durationRule != null) {
                            _ruleCubit.setRule(rule!.copyWith(
                                durationRules:
                                    List.from(rule!.durationRules!.map((e) {
                              if (e.weekDay == widget.durationRule!.weekDay) {
                                e.hour = hours;
                                e.minute = minutes;
                              }
                              return e;
                            }).toList())));
                          } else if (selectedDays.isNotEmpty) {
                            _ruleCubit.setRule(rule != null
                                ? rule.copyWith(
                                    durationRules: rule!.durationRules! +
                                        getDurationRules())
                                : Rule(durationRules: getDurationRules()));
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
