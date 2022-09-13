import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../example.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);
  static const routeName = '/OtpVerificationPage';

  @override
  Widget build(BuildContext context) {
    TextEditingController otpSend = TextEditingController();
    var code = '';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
              "OTP Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              onCompleted: (pin) => debugPrint(pin),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade600,
              ),
              onPressed: () {
                final otpSend = context.read<AuthProvider>();
                otpSend.otpVerification(code);
                Navigator.pushNamedAndRemoveUntil(
                    context, DataFoundPage.routeName, (route) => false);
              },
              child: const Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
