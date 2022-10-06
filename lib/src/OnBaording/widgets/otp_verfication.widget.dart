import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/router/router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../Home/example.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);
  static const routeName = '/OtpVerificationPage';

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage>
    with SingleTickerProviderStateMixin {
  TextEditingController otpSend = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var code = '';
  bool isLoading = false;
  bool enableButton = false;
  int _counter = 0;
  AnimationController? _controller;
  int levelClock = 180;
  void Increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock,
      ),
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    otpSend.dispose();
    _controller!.dispose();
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
      body: Center(
        child: Column(children: <Widget>[
          Container(
            height: 350,
            width: 200,
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/otp_check.png',
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Verification ",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const Text('you will get a OTP via SMS'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'wait :'.toUpperCase(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Countdown(
                          animation: StepTween(begin: levelClock, end: 0)
                              .animate(_controller!),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                              final otpSend = context.read<AuthProvider>();
                              otpSend.otpVerification(code).then(
                                    (value) => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      TabBarRouter.routeName,
                                      (route) => false,
                                    ),
                                  );
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
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print(
        'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      timerText,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
