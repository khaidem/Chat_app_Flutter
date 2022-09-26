import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../example.dart';

class SendingMessageBodyWidget extends StatelessWidget {
  const SendingMessageBodyWidget({Key? key, required this.groupId})
      : super(key: key);
  final String groupId;

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('group_chat/$groupId/messages');
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser!.uid),
      builder: (ctx, AsyncSnapshot futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
          //** We use sent_at to order the text in dateTimeNow as that text in
          //* Screen order in descending */
          stream:
              collectionRef.orderBy('sent_at', descending: true).snapshots(),
          builder: (ctx, AsyncSnapshot chatSnapShot) {
            if (chatSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocs = chatSnapShot.data.docs;

            return ListView.builder(
              itemCount: chatDocs.length,
              reverse: true,
              itemBuilder: (ctx, index) => MessageBubbleWidget(
                message: chatDocs[index]['message'],

                ///*we can compare the id of current user with the id message  */
                //** We dont need uid to compare String and bool in these */
                isMe: chatDocs[index]['sent_by'] == futureSnapshot.data,
                // keys: ValueKey(
                //   chatDocs[index].docs,
                // ),
                // userId: chatDocs[index]['uid_list'],
              ),
            );
          },
        );
      },
    );
  }
}
