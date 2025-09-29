import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreService {
  Stream<List<Map<String, dynamic>>> getItems(String collectionName) {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection(collectionName);

    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }
}