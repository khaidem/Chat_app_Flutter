import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/pages/data-found.page.dart';
import 'package:goole_sigin_firebase/src/Home/pages/home.page.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/otp_verfication.widget.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/phone_verification.widget.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/sigin.widget.dart';
import 'package:provider/provider.dart';

import '../Home/logic/provider/auth.provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SigInWidget(),
        routes: {
          OtpVerificationPage.routeName: (ctx) => const OtpVerificationPage(),
          DataFoundPage.routeName: (ctx) => const DataFoundPage(),
          HomePage.routeName: (ctx) => const HomePage(),
          PhoneNumberVerificationWidget.routeName: (ctx) =>
              const PhoneNumberVerificationWidget()
        },
      ),
    );
  }
}
