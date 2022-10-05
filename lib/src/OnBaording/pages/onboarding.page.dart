import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:goole_sigin_firebase/src/router/tab_bar.dart';

import 'package:provider/provider.dart';

import '../../Home/example.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  String verificationIdReceived = '';
  bool isSignedIn = false;
  bool isLoading = false;

//*** After GoogleSigIn and Route  */
// ===============================
  void googleSigIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text('Authenticating with Google...')
            ],
          ),
        );
      },
    );
    if (!mounted) return;
    final provider = context.read<AuthProvider>();

    await provider.googleSigIn().then(
          (value) => Navigator.pushNamedAndRemoveUntil(
              context, TabBarRouter.routeName, (route) => false),
        );
  }

//**Exit app warning */
// =======================
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );

    return exitResult ?? false;
  }

//**Exit app warning Dialog */
// =======================
  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 32, 48, 61),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(100),
                        child: Image.asset('assets/images/chatImage.png'),
                      ),
                    ),
                    const Text(
                      'Let\'s Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Welcome! How would you like to Connect?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FlutterSocialButton(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(PhoneNumberVerificationWidget.routeName);
                    },
                    buttonType: ButtonType.phone,
                  ),
                  FlutterSocialButton(
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     duration: const Duration(seconds: 4),
                      //     content: Row(
                      //       children: const [
                      //         CircularProgressIndicator(),
                      //         Text('Loading')
                      //       ],
                      //     ),
                      //   ),
                      // );
                      googleSigIn();
                    },
                    buttonType: ButtonType.google,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
