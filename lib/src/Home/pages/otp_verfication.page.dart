import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/pages/data-found.page.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);
  static const routeName = '/OtpVerificationPage';

  @override
  Widget build(BuildContext context) {
    TextEditingController OtpSend = TextEditingController();
    String verificationIdReceived = '';
    String? verificationCode;
    final FirebaseAuth auth = FirebaseAuth.instance;

    void verifyPin(String pin) async {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIdReceived, smsCode: pin);

      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        const snackBar = SnackBar(content: Text("Login Sucess"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(content: Text("${e.message}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        log(snackBar.toString());
      }
    }

    Future<void> getPin(String pin) async {
      try {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: verificationCode!, smsCode: pin))
            .then((value) async {
          if (value.user != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DataFoundPage()),
                (route) => false);
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
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
            onPressed: () {
              getPin;
            },
            child: const Text('LogOut'),
          ),
        ],
      )),
    );
  }
}
