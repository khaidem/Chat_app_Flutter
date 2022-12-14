import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/core/const.dart';

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
        backgroundColor: mainColors,
        title: const Text(' Group user'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_accounts')
            //**compare that ID to the contents of a List using a .where()  */
            .where('uid', whereIn: uidList)
            .snapshots(),
        builder: (_, AsyncSnapshot snapShot) {
          if (!snapShot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapShot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data Found'),
            );
          } else {
            var outPut = snapShot.data.docs;
            log('Show group user data $outPut');

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
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
              ),
            );
          }
        },
      ),
    );
  }
}
