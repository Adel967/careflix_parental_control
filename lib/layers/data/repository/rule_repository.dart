import 'package:careflix_parental_control/core/exception/app_exceptions.dart';
import 'package:careflix_parental_control/layers/data/data_provider/rule_provider.dart';
import 'package:careflix_parental_control/layers/data/model/rule.dart';

class RuleRepository {
  RuleProvider _ruleProvider;

  RuleRepository(this._ruleProvider);

  Future<Rule> getRule() async {
    final res = await _ruleProvider.getRule();
    if (!res.exists) {
      throw AppException("There is not any parental Control");
    }
    return Rule.fromMap(res);
  }

  Future<void> setRule(Rule rule) async {
    await _ruleProvider.setRule(rule);
  }
}
