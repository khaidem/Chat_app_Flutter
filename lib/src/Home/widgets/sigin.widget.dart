import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../example.dart';

class SigInWidget extends StatefulWidget {
  const SigInWidget({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<SigInWidget> createState() => _SigInWidgetState();
}

class _SigInWidgetState extends State<SigInWidget> {
  String verificationIdReceived = '';
  bool isSignedIn = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

//*** For GoogleSigIn Function */

  void googleSigIn() async {
    final provider = context.read<AuthProvider>();

    await provider.googleSigIn().then(
          (value) => Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (route) => false),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Welcome Back'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(PhoneNumberVerificationWidget.routeName);
              },
              icon: const Icon(FontAwesomeIcons.phone),
              label: const Text('Continue with Phone Number'),
            ),
            Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 75.0, right: 20.0),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
              ),
              const Text("OR"),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 75.0),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
              ),
            ]),
            OutlinedButton.icon(
              onPressed: () {
                googleSigIn();
              },
              icon: const Icon(FontAwesomeIcons.google),
              label: const Text('Continue with Google SigIn'),
            )
          ],
        ),
      ),
    );
  }
}
