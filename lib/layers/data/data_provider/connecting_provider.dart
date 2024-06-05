import 'package:careflix_parental_control/core/firebase/firestore_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectingProvider {
  Future<bool> checkIfUserExist(String docId) async {
    var collectionRef =
        FirebaseFirestore.instance.collection(FireStoreKeys.users_collections);
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  }

  Future<bool> checkIfUserHasParentalControl(String docId) async {
    var collectionRef = FirebaseFirestore.instance
        .collection(FireStoreKeys.parental_control_collections);
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  }
}
