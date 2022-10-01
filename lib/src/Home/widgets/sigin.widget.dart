import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

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

//*** After GoogleSigIn and Route  */
// ===============================
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
      body: Container(
        color: const Color.fromARGB(255, 32, 48, 61),
        child: Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(100),
                      child: Image.asset('assets/images/chatImage.png'),
                    ),
                  ),
                  const Text(
                    'Let\'s Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0),
                  )
                ],
              ),
            ),
            Flexible(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Welcome! How would you like to Connect?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                FlutterSocialButton(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PhoneNumberVerificationWidget.routeName);
                  },
                  buttonType: ButtonType.phone,
                ),
                FlutterSocialButton(
                  onTap: () {
                    googleSigIn();
                  },
                  buttonType: ButtonType.google,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
