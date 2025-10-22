import "package:cloud_firestore/cloud_firestore.dart";

class NotificationModel {
  final String id;
  final String senderUID;
  final String senderEmail;
  final String senderName;
  final String message;
  final bool read;
  final String type;
  final DateTime? timestamp;

  NotificationModel({
    required this.id,
    required this.senderUID,
    required this.senderEmail,
    required this.senderName,
    required this.message,
    required this.read,
    required this.type,
    required this.timestamp,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {} ;
    return NotificationModel(
      id: doc.id,
      senderUID: data["senderUID"] ?? "",
      senderEmail: data["senderEmail"] ?? "",
      senderName: data["senderName"] ?? "",
      message: data["message"] ?? "",
      read: data["read"] ?? false,
      type: data["type"] ?? "",
      timestamp: (data["timestamp"] as Timestamp?)?.toDate(),
    );
  }
}
