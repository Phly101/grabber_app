import "package:cloud_firestore/cloud_firestore.dart";

class GiftModel {
  final String id;
  final String senderUID;
  final String senderEmail;
  final String senderName;
  final String message;
  final List<dynamic> items;
  final DateTime? timestamp;

  GiftModel({
    required this.id,
    required this.senderUID,
    required this.senderEmail,
    required this.senderName,
    required this.message,
    required this.items,
    required this.timestamp,
  });

  factory GiftModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GiftModel(
      id: doc.id,
      senderUID: data["senderUID"] ?? "",
      senderEmail: data["senderEmail"] ?? "",
      senderName: data["senderName"] ?? "",
      message: data["message"] ?? "",
      items: data["items"] ?? [],
      timestamp: (data["timestamp"] as Timestamp?)?.toDate(),
    );
  }
}
