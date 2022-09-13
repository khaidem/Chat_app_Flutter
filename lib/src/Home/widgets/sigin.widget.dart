import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/google_sigin.provider.dart';
import 'package:goole_sigin_firebase/src/Home/pages/home.page.dart';
import 'package:goole_sigin_firebase/src/Home/pages/otp_verfication.page.dart';
import 'package:provider/provider.dart';

class SigInWidget extends StatefulWidget {
  const SigInWidget({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<SigInWidget> createState() => _SigInWidgetState();
}

class _SigInWidgetState extends State<SigInWidget> {
  final TextEditingController phoneNumber = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  var phone = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdReceived = '';

  ///***** */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    onChanged: (value) {
                      phone = value;
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneNumber,
                    decoration: InputDecoration(
                      hintText: 'PhoneNumber',
                      labelText: 'PhoneNumber',
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
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumber.text,
                        verificationCompleted:
                            (PhoneAuthCredential credentail) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationID, int? resendToken) {
                          SigInWidget.verify = verificationID;
                          Navigator.of(context)
                              .pushNamed(OtpVerificationPage.routeName);
                        },
                        codeAutoRetrievalTimeout: (String verification) {});
                  },
                  child: const Text('Phone Auth'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final provider = context.read<GoogleSigInProvider>();
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
                  child: const Text('Sigin With Google'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
