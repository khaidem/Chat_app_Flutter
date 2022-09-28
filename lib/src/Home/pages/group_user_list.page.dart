import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupUserList extends StatelessWidget {
  const GroupUserList(
      {Key? key,
      required this.groupId,
      required this.uid,
      required this.uidList})
      : super(key: key);
  final String groupId;
  final String uid;
  final List<dynamic> uidList;

  static const routeName = '/GroupUserList';

  getdata() async {
    await FirebaseFirestore.instance
        .collection('group_chat')
        .doc(groupId)
        .get()
        .then((value) {
      var newData = value.data()!["uid_list"];
      return newData;
      // log(uidList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uid),
        actions: [
          ElevatedButton(
            onPressed: () {
              getdata();
            },
            child: const Text('data'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('user_accounts')
            .doc(uid)
            .get(),
        builder: (_, AsyncSnapshot snapShot) {
          if (snapShot.hasError) {
            return Text('Error = ${snapShot.error}');
          }
          if (snapShot.hasData) {
            var outPut = snapShot.data;

            return Center(
                child: Column(
              children: [
                Text(
                  outPut['email'],
                ),
              ],
            ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
