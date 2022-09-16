import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../example.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  String? name;
  String? email;
  String? password;
  var phone = '+91';

  final FirebaseAuth _auth = FirebaseAuth.instance;

//** For Google SigIn */
  Future googleSigIn() async {
    try {
      final googleUser = await googleSignIn.signIn();

      final ggAuth = await googleUser!.authentication;

      log(ggAuth.idToken.toString());

      _user = googleUser;
      if (_user == null) {
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      debugPrint(
        credential.toString(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      rethrow;
    }

    notifyListeners();
  }

  ///** For LogOut Firebase */
  Future signOut() async {
    await googleSignIn.signOut();
    log('LogOut');
    FirebaseAuth.instance.signOut();
  }

//** Show error Form Firebase Exception */
  _showDialog(context, String error) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(error),
        actions: [
          ElevatedButton(
            child: const Text('Close me!'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  //***For Sending  Verification Phone */
  Future verificationPhone(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _auth
                .signInWithCredential(phoneAuthCredential)
                .then((value) async {
              if (value.user != null) {
                debugPrint('User logged in');
              }
            });
          },
          verificationFailed: (FirebaseException e) {
            _showDialog(context, e.toString());
            log(e.toString());
          },
          codeSent: (String verificationId, int? resendToken) {
            SigInWidget.verify = verificationId;
            Navigator.of(context).pushNamedAndRemoveUntil(
                OtpVerificationPage.routeName, (route) => false);
          },
          codeAutoRetrievalTimeout: (String verification) {});
    } catch (error) {
      debugPrint(
        error.toString(),
      );
    }
  }

//** After Receive  Phone OtpVerification */
  Future otpVerification(String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: SigInWidget.verify, smsCode: code);
      await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
