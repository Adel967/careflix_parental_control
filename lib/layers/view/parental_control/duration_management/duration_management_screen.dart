import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/core/enum.dart';
import 'package:careflix_parental_control/core/ui/responsive_text.dart';
import 'package:careflix_parental_control/core/utils.dart';
import 'package:careflix_parental_control/layers/bloc/rule/rule_cubit.dart';
import 'package:careflix_parental_control/layers/view/parental_control/duration_management/duration_rule_creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/state/app_state.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../injection_container.dart';
import '../../../data/model/duration_rule.dart';
import '../../../data/model/rule.dart';
import '../../widgets/custom_drawer.dart';

class DurationManagementScreen extends StatefulWidget {
  const DurationManagementScreen({super.key});

  @override
  State<DurationManagementScreen> createState() =>
      _DurationManagementScreenState();
}

class _DurationManagementScreenState extends State<DurationManagementScreen> {
  final _ruleCubit = sl<RuleCubit>();

  List<DurationRule> list = [];

  List<DurationRule> selectedItem = [];

  bool delete = false;

  bool selectAll = false;

  setData(Rule? rule) {
    if (rule != null) {
      if (list != rule.durationRules!) {
        list = rule.durationRules!;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context, listen: true);
    final Rule? rule = provider.rule;
    setData(rule);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "Duration Management",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.add),
              color: list.length < 7 && !delete ? Colors.white : Colors.grey,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 30,
              onPressed: () {
                if (!delete) {
                  if (list.length < 7) {
                    showDialog(
                        context: context,
                        builder: (_) => DurationRuleCreator());
                  } else {
                    Utils.showSnackBar(
                        context, "You can't have more than 7 usage rules!");
                  }
                }
              },
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<RuleCubit, RuleState>(
        bloc: _ruleCubit,
        listener: (context, state) async {
          if (state is RuleUploading) {
            LoadingOverlay.of(context).show();
          } else if (state is RuleUploaded) {
            await Provider.of<AppState>(context, listen: false).getRule();
            LoadingOverlay.of(context).hide();
          } else if (state is RuleUploadingError) {
            LoadingOverlay.of(context).hide();
            Utils.showSnackBar(context, state.error);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: 15),
                duration: Duration(milliseconds: 600),
                height: delete ? 100 : 0,
                child: Visibility(
                  visible: delete,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: ResponsiveText(
                            textWidget: Text(
                              "${selectedItem.length} selected",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25, height: 1),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    selectAll = !selectAll;
                                    if (selectAll) {
                                      selectedItem.clear();
                                      for (int i = 0; i < list.length; i++) {
                                        selectedItem.add(list[i]);
                                      }
                                    } else {
                                      selectedItem.clear();
                                    }
                                    setState(() {});
                                  },
                                  child: delete
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 22,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                      color: selectAll
                                                          ? Colors.red
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color: Colors.red),
                                                      shape: BoxShape.circle),
                                                  child: selectAll
                                                      ? Icon(
                                                          Icons.done,
                                                          color: Colors.white,
                                                          size: 18,
                                                        )
                                                      : SizedBox.shrink()),
                                            ),
                                            Flexible(
                                                child: SizedBox(
                                              height: 5,
                                            )),
                                            Flexible(
                                                child: Text(
                                              "All",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )),
                                          ],
                                        )
                                      : SizedBox.shrink()),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    delete = false;
                                    selectAll = false;
                                    selectedItem.clear();
                                    setState(() {});
                                  },
                                  child: delete
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Flexible(
                                                child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 30,
                                            )),
                                            Flexible(
                                              child: Text("cancel",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  )),
                                            )
                                          ],
                                        )
                                      : SizedBox.shrink())
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    DurationRule durationRule = list[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (delete) {
                            if (selectedItem.contains(durationRule)) {
                              selectedItem.remove(durationRule);
                            } else {
                              selectedItem.add(durationRule);
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => DurationRuleCreator(
                                      durationRule: list[index],
                                    ));
                          }
                          setState(() {});
                        },
                        onLongPress: () {
                          delete = true;
                          selectedItem.add(durationRule);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 120,
                          decoration: BoxDecoration(
                              color: Color(0xFF1C1F32),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Styles.colorPrimary,
                                    blurRadius: 6,
                                    offset: Offset(0.0, 0.0))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              delete
                                  ? Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: selectedItem
                                                        .contains(durationRule)
                                                    ? Colors.red
                                                    : Colors.transparent,
                                                border: Border.all(
                                                    color: Colors.red),
                                                shape: BoxShape.circle),
                                            child: selectedItem
                                                    .contains(durationRule)
                                                ? Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )
                                                : SizedBox.shrink()),
                                        SizedBox(
                                          width: 15,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              Text(
                                durationRule.weekDay.toShortString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${durationRule.hour < 10 ? durationRule.hour.toString().padLeft(2, "0") : durationRule.hour}:${durationRule.minute < 10 ? durationRule.minute.toString().padLeft(2, "0") : durationRule.minute} ${durationRule.hour > 1 ? "hours" : "hour"}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              delete
                                  ? SizedBox.shrink()
                                  : Switch(
                                      value: durationRule.active,
                                      onChanged: (value) {
                                        _ruleCubit.setRule(rule!.copyWith(
                                            durationRules: List.from(
                                                rule!.durationRules!.map((e) {
                                          if (e.weekDay ==
                                              durationRule.weekDay) {
                                            e.active = !durationRule.active;
                                          }
                                          return e;
                                        }).toList())));
                                      },
                                      inactiveTrackColor: Colors.red.shade300,
                                      activeColor: Colors.white,
                                      activeTrackColor: Colors.green.shade300,
                                      focusColor: Colors.blue,
                                    )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AnimatedContainer(
                padding: EdgeInsets.only(top: 5),
                duration: Duration(milliseconds: 600),
                height: selectedItem.length > 0 ? 80 : 0,
                child: GestureDetector(
                  onTap: () async {
                    List<DurationRule> durationRules = rule!.durationRules!;
                    durationRules.removeWhere(
                        (element) => selectedItem.contains(element));
                    _ruleCubit.setRule(rule!
                        .copyWith(durationRules: List.from(durationRules)));

                    delete = false;
                    selectAll = false;
                    selectedItem.clear();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: selectedItem.length > 0 ? 30 : 0,
                      )),
                      Expanded(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: selectedItem.length > 0 ? 18 : 0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
