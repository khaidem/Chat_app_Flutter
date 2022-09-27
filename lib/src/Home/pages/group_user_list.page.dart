import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupUserList extends StatefulWidget {
  const GroupUserList({
    Key? key,
    required this.groupId,
  }) : super(key: key);
  final String groupId;

  static const routeName = '/GroupUserList';

  @override
  State<GroupUserList> createState() => _GroupUserListState();
}

class _GroupUserListState extends State<GroupUserList> {
  var dersler = [];
  //** For extracting data form group_chat of uid_list */
  getdata() async {
    await FirebaseFirestore.instance
        .collection('group_chat')
        .doc(widget.groupId)
        .get()
        .then((value) {
      var uidList = value.data()!["uid_list"];

      log('$dersler');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupId),
        actions: [
          ElevatedButton(
            onPressed: () {
              // getdata();
            },
            child: const Text('data'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('user_accounts')
            .where('group_chat', isEqualTo: widget.groupId)
            .get(),
        builder: (_, AsyncSnapshot snapShot) {
          if (snapShot.hasError) {
            return Text('Error = ${snapShot.error}');
          }
          if (snapShot.hasData) {
            var outPut = snapShot.data.docs;

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
