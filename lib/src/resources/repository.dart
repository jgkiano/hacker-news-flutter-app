import 'package:cloud_firestore/cloud_firestore.dart';

class CustomException implements Exception {
  String errorMessage() {
    return 'Network error';
  }
}

class Repository {
  Future<List<DocumentSnapshot>> fetchItems(String collection,
      {int limit = 15, DocumentSnapshot startAfter}) async {
    try {
      print("repo called");
      QuerySnapshot snapshot;
      if (startAfter == null) {
        snapshot = await Firestore.instance
            .collection(collection)
            .limit(limit)
            .orderBy('index')
            .getDocuments();
      } else {
        snapshot = await Firestore.instance
            .collection(collection)
            .limit(limit)
            .orderBy('index')
            .startAfterDocument(startAfter)
            .getDocuments();
      }
      return snapshot.documents;
    } catch (e) {
      throw e;
    }
  }
}
