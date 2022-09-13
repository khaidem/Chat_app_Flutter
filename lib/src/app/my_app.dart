import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/pages/data-found.page.dart';
import 'package:goole_sigin_firebase/src/Home/pages/home.page.dart';
import 'package:goole_sigin_firebase/src/Home/pages/otp_verfication.page.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/login_widget.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/sigin.widget.dart';
import 'package:provider/provider.dart';

import '../Home/logic/provider/google_sigin.provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSigInProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SigInWidget(),
        routes: {
          LogInWidget.routeName: (ctx) => const LogInWidget(),
          // HomePage.routeName: (ctx) => const HomePage(),
          OtpVerificationPage.routeName: (ctx) => const OtpVerificationPage(),
          DataFoundPage.routeName: (ctx) => const DataFoundPage(),
          HomePage.routeName: (ctx) => const HomePage(),
        },
      ),
    );
  }
}
