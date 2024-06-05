import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_instance.dart';
import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_key.dart';
import 'package:careflix_parental_control/layers/data/model/rule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/firestore_keys.dart';

class RuleProvider {
  Future<DocumentSnapshot<Map<String, dynamic>>> getRule() async {
    var collectionRef = FirebaseFirestore.instance
        .collection(FireStoreKeys.parental_control_collections);
    return await collectionRef
        .doc(SharedPreferencesInstance.pref
            .getString(SharedPreferencesKeys.UserId))
        .get();
  }

  Future<void> setRule(Rule rule) async {
    var collectionRef = FirebaseFirestore.instance
        .collection(FireStoreKeys.parental_control_collections);
    return await collectionRef
        .doc(SharedPreferencesInstance.pref
            .getString(SharedPreferencesKeys.UserId))
        .set(rule.toMap());
  }
}
