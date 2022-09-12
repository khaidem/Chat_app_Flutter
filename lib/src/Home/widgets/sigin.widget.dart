import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/google_sigin.provider.dart';
import 'package:goole_sigin_firebase/src/Home/pages/otp_verfication.page.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/login_widget.dart';
import 'package:provider/provider.dart';

class SigInWidget extends StatefulWidget {
  const SigInWidget({Key? key}) : super(key: key);

  @override
  State<SigInWidget> createState() => _SigInWidgetState();
}

class _SigInWidgetState extends State<SigInWidget> {
  final TextEditingController phoneNumber = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdReceived = '';

  ///***** */
  Future<void> verifyNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then(
            (value) async {
              if (value.user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OtpVerificationPage(),
                  ),
                );
              }
            },
          );
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          verificationIdReceived = verficationID;
        },
        codeAutoRetrievalTimeout: (String verficationID) {});
  }

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
                  onPressed: () {
                    verifyNumber();
                  },
                  child: const Text('Phone Auth'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final provider = context.read<GoogleSigInProvider>();
                    provider
                        .googleUser()
                        .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return const LogInWidget();
                                },
                              ),
                            ));
                    print(provider);
                    // Navigator.of(context).push(LogInWidget.routeName);
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
