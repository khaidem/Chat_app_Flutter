import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/auth.provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user == null ? '' : user.displayName!),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
