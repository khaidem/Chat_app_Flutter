import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  File? imageFile;
  PlatformFile? pickFile;
  UploadTask? uploadTask;

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
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendController,
              decoration: InputDecoration(
                labelText: 'Send a Message',
                suffixIcon: IconButton(
                  onPressed: () {
                    context
                        .read<FilePickerProvider>()
                        .uploadFile(widget.groupId);
                  },
                  icon: const Icon(Icons.add),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
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
