part of 'connecting_cubit.dart';

@immutable
abstract class ConnectingState extends Equatable {}

class ConnectingInitial extends ConnectingState {
  @override
  List<Object?> get props => [];
}

class ConnectingLoading extends ConnectingState {
  @override
  List<Object?> get props => [];
}

class ConnectingLoaded extends ConnectingState {
  final bool hasParentalControl;

  ConnectingLoaded({
    required this.hasParentalControl,
  });

  @override
  List<Object?> get props => [
        this.hasParentalControl,
      ];
}

class ConnectingError extends ConnectingState {
  final String error;

  ConnectingError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
