import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../example.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);
  static const routeName = '/OtpVerificationPage';

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  TextEditingController otpSend = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;

  var code = '';
  bool isLoading = false;
  bool enableButton = false;

  @override
  void dispose() {
    otpSend.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 123, 172, 214),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter OTP ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Pinput(
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsRetrieverApi,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              onCompleted: (pin) {
                // if (pin.isEmpty) {
                //   return;
                // } else {
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //       HomePage.routeName, (route) => false);
                // }
              },
              onChanged: (value) {
                if (value.length == 6) {
                  setState(
                    () {
                      enableButton = true;
                      code = value;
                    },
                  );
                } else {
                  enableButton = false;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade600,
              ),
              onPressed: enableButton
                  ? () async {
                      if (mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }

                      try {
                        final otpSend = context.read<AuthProvider>();
                        //  await FirebaseFirestore.instance
                        //       .collection('user_accounts')
                        //       .doc(_auth.currentUser!.uid)
                        //       .set({
                        //     'phone_number': phone,
                        //   });

                        otpSend.otpVerification(code).then(
                              (value) => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      DataFoundPage.routeName,
                                      (route) => false),
                            );

                        await Future.delayed(
                          const Duration(seconds: 3),
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Success'),
                        //     duration: Duration(milliseconds: 300),
                        //   ),
                        // );
                      } catch (error) {
                        print(error.toString());
                      }
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  : null,
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      ),
                    )
                  : const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
