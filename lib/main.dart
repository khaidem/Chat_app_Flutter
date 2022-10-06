import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
  // ));

  runApp(const MyApp());
}
