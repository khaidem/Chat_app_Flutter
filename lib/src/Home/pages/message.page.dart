import 'package:flutter/material.dart';

import '../example.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);
  static const routeName = '/MessagePage';
  final String groupId;
  final String groupName;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: SendingMessageBodyWidget(
                groupId: widget.groupId,
              ),
            ),
            MessageTextWidget(
              groupId: widget.groupId,
            )
          ],
        ),
      ),
    );
  }
}
