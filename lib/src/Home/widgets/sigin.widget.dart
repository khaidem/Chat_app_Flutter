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
      body: Column(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(50),
                    child: Image.asset(
                        'assets/images/Blue and Yellow Online Message Bubble Chat Logo(1).png'),
                  ),
                ),
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
              // ElevatedButton.icon(
              //   onPressed: () {
              //     Navigator.of(context)
              //         .pushNamed(PhoneNumberVerificationWidget.routeName);
              //   },
              //   icon: const Icon(FontAwesomeIcons.phoneFlip),
              //   label: const Text('Continue with Phone Number'),
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 75.0, right: 20.0),
              //         child: const Divider(
              //           thickness: 2,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //     const Text(
              //       "OR",
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 20.0, right: 75.0),
              //         child: const Divider(
              //           thickness: 2,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              FlutterSocialButton(
                onTap: () {},
                buttonType: ButtonType.phone,
              ),
              FlutterSocialButton(
                onTap: () {},
                buttonType: ButtonType.google,
              ),
              // FlutterSocialButton(
              //   onTap: () {},
              // ),

              // GoogleAuthButton(
              //   onPressed: () {
              //     // googleSigIn();
              //   },
              //   style: const AuthButtonStyle(
              //       buttonType: AuthButtonType.secondary,
              //       iconType: AuthIconType.outlined),
              //   text: 'CONTINUE WITH GOOGLE',
              // )
              // OutlinedButton.icon(
              //   onPressed: () {
              //     googleSigIn();
              //   },
              //   icon: const Icon(FontAwesomeIcons.google),
              //   label: const Text('Continue with Google SigIn'),
              // )
            ],
          ))
        ],
      ),
    );
  }
}
