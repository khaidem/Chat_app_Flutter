import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageTextWidget extends StatefulWidget {
  const MessageTextWidget({Key? key}) : super(key: key);

  @override
  State<MessageTextWidget> createState() => _MessageTextWidgetState();
}

class _MessageTextWidgetState extends State<MessageTextWidget> {
  final TextEditingController _sendController = TextEditingController();
  var _enterMessage = '';
  // final dateData = DateTime.now();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('group_chat/RtTIgsLJIWfK88DOHRzG/messages')
        .add({
      'message': _enterMessage,
      'send_at': Timestamp.now(),
      //** This user id is form user_account/ uid_list */
      'send_by': auth!.uid,
    });
    _sendController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendController,
              decoration: const InputDecoration(labelText: 'Send a Message'),
              onChanged: (value) {
                setState(() {
                  _enterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
