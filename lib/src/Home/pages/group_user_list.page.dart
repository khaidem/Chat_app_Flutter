import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupUserList extends StatelessWidget {
  const GroupUserList({Key? key, required this.groupId, required this.uidList})
      : super(key: key);
  final String groupId;
  final List<dynamic> uidList;

  static const routeName = '/GroupUserList';
  //** For extracting data form group_chat of uid_list */
  getdata() async {
    await FirebaseFirestore.instance
        .collection('group_chat')
        .doc(groupId)
        .get()
        .then((value) {
      var uidList = value.data()!["uid_list"];
      print(uidList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final collectionRef =
        FirebaseFirestore.instance.collection('user_accounts');
    return Scaffold(
      appBar: AppBar(
        title: Text(groupId),
        actions: [
          ElevatedButton(
            onPressed: () {
              getdata();
            },
            child: const Text('data'),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (_, AsyncSnapshot snapShot) {
          if (snapShot.hasError) {
            return Text('Error = ${snapShot.error}');
          }
          if (snapShot.hasData) {
            var outPut = snapShot.data.docs;
            log(outPut.toString());
            // var outPut = snapShot.data!.data();
            // var value = outPut!['uid_list'];
            return ListView.builder(
                itemCount: outPut.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(
                      outPut[index]['email'].isEmpty
                          ? outPut[index]['phone_number']
                          : outPut[index]['email'],
                    ),
                    trailing: Text(
                      outPut.length.toString(),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
