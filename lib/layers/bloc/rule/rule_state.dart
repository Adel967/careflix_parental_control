part of 'rule_cubit.dart';

@immutable
abstract class RuleState extends Equatable {}

class RuleInitial extends RuleState {
  @override
  List<Object?> get props => [];
}

class RuleUploading extends RuleState {
  @override
  List<Object?> get props => [];
}

class RuleUploaded extends RuleState {
  @override
  List<Object?> get props => [];
}

class RuleUploadingError extends RuleState {
  final String error;

  RuleUploadingError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
