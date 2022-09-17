import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../example.dart';

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
    final user = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.toString()),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('LogOut'),
            )
          ],
        ),
      ),
    );
  }
}
