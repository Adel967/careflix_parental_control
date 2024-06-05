import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_instance.dart';
import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_key.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/enum.dart';
import '../../../core/firebase/firestore_keys.dart';
import '../model/user_model.dart';

class ProfileProvider {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() async {
    return await FirebaseFirestore.instance
        .collection(FireStoreKeys.users_collections)
        .doc(SharedPreferencesInstance.pref
            .getString(SharedPreferencesKeys.UserId))
        .get();
  }
}
