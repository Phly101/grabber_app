import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class UserServices {
  final CollectionReference users = FirebaseFirestore.instance.collection("users");
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, dynamic>> getCurrentUserData() async {
    try {
      final DocumentSnapshot doc = await users.doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return doc.data() as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      throw Exception("Failed to fetch user data: $e");
    }
  }

  Future<void> updateUserName(String newName) async{
    try {
      await users.doc(uid).update({"name": newName});
    }catch (e){
      throw Exception("Failed to update user name: $e");
    }
  }

  Future<void> updatePhoneNum(String newNum) async{
    try {
      await users.doc(uid).update({"phoneNumber": newNum});
    }catch (e){
      throw Exception("Failed to update phone number: $e");
    }
  }
}
