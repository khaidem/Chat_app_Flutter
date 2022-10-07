import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Home/example.dart';
import '../router/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FireStoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FilePickerProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Bubble Chat',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              return const TabBarRouter();
            }
            return const OnBoardingPage();
          },
        ),
        routes: {
          OtpVerificationPage.routeName: (ctx) => const OtpVerificationPage(),
          HomePage.routeName: (ctx) => const HomePage(),
          PhoneNumberVerificationWidget.routeName: (ctx) =>
              const PhoneNumberVerificationWidget(),
          ListUserPage.routeName: (context) => const ListUserPage(),
          TabBarRouter.routeName: (context) => const TabBarRouter(),
        },
      ),
    );
  }
}
