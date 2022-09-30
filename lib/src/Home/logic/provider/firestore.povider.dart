import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class FireStoreProvider with ChangeNotifier {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('group_chat');
  //**** For Group_Chat Add ***************/
  // ==========================
  Future<void> addGroup(String groupText, List<dynamic> selectedUser) async {
    // final collectionRef =
    //     FirebaseFirestore.instance.collection('user_accounts').get();
    CollectionReference users =
        FirebaseFirestore.instance.collection('group_chat');

    users.add(
      {
        'active': true,
        'create_at': Timestamp.now(),
        'group_name': groupText,
        'uid_list': selectedUser
      },
    ).then(
      (DocumentReference docRef) => docRef.update({'group_id': docRef.id}),
    );
  }

  //** New User added to group */
  // ===============================
  Future<void> newUserAdd(String groupName, BuildContext context,
      List<dynamic> selectedUser) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('group_chat');

    users.doc(groupName).update(
      {'uid_list': FieldValue.arrayUnion(selectedUser)},
    );

    Navigator.of(context).pop();
  }

  //** For Print all Current User */
  // ==================================
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('group_chat');

  getData(String groupId) async {
    var data = FirebaseFirestore.instance.collection('group_chat');
    var docSna = await data.doc(groupId).get();

    if (docSna.exists) {
      List<dynamic> dataNew = docSna.get('uid_list');
      dataNew.map((e) {
        return e;
      }).toList();
      log('$dataNew');
    }
  }

  //** For Showing COLLECTION DATA OF DOCUMENT**//
// ========================================
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('group_chat');
  Future getUserAccount() async {
    QuerySnapshot querySnapshot = await _collection.get();
    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    log('user Account Data$allData');
  }

  //** For sending message to Group  */

  sendMessage(
    BuildContext context,
    String groupId,
    String enterMessage,
  ) {
    FocusScope.of(context).unfocus();
    final auth = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('group_chat/$groupId/messages').add({
      'message': enterMessage,
      'sent_at': Timestamp.now(),
      'file_send': '',
      //** This user id is form currenly LogIn User */
      'sent_by': auth!.uid,
    });
  }
}
