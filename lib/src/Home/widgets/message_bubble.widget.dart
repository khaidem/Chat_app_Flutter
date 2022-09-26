import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(12),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            children: [
              // FutureBuilder(
              //     future: FirebaseFirestore.instance
              //         .collection('user_accounts')
              //         .doc(userId)
              //         .get(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Text('Loading..');
              //       }
              //       Map<String, dynamic> data =
              //           snapshot.data!.data() as Map<String, dynamic>;

              //       return Text(
              //         data['email'].isEmpty
              //             ? data['phone_number']
              //             : data['email'],
              //         style: const TextStyle(fontWeight: FontWeight.bold),
              //       );
              //     }),
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
    );
  }
}
