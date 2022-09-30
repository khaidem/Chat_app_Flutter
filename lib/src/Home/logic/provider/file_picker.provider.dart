import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerProvider with ChangeNotifier {
  //** Picker any File Form Device */
  //
  PlatformFile? pickFile;
  File? imageFile;
  //** To Store Data in FireStorage */
  //
  UploadTask? uploadTask;

  //** File Pick form PhoneStorage save to FireStorage also Upload*/
  // ======================================================
  Future uploadFile(String groupId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png'],
    );
    if (result == null) return;

    pickFile = result.files.single;
    final file = File(pickFile!.path as String);
    // var pick = file.readAsBytes();
    final path = 'files/${pickFile!.name}';

    final firebaseStorageRef = FirebaseStorage.instance.ref().child(path);

    uploadTask = firebaseStorageRef.putFile(
      file,
      SettableMetadata(contentType: 'pdf'),
    );

    TaskSnapshot taskSnapshot = await uploadTask!.whenComplete(() => null);

    final fileURL = await taskSnapshot.ref.getDownloadURL();

    uploadTask = null;

    log('Form FireStorage $fileURL');

    //** Upload Url to cloud firebase */
    // ====================================
    final auth = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('group_chat/$groupId/messages')
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
}
