import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupUserList extends StatelessWidget {
  const GroupUserList({
    Key? key,
    required this.groupId,
    required this.uidList,
  }) : super(key: key);
  final String groupId;

  final List<dynamic> uidList;

  static const routeName = '/GroupUserList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Group user'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_accounts')
            //**compare that ID to the contents of a List using a .where()  */
            .where('uid', whereIn: uidList)
            .snapshots(),
        builder: (_, AsyncSnapshot snapShot) {
          if (snapShot.hasError) {
            return Text('Error = ${snapShot.error}');
          }
          if (snapShot.hasData) {
            var outPut = snapShot.data.docs;
            log('Show group user data $outPut');

            return ListView.separated(
              separatorBuilder: ((context, index) {
                return const Divider(
                  thickness: 3,
                );
              }),
              itemCount: outPut.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                    outPut[index]['email'].isEmpty
                        ? outPut[index]['phone_number']
                        : outPut[index]['email'],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
