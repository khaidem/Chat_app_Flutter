import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/message_text.widget.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/sending_message_body.widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);
  static const routeName = '/MessagePage';

  @override
  State<MessagePage> createState() => _SendingMessagesWidgetState();
}

class _SendingMessagesWidgetState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        child: Column(
          children: const [
            Expanded(
              child: SendingMessageBodyWidget(),
            ),
            MessageTextWidget()
          ],
        ),
      ),
    );
  }
}
