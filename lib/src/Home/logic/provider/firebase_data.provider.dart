import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseDataProvider with ChangeNotifier {
  Future<void> addUserAccount() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('user_accounts');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final email = auth.currentUser!.email;
    final name = auth.currentUser!.displayName;
    final phoneNumber = auth.currentUser!.phoneNumber.toString();
    final timeStnd = auth.currentUser!.metadata.toString();
    final active = auth.currentUser!.isAnonymous;
    return users
        .add({
          'active': active,
          'created_at': timeStnd,
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
