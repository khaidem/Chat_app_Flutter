import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../example.dart';

class SendingMessageBodyWidget extends StatelessWidget {
  const SendingMessageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('group_chat/RtTIgsLJIWfK88DOHRzG/messages');
    return StreamBuilder(
      stream: collectionRef.snapshots(),
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
          ),
        );
      },
    );
  }
}
