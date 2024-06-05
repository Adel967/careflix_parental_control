import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/enum.dart';

List<Show> getShowList(String str) =>
    List<Show>.from(json.decode(str).map((x) => Show.fromMap(x)));

List<Show> getShowListFromListMap(List<QueryDocumentSnapshot> list) =>
    List<Show>.from(list.map((x) => Show.fromMap(x)));

class Show {
  final String id;
  final String title;
  final String description;
  final String? season;
  final String imageUrl;
  final String? duration;
  final double rating;
  final List<String> category;
  final int? episodeNum;
  final ShowType type;
  final String releaseDate;
  final ShowLan? showLan;

  Show({
    required this.id,
    required this.title,
    required this.description,
    this.season,
    required this.imageUrl,
    this.duration,
    required this.rating,
    required this.category,
    this.episodeNum,
    required this.type,
    required this.releaseDate,
    this.showLan,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'season': this.season,
      'imageUrl': this.imageUrl,
      'duration': this.duration,
      'rating': this.rating,
      'category': this.category,
      'episodeNum': this.episodeNum,
      'type': this.type,
    };
  }

  factory Show.fromMap(QueryDocumentSnapshot map) {
    return Show(
      id: map.id,
      title: map['title'],
      description: map['description'],
      season: map['season_number'].toString().replaceAll('.0', ""),
      imageUrl: map['imageUrl'],
      duration: map['duration'].toString().replaceAll('.0', ""),
      rating: map['rating'],
      category: map['category'].toString().split(","),
      episodeNum:
          map['episode_count'] != "" ? map['episode_count'].floor() : null,
      type: stringToShowType(map['type']),
      releaseDate: map['release_year'].toString(),
      showLan: stringToShowLan(map['lan']),
    );
  }

  @override
  String toString() {
    return 'Show{title: $title, description: $description, season: $season, imageUrl: $imageUrl, duration: $duration, rating: $rating, category: $category, episodeNum: $episodeNum, type: $type, releaseDate: $releaseDate, showLan: $showLan}';
  }
}
