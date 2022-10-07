import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:goole_sigin_firebase/src/Home/example.dart';
import 'package:provider/provider.dart';

class MessageTextWidget extends StatefulWidget {
  const MessageTextWidget({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<MessageTextWidget> createState() => _MessageTextWidgetState();
}

class _MessageTextWidgetState extends State<MessageTextWidget> {
  final TextEditingController _sendController = TextEditingController();
  var _enterMessage = '';

//*** Sending text Msg */
// ======================
  void _sendMessage() {
    context.read<FireStoreProvider>().sendMessage(
          context,
          widget.groupId,
          _enterMessage,
        );
    _sendController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     FontAwesomeIcons.smileWink,
                      //     color: Color(0xFF00BFA5),
                      //   ),
                      // ),
                      Flexible(
                        child: TextField(
                          controller: _sendController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Color(0xFF00BFA5)),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _enterMessage = value;
                            });
                          },
                        ),
                      ),
                      attachFile(widget: widget)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
                  icon: const Icon(
                    FontAwesomeIcons.solidPaperPlane,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class attachFile extends StatelessWidget {
  const attachFile({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MessageTextWidget widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<FilePickerProvider>().uploadFile(widget.groupId);
      },
      icon: const Icon(
        FontAwesomeIcons.paperclip,
        color: Color(0xFF00BFA5),
      ),
    );
  }
}
