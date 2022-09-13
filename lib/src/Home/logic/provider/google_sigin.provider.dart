import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigInProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  String? name;
  String? email;
  String? password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future googleUser() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print(credential);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error.toString());
    }

    notifyListeners();
  }

  Future signOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<void> verifyPhoneNumber(String phonNumber) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {};
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException) {};
    PhoneCodeSent codeSent =
        (String verfication, [int? forceResendingToken]) {};
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verification) {};
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phonNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {}
  }
}
