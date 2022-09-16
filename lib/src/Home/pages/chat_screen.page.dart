import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenPage extends StatelessWidget {
  const ChatScreenPage({Key? key}) : super(key: key);
  void retrieveData() {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('group_chat/RtTIgsLJIWfK88DOHRzG/messages')
        //       .snapshots(),
        //   builder: (ctx, streamSnapShot) {
        //     final docs = streamSnapShot.data.toString();
        //     return ListView.builder(

        //       itemCount: streamSnapShot.data,
        //       itemBuilder: (ctx, index) => Container(
        //         padding: const EdgeInsets.all(8),
        //         child: const Text('data'),
        //       ),
        //     );
        //   },
        // ),

        // ElevatedButton(
        //   onPressed: () {
        //     FirebaseFirestore.instance
        //         .collection('user_accounts')
        //         .snapshots()
        //         .listen((event) {
        //       log(
        //         event.docs[0].data().toString(),
        //       );
        //     });
        //   },
        //   child: const Text('data'),
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     FirebaseFirestore.instance
        //         .collection('group_chat/RtTIgsLJIWfK88DOHRzG/messages')
        //         .snapshots()
        //         .listen((event) {
        //       log(event.docs[1].data().toString());
        //     });
        //   },
        //   child: const Text('group'),
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     FirebaseFirestore.instance
        //         .collection('group_chat/RtTIgsLJIWfK88DOHRzG/messages')
        //         .snapshots()
        //         .listen((event) {
        //       for (var element in event.docs) {
        //         log(element['message']);
        //       }
        //     });
        //   },
        //   child: const Text('for each'),
        // ),
        );
  }
}
