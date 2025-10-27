import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreService {
  Stream<List<Map<String, dynamic>>> getItems(String collectionName) {
    final CollectionReference ref = FirebaseFirestore.instance.collection(
      collectionName,
    );

    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }
  Future<List<Map<String, dynamic>>> getFilteredItems(
      double minPrice,
      double maxPrice,
      List<String> categories,
      ) async {
    print("🔥 START FILTER: min=$minPrice, max=$maxPrice, categories=$categories");

    Query<Map<String, dynamic>> q =
    FirebaseFirestore.instance.collection('products');

    q = q
        .where('price', isGreaterThanOrEqualTo: minPrice)
        .where('price', isLessThanOrEqualTo: maxPrice);

    if (categories.isNotEmpty) {
      q = q.where('category', whereIn: categories);
    }

    final snapshot = await q.get();

    print("📦 Found ${snapshot.docs.length} docs");

    for (var doc in snapshot.docs) {
      print("🧾 ${doc.data()}");
    }

    return snapshot.docs.map((doc) {
      return {
        "id": doc.id,
        ...doc.data(),
      };
    }).toList();
  }
}