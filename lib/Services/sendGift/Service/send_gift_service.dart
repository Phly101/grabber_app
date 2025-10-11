import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:grabber_app/Services/sendGift/Service/result.dart";

class SendGiftService {
  final FirebaseFirestore fireStore;
  final FirebaseAuth authProvider;

  SendGiftService({required this.fireStore, required this.authProvider});

  // main send gift function
  Future<Result<void>> sendGift(String receiverEmail) async {
    try {
      final senderUID = authProvider.currentUser?.uid;
      if (senderUID == null) {
        return Result.failure("sender_not_logged_in");
      }

      final receiverSnapshot = await findUserByEmail(receiverEmail);

      if (receiverSnapshot.docs.isEmpty) {
        return Result.failure("user_not_found");
      }

      final receiverDoc = receiverSnapshot.docs.first;
      final receiverUID = receiverDoc.id;

      if (senderUID == receiverUID) {
        return Result.failure("cannot_send_to_self");
      }

      await _createGift(senderUID, receiverUID);
      await _createNotification(receiverUID, senderUID);

      return Result.success(null);
    } catch (e) {
      return Result.failure("unexpected_error");
    }
  }

  // find the user by email function
  Future<QuerySnapshot> findUserByEmail(String email) async {
    return await fireStore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  // create notification collection for users
  Future<void> _createNotification(String senderUID, String receiverUID) async {
    final senderDoc = await fireStore.collection("users").doc(senderUID).get();
    final senderEmail = senderDoc.get("email");
    final senderName = senderDoc.data()?["name"] ?? senderEmail;

    await fireStore
        .collection("users")
        .doc(receiverUID)
        .collection("notifications")
        .add({
          "senderUID": senderUID,
          "senderEmail": senderEmail,
          "senderName": senderName,
          "message": "$senderName has sent you a gift!",
          "timestamp": FieldValue.serverTimestamp(),
          "read": false,
          "type": "gift",
        });
  }

  // create gift collection for users
  Future<void> _createGift(String senderUID, String receiverUID) async {
    final senderDoc = await fireStore.collection("users").doc(senderUID).get();
    final senderEmail = senderDoc.get("email");
    final senderName = senderDoc.data()?["name"] ?? senderEmail;

    final cartSnapshot = await fireStore
        .collection("users")
        .doc(senderUID)
        .collection("cart")
        .get();
    final cartItems = cartSnapshot.docs.map((doc) => doc.data()).toList();
    await fireStore
        .collection("users")
        .doc(receiverUID)
        .collection("gifts")
        .add({
          "senderUID": senderUID,
          "senderEmail": senderEmail,
          "senderName": senderName,
          "message": "Enjoy your gift!",
          "items": cartItems,
          "timestamp": FieldValue.serverTimestamp(),
        });
  }
}
