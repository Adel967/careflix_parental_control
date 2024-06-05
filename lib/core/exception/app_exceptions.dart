import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final _message;

  String? get message => _message;

  AppException(this._message);

  String toString() {
    return '$_message';
  }

  @override
  List<Object?> get props => [_message];
}
