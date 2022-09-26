import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../example.dart';

class GroupUserList extends StatelessWidget {
  const GroupUserList({Key? key, required this.groupId, required this.uidList})
      : super(key: key);
  final String groupId;
  final List<String> uidList;

  static const routeName = '/GroupUserList';

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
              context.read<AuthProvider>().getData(groupId);
            },
            child: const Text('data'),
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: collectionRef
            .where(
              groupId,
            )
            .get(),
        builder: (_, snapShot) {
          if (snapShot.hasError) {
            return Text('Error = ${snapShot.error}');
          }
          if (snapShot.hasData) {
            var outPut = snapShot.data!.docs;
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
