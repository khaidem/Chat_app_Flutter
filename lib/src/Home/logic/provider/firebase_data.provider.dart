import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseDataProvider with ChangeNotifier {
  List? contacts;
  CollectionReference users =
      FirebaseFirestore.instance.collection('user_accounts');

  Future<void> addUserAccount(bool isActive, String email, String name,
      String phoneNumber, String uid) {
    return users
        .add({
          'active': isActive,
          'created_at': Timestamp,
          'email': email,
          'name': name,
          'phone': phoneNumber,
          'uid': uid,
        })
        .then(
          (value) => debugPrint("User Added"),
        )
        .catchError((error) => debugPrint('Failed to add User: $error'));
  }
}
