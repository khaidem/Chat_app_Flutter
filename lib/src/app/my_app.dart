import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/list_user.widget.dart';

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
              return const HomePage();
            }
            return const SigInWidget();
          },
        ),
        routes: {
          OtpVerificationPage.routeName: (ctx) => const OtpVerificationPage(),
          HomePage.routeName: (ctx) => const HomePage(),
          PhoneNumberVerificationWidget.routeName: (ctx) =>
              const PhoneNumberVerificationWidget(),
          ListUserWidget.routeName: (context) => const ListUserWidget()
        },
      ),
    );
  }
}
