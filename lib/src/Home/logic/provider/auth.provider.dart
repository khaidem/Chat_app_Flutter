import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../example.dart';

class AuthProvider with ChangeNotifier {
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  final googleSignIn = GoogleSignIn();
  String? name;
  String? email;
  String? password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//** For Google SigIn */
  Future sigIn(
    BuildContext context,
  ) async {
    try {
      final googleUser = await googleSignIn.signIn();

      // if (_user == null) {
      //   return null;
      // }
      if (googleUser == null) return;
      _user = googleUser;

      //** Obtain the auth details form the request */
      final googleAuth = await googleUser.authentication;

      //** Create new credentail */
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      debugPrint(
        credential.toString(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      _firestore.collection('user_accounts').doc(_auth.currentUser!.uid).set({
        'active': true,
        'created_at': Timestamp.now(),
        'email': _auth.currentUser!.email,
        'phone_number': '',
        'uid': _auth.currentUser!.uid,
      });
      notifyListeners();
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      rethrow;
    }

    notifyListeners();
  }

  ///** For LogOut Firebase */
  signOut() async {
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
            OnBoardingPage.verify = verificationId;

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
          verificationId: OnBoardingPage.verify, smsCode: code);
      await _auth.signInWithCredential(credential);
      _firestore.collection('user_accounts').doc(_auth.currentUser!.uid).set({
        'active': true,
        'created_at': Timestamp.now(),
        'phone_number': _auth.currentUser!.phoneNumber,
        'uid': _auth.currentUser!.uid,
        'email': ''
      });
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
