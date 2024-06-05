import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/core/constants.dart';
import 'package:careflix_parental_control/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app/state/app_state.dart';
import '../../../../injection_container.dart';
import '../../../bloc/rule/rule_cubit.dart';
import '../../../data/model/rule.dart';
import '../../widgets/custom_drawer.dart';

class BlockScreen extends StatefulWidget {
  BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  final _ruleCubit = sl<RuleCubit>();

  List<String> _selectedCategories = [];

  setData(Rule? rule) {
    if (rule != null && (rule!.blockedCategories! != _selectedCategories)) {
      _selectedCategories = rule!.blockedCategories!;
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
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Blocked Categories",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 40,
            child: ListView.builder(
              key: PageStorageKey('kinds'),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: Constants.showCategories.length,
              itemBuilder: (context, index) {
                String category = Constants.showCategories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedCategories.contains(category)) {
                        _selectedCategories.remove(category);
                      } else {
                        _selectedCategories.add(category);
                      }
                    });
                    _ruleCubit.setRule(
                        rule!.copyWith(blockedCategories: _selectedCategories));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _selectedCategories.contains(category)
                            ? Styles.colorPrimary
                            : Styles.colorPrimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 0.7,
            indent: 10,
            endIndent: 10,
            color: Styles.colorPrimary,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(
                flex: 5,
                child: Text(
                  "Blocked Shows",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RoutePaths.SearchBlockScreen),
                  icon: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: rule != null && rule!.blockedShowsId!.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: rule!.blockedShowsId!.length,
                      itemBuilder: (context, index) {
                        String title = rule!.blockedShowsId![index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    title,
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
                                      child: Icon(
                                        Icons.block,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "There is not any blocked show!",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
        ],
      ),
    );
  }
}
