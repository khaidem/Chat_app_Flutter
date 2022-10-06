import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendingImageWidget extends StatelessWidget {
  const SendingImageWidget(
      {Key? key,
      required this.isMe,
      required this.sendFile,
      required this.sendBy})
      : super(key: key);
  final bool isMe;
  final String sendFile;
  final String sendBy;
  final isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Bubble(
          margin: const BubbleEdges.only(top: 10),
          nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
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
                const SizedBox(
                  height: 10,
                ),
                ClipRect(
                  child: Image.network(sendFile),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
