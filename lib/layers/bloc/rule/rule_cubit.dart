import 'package:bloc/bloc.dart';
import 'package:careflix_parental_control/layers/data/repository/rule_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../generated/l10n.dart';
import '../../../injection_container.dart';
import '../../data/model/rule.dart';

part 'rule_state.dart';

class RuleCubit extends Cubit<RuleState> {
  RuleCubit() : super(RuleInitial());

  final _ruleRepo = sl<RuleRepository>();

  setRule(Rule rule) async {
    emit(RuleUploading());
    try {
      await _ruleRepo.setRule(rule);
      emit(RuleUploaded());
    } catch (e) {
      emit(RuleUploadingError(error: S.current.thereIsAnError));
    }
  }
}
