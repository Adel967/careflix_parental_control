part of 'search_cubit.dart';

@immutable
abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Show> shows;

  SearchLoaded({
    required this.shows,
  });

  @override
  List<Object?> get props => [
        this.shows,
      ];
}

class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
