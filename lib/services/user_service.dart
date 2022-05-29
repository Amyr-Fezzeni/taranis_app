import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:taranis/models/user.dart';

class UserService {
  static CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('users');

  static Future<String> addUser(User user) async {
    if (await checkExistingUser(user.phoneNumber)) {
      return "Phone number already existe";
    }
    user.id = generateId();
    try {
      await collection
          .doc(user.id)
          .set(user.toJson())
          .whenComplete(() => log("user added"));
    } on Exception {
      return "An error has occured, please try again";
    }
    return "true";
  }

  static Future<bool> checkExistingUser(int phone) async {
    final snapshot =
        await collection.where('phoneNumber', isEqualTo: phone).limit(1).get();
    if (snapshot.docs.isNotEmpty) return true;
    return false;
  }

  static Future<User?> getUser(int phone) async {
    final snapshot =
        await collection.where('phoneNumber', isEqualTo: phone).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());
      return User.fromJson(snapshot.docs.first.data());
    } else {
      return null;
    }
  }

    static Future<bool> changePassword(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"password": user.password});
      return true;
    } on Exception{
      return false;
    }
  }

  static String generateId() {
    ObjectId id1 = ObjectId();
    return id1.toHexString();
  }

 
}
