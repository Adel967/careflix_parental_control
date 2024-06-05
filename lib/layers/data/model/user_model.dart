import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/enum.dart';

class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? birthDate;
  Gender? gender;
  String? createdAt;
  String? pushToken;
  List<String> userListIds;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.gender,
      required this.createdAt,
      this.userListIds = const [],
      required this.pushToken});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'birthDate': this.birthDate,
      'gender': genderToString(this.gender!),
      'createdAt': this.createdAt,
      'pushToken': this.pushToken,
      'userListsIds': this.userListIds
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
        id: map['id'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        birthDate: map['birthDate'],
        gender: stringToGender(map['gender']),
        createdAt: map['createdAt'],
        pushToken: map['pushToken'],
        userListIds: List<String>.from(map['userListsIds']));
  }
}
