import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.isMe,
    required this.file_send,
    required this.uidList,
    required this.sendBy,
  }) : super(key: key);
  final String message;
  final bool isMe;
  final String file_send;
  final List<dynamic> uidList;
  final String sendBy;

  @override
  Widget build(BuildContext context) {
    return file_send.isEmpty
        ? Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isMe
                      ? Colors.grey[300]
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  ),
                ),
                width: 140,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user_accounts')
                          .doc(sendBy)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading..');
                        }
                        final chatDoc = snapshot.data;

                        return Text(
                          chatDoc['email'].isEmpty
                              ? chatDoc['phone_number']
                              : chatDoc['email'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: isMe ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container(
            height: 200,
            decoration: BoxDecoration(
              // border: Border.all(width: 5),
              image: DecorationImage(
                alignment: isMe ? Alignment.centerRight : Alignment.bottomLeft,
                image: NetworkImage(file_send),
              ),
            ),
            alignment: isMe ? Alignment.centerRight : Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      );
                    },
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Image.network(
                  //     file_send.isEmpty? const Center(child: CircularProgressIndicator()),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
  }
}
