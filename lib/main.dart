import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/router/router.dart';
import 'src/app/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appRouter = AppRouter();

  runApp(MyApp(
    appRouter: appRouter,
  ));
}
