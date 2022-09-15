import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataFoundPage extends StatefulWidget {
  const DataFoundPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/DataFoundPage';

  @override
  State<DataFoundPage> createState() => _DataFoundPageState();
}

class _DataFoundPageState extends State<DataFoundPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.phoneNumber;

    return Scaffold(
      body: Center(
        child: Text(user!),
      ),
    );
  }
}
