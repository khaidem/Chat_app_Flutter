import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/google_sigin.provider.dart';
import 'package:provider/provider.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget({Key? key}) : super(key: key);
  static const routeName = '/LogInWidget';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(user.displayName!),
            ElevatedButton(
              onPressed: () {
                final logout = context.read<GoogleSigInProvider>();
                logout.signOut();
                Navigator.of(context).pop();
                print(logout);
              },
              child: const Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
