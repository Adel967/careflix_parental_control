import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/layers/bloc/search/search_cubit.dart';
import 'package:careflix_parental_control/layers/data/model/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/state/app_state.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/ui/confirm_dialog.dart';
import '../../../../core/ui/error_widget.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../../l10n/local_provider.dart';
import '../../../bloc/rule/rule_cubit.dart';
import '../../../data/model/rule.dart';

class SearchBlockScreen extends StatefulWidget {
  SearchBlockScreen({super.key});

  @override
  State<SearchBlockScreen> createState() => _SearchBlockScreenState();
}

class _SearchBlockScreenState extends State<SearchBlockScreen> {
  final _ruleCubit = sl<RuleCubit>();

  final _searchCubit = sl<SearchCubit>();

  final _searchDelayer = Debouncer();

  String lastSearch = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchCubit.searchShow("");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context, listen: true);
    final Rule? rule = provider.rule;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<RuleCubit, RuleState>(
          bloc: _ruleCubit,
          listener: (context, state) async {
            print(state);
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
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          //controller: _titleController,
                          maxLines: 1,
                          textDirection: Provider.of<LocaleProvider>(context,
                                          listen: false)
                                      .locale
                                      .languageCode !=
                                  'ar'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          textAlign: Provider.of<LocaleProvider>(context,
                                          listen: false)
                                      .locale
                                      .languageCode !=
                                  'ar'
                              ? TextAlign.left
                              : TextAlign.right,
                          decoration: InputDecoration(
                              hintText: S.of(context).search,
                              prefixIcon: Icon(Icons.search)),
                          onChanged: (value) {
                            if (value != lastSearch) {
                              lastSearch = value;
                              _searchDelayer.run(() {
                                _searchCubit.searchShow(value);
                              });
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  bloc: _searchCubit,
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return WaitingWidget();
                    } else if (state is SearchError) {
                      return Center(
                        child: ErrorWidgetScreen(
                          message: state.error,
                          func: () {},
                        ),
                      );
                    } else if (state is SearchLoaded) {
                      if (state.shows.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: state.shows.length,
                          itemBuilder: (context, index) {
                            Show show = state.shows[index];
                            return Container(
                              width: double.infinity,
                              height: 40,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xFF1C1F32),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Styles.colorPrimary,
                                        blurRadius: 3,
                                        offset: Offset(0.0, 0.0))
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Text(
                                        show.title,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () async {
                                              final result =
                                                  await showDialog<bool?>(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (BuildContext
                                                        context) =>
                                                    ConfirmationDialog(
                                                        isWithWarningLogo: true,
                                                        message:
                                                            "Are you Sure that you want to ${rule != null ? rule!.blockedShowsId!.contains(show.id) ? "unblock" : "block" : "block"}"),
                                              );
                                              if (result != null && result) {
                                                List<String> ids = [];
                                                if (rule != null) {
                                                  ids = List.from(
                                                      rule!.blockedShowsId!);
                                                  if (ids
                                                      .contains(show.title)) {
                                                    ids.removeWhere((element) =>
                                                        element == show.title);
                                                  } else {
                                                    ids.add(show.title);
                                                  }
                                                }
                                                print(ids);
                                                _ruleCubit.setRule(rule != null
                                                    ? rule.copyWith(
                                                        blockedShows: ids)
                                                    : Rule(blockedShowsId: [
                                                        show.title
                                                      ]));
                                              }
                                            },
                                            icon: Icon(
                                              rule != null
                                                  ? rule!.blockedShowsId!
                                                          .contains(show.title)
                                                      ? Icons.lock_open
                                                      : Icons.block
                                                  : Icons.lock_open,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text("No Shows"),
                        );
                      }
                    }
                    return SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
