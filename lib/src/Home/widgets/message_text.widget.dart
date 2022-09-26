import 'dart:developer';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MessageTextWidget extends StatefulWidget {
  const MessageTextWidget({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<MessageTextWidget> createState() => _MessageTextWidgetState();
}

class _MessageTextWidgetState extends State<MessageTextWidget> {
  final TextEditingController _sendController = TextEditingController();
  var _enterMessage = '';

  PlatformFile? pickFile;

//** For sending message to Group  */

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final auth = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('group_chat/${widget.groupId}/messages')
        .add({
      'message': _enterMessage,
      'sent_at': Timestamp.now(),
      'file_send': '',
      //** This user id is form currenly LogIn User */
      'sent_by': auth!.uid,
    });
    _sendController.clear();
  }

  //** File Picker form PhoneStorage save to FireStorage*/
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;
    final file = File(pickFile!.path as String);
    final firebaseStorageRef = FirebaseStorage.instance.ref().child('files');

    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    log('uploadTask $uploadTask');
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    final fileURL = await taskSnapshot.ref.getDownloadURL();
    log('Form FireStorage $fileURL');
    final auth = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('group_chat/${widget.groupId}/messages')
        .add(
      {
        'file_send': fileURL,
        'sent_by': auth,
        'message': '',
        'sent_at': Timestamp.now(),
      },
    );
    log('Path: ${pickFile!.path}');
    log('user: $auth');
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
                    selectFile();
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
