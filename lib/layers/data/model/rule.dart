import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'duration_rule.dart';

class Rule extends Equatable {
  int? openTime;
  int? closeTime;
  List<DateTime>? blockedDates;
  List<DurationRule>? durationRules;
  List<String>? blockedCategories;
  List<String>? blockedShowsId;
  bool? isOn;

  Rule({
    this.openTime,
    this.closeTime,
    this.blockedDates,
    this.durationRules,
    this.blockedCategories,
    this.blockedShowsId,
    this.isOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'openTime': this.openTime ?? 0,
      'closeTime': this.closeTime ?? 24,
      'blockedDates': this.blockedDates ?? [],
      'durationRules': this.durationRules != null
          ? this.durationRules!.map((e) => e.toString()).toList()
          : [],
      'blockedCategories': this.blockedCategories ?? [],
      'blockedShows': this.blockedShowsId ?? [],
      'isOn': this.isOn ?? true
    };
  }

  factory Rule.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return Rule(
      openTime: map['openTime'],
      closeTime: map['closeTime'],
      blockedDates: List<DateTime>.from(
          map['blockedDates'].map((e) => e.toDate()).toList()),
      durationRules: List<DurationRule>.from(
          map['durationRules'].map((e) => DurationRule.fromString(e)).toList()),
      blockedCategories: List<String>.from(map['blockedCategories']),
      blockedShowsId: List<String>.from(map['blockedShows']),
      isOn: map['isOn'],
    );
  }

  Rule copyWith({
    int? openTime,
    int? closeTime,
    List<DateTime>? blockedDates,
    List<DurationRule>? durationRules,
    List<String>? blockedCategories,
    List<String>? blockedShows,
    bool? isOn,
  }) {
    return Rule(
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      blockedDates: blockedDates ?? this.blockedDates,
      durationRules: durationRules ?? this.durationRules,
      blockedCategories: blockedCategories ?? this.blockedCategories,
      blockedShowsId: blockedShows ?? this.blockedShowsId,
      isOn: isOn ?? this.isOn,
    );
  }

  @override
  List<Object?> get props => [
        this.openTime,
        this.closeTime,
        this.blockedDates,
        this.durationRules,
        this.blockedCategories,
        this.blockedShowsId
      ];
}
