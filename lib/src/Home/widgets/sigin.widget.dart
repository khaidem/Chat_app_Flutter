import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/auth.provider.dart';
import 'package:goole_sigin_firebase/src/Home/pages/home.page.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/phone_number_verification.widget.dart';
import 'package:provider/provider.dart';

class SigInWidget extends StatefulWidget {
  const SigInWidget({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<SigInWidget> createState() => _SigInWidgetState();
}

class _SigInWidgetState extends State<SigInWidget> {
  String verificationIdReceived = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton.icon(
              onPressed: () {
                final provider = context.read<AuthProvider>();
                provider.googleUser().then(
                      (value) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return const HomePage();
                          },
                        ),
                      ),
                    );
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
