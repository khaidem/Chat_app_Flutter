import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/google_sigin.provider.dart';
import 'package:goole_sigin_firebase/src/Home/pages/home.page.dart';
import 'package:provider/provider.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget({Key? key}) : super(key: key);
  static const routeName = '/LogInWidget';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                final logout = context.read<GoogleSigInProvider>();
                logout.signOut().then(
                    (value) => Navigator.of(context).pop(HomePage.routeName));
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
