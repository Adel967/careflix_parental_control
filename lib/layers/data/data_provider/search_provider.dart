import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/firebase/firestore_keys.dart';

class SearchProvider {
  Future<QuerySnapshot<Map<String, dynamic>>> searchShow() async {
    return await FirebaseFirestore.instance
        .collection(FireStoreKeys.shows_collections)
        .get();
  }
}
