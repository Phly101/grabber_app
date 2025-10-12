import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
import "package:grabber_app/Services/sendGift/Models/notification_model.dart";
import "package:grabber_app/Services/sendGift/Service/result.dart";

class GiftListenerService {
  final FirebaseFirestore fireStore;
  final FirebaseAuth authProvider;

  GiftListenerService({required this.fireStore, required this.authProvider});

  Stream<List<NotificationModel>> listenToNotifications(String userId) {
    return fireStore
        .collection("users")
        .doc(userId)
        .collection("notifications")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NotificationModel.fromFirestore(doc))
              .toList(),
        )
        .handleError((error) {
         Result.failure("Notification Stream error: $error");
        });
  }

  Stream<List<GiftModel>> listenToIncomingGifts(String userId) {
    return fireStore
        .collection("users")
        .doc(userId)
        .collection("gifts")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => GiftModel.fromFirestore(doc)).toList(),
        ).handleError((error) {
      Result.failure("Gift Stream error: $error");
    });
  }
  Future<Result<List<NotificationModel>>> getNotifications(String userId) async {
    try {
      final snapshot = await fireStore
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .orderBy("timestamp", descending: true)
          .get();

      final notifications = snapshot.docs
          .map((doc) => NotificationModel.fromFirestore(doc))
          .toList();

      return Result.success(notifications);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<GiftModel>> getGift(String userId, String giftId) async {
    final doc = await fireStore
        .collection("users")
        .doc(userId)
        .collection("gifts")
        .doc(giftId)
        .get();

    if (!doc.exists) {
      return Result.failure("Gift not found");
    }

    return Result.success(GiftModel.fromFirestore(doc));
  }

}
