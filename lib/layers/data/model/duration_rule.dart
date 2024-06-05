import 'package:equatable/equatable.dart';

import '../../../core/enum.dart';

class DurationRule extends Equatable {
  WeekDay weekDay;
  int hour;
  int minute;
  bool active;

  DurationRule(
      {required this.weekDay,
      required this.hour,
      required this.minute,
      required this.active});

  Map<String, dynamic> toMap() {
    return {
      'DurationRule':
          "${this.weekDay.toShortString()}|${this.hour.toString()}|${this.minute.toString()}|${this.active}"
    };
  }

  factory DurationRule.fromMap(Map<String, dynamic> map) {
    return DurationRule(
      weekDay: map['weekDay'] as WeekDay,
      hour: map['hour'] as int,
      minute: map['minute'] as int,
      active: map['active'] as bool,
    );
  }

  factory DurationRule.fromString(String text) {
    List<String> data = text.split('|');
    return DurationRule(
      weekDay: fromString(data[0]),
      hour: int.parse(data[1]),
      minute: int.parse(data[2]),
      active: bool.parse(data[3]),
    );
  }

  @override
  String toString() {
    return "${this.weekDay.toShortString()}|${this.hour.toString()}|${this.minute.toString()}|${this.active}";
  }

  DurationRule copyWith({
    WeekDay? weekDay,
    int? hour,
    int? minute,
    bool? active,
  }) {
    return DurationRule(
      weekDay: weekDay ?? this.weekDay,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      active: active ?? this.active,
    );
  }

  @override
  List<Object?> get props =>
      [this.weekDay, this.hour, this.minute, this.active];
}
