import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goole_sigin_firebase/src/OnBaording/logic/cubit/auth_flow_cubit.dart';
import 'package:goole_sigin_firebase/src/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthFlowCubit(),
        )
      ],
      // return MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //       create: (_) => AuthProvider(),
      //     ),
      //     ChangeNotifierProvider(
      //       create: (_) => FireStoreProvider(),
      //     ),
      //     ChangeNotifierProvider(
      //       create: (_) => FilePickerProvider(),
      //     ),
      //   ],
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),

        title: 'Bubble Chat',
        debugShowCheckedModeBanner: false,
        // home: const TabBarRouter(),
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (ctx, snapShot) {
        //     if (snapShot.hasData) {
        //       return const TabBarRouter();
        //     }
        //     return const OnBoardingPage();
        //   },
        // ),
        // routes: {
        //   OtpVerificationPage.routeName: (ctx) => const OtpVerificationPage(),
        //   HomePage.routeName: (ctx) => const HomePage(),
        //   PhoneNumberVerificationWidget.routeName: (ctx) =>
        //       const PhoneNumberVerificationWidget(),
        //   ListUserPage.routeName: (context) => const ListUserPage(),
        //   TabBarRouter.routeName: (context) => const TabBarRouter(),
        // },
      ),
    );
  }
}
