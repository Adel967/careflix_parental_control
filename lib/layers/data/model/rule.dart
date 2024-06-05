import 'package:cloud_firestore/cloud_firestore.dart';

import 'duration_rule.dart';

class Rule {
  int? openTime;
  int? closeTime;
  List<DateTime>? blockedDates;
  List<DurationRule>? durationRules;
  List<String>? blockedCategories;
  List<String>? blockedShowsId;

  Rule(
      {this.openTime,
      this.closeTime,
      this.blockedDates,
      this.durationRules,
      this.blockedCategories,
      this.blockedShowsId});

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
    );
  }

  Rule copyWith({
    int? openTime,
    int? closeTime,
    List<DateTime>? blockedDates,
    List<DurationRule>? durationRules,
    List<String>? blockedCategories,
    List<String>? blockedShows,
  }) {
    return Rule(
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      blockedDates: blockedDates ?? this.blockedDates,
      durationRules: durationRules ?? this.durationRules,
      blockedCategories: blockedCategories ?? this.blockedCategories,
      blockedShowsId: blockedShows ?? this.blockedShowsId,
    );
  }
}
