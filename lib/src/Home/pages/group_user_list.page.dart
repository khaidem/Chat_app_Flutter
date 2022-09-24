import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../example.dart';

class GroupUserList extends StatelessWidget {
  const GroupUserList({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  static const routeName = '/GroupUserList';

  @override
  Widget build(BuildContext context) {
    final collectionRef = FirebaseFirestore.instance.collection('group_chat');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group User List'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthProvider>().getData(groupId);
            },
            child: const Text('data'),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: collectionRef.doc(groupId).snapshots(),
        builder: (_, snapShot) {
          if (snapShot.hasError) {
            return Text('Error = ${snapShot.error}');
          }
          if (snapShot.hasData) {
            var outPut = snapShot.data!.data();
            var value = outPut!['uid_list'];
            return ListTile(
              title: Text(
                value.toString(),
              ),
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
