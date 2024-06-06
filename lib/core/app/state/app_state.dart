import 'package:careflix_parental_control/layers/data/data_provider/rule_provider.dart';
import 'package:careflix_parental_control/layers/data/repository/rule_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../injection_container.dart';
import '../../../layers/data/model/rule.dart';
import '../../../layers/data/model/user_model.dart';
import '../../../layers/data/repository/profile_repository.dart';

class AppState extends ChangeNotifier {
  final _profileRpo = sl<ProfileRepository>();
  final _ruleRepo = sl<RuleRepository>();

  UserModel? _userModel;
  Rule? _rule;

  UserModel get user => _userModel!;
  Rule? get rule => _rule;

  Future init() async {
    await getUserProfile();
    await getRule();
  }

  Future getUserProfile() async {
    _userModel = await _profileRpo.getUserProfile();
  }

  Future getRule() async {
    try {
    _rule = await _ruleRepo.getRule();
    print(_rule);
    notifyListeners();
    } catch (e) {
      print("error");
    }
  }
}
