import "package:cloud_firestore/cloud_firestore.dart";

import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";

class UserServices {
  final String uid;
  final CollectionReference users = FirebaseFirestore.instance.collection("users");
  // final uid = FirebaseAuth.instance.currentUser!.uid;

  // String get uid => FirebaseAuth.instance.currentUser!.uid;
  UserServices(this.uid);
  //CollectionReference get _cart1 => users.doc(uid).collection("cart");

  Stream<QuerySnapshot> getCart1() {
    return _cart.snapshots();
  }


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

  CollectionReference get _cart{
    return users.doc(uid).collection("cart");
  }

  Future<void> addCart(CartItemModel item) async{
    try{
      await _cart.doc(item.name).set({
        "imagePath" : item.imagePath,
        "name" : item.name,
        "price" : item.price,
        "quantity" : item.quantity,
      });
    }catch(e){
      throw Exception("Failed to add item to cart: $e");
    }
  }

  Future<void> updateCart(CartItemModel item) async{
    try{
      await _cart.doc(item.name).update({
        "quantity" : item.quantity,
      });
    }catch(e){
      throw Exception("Failed to update cart item: $e");
    }
  }

  Future<void> removeCart(String name) async{
    try{
      await _cart.doc(name).delete();

    }catch(e) {
      throw Exception("Failed to remove cart item: $e");
    }
  }

  Stream<List<CartItemModel>> getCart(){
    return _cart.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CartItemModel(
          imagePath: data["imagePath"] ?? "",
          name: data["name"] ?? "",
          price: data["price"] ?? 0,
          quantity: data["quantity"] ?? 0,
        );
      }).toList();
    });
  }
}
