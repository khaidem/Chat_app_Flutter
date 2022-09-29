import 'package:cloud_firestore/cloud_firestore.dart';

class Curd {
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('user_account')
        .where('uid', isEqualTo: '')
        .get();
  }
}
