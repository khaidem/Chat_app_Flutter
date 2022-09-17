import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/firebase_data.provider.dart';

import 'package:provider/provider.dart';

import '../Home/example.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseDataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              return const DataFoundPage();
            }
            return const SigInWidget();
          },
        ),
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
