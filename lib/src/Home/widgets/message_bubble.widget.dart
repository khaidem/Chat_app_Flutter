import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.isMe,
    required this.uidList,
    required this.sendBy,
  }) : super(key: key);
  final String message;
  final bool isMe;

  final List<dynamic> uidList;
  final String sendBy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Bubble(
          margin: const BubbleEdges.only(top: 10),
          nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user_accounts')
                    .doc(sendBy)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading..');
                  }
                  final chatDoc = snapshot.data;

                  return Text(
                    chatDoc['email'].isEmpty
                        ? chatDoc['phone_number']
                        : chatDoc['email'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.pink.shade300 : Colors.green,
                    ),
                  );
                },
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
