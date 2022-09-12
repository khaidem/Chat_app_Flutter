import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/logic/provider/google_sigin.provider.dart';
import '../Home/pages/google_sigin.dart';

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
        home: const GoogleSigInPage(),
      ),
    );
  }
}
