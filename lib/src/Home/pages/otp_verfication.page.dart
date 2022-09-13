import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/pages/data-found.page.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/sigin.widget.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);
  static const routeName = '/OtpVerificationPage';

  @override
  Widget build(BuildContext context) {
    TextEditingController OtpSend = TextEditingController();

    final FirebaseAuth auth = FirebaseAuth.instance;
    var code = '';

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onChanged: (value) {
              code = value;
            },
            keyboardType: TextInputType.phone,
            controller: OtpSend,
            decoration: InputDecoration(
              hintText: 'OtpVerification',
              labelText: 'OtpVerification',
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.person),
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                borderSide: BorderSide(
                  color: Colors.black38,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: SigInWidget.verify, smsCode: code);
                await auth.signInWithCredential(credential);
                Navigator.pushNamedAndRemoveUntil(
                    context, DataFoundPage.routeName, (route) => false);
              } catch (e) {
                print(e.toString());
              }
            },
            child: const Text('OTp Send'),
          ),
        ],
      )),
    );
  }
}
