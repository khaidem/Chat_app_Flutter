import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/login_widget.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/sigin.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const LogInWidget();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went Wrong'),
            );
          } else {
            return const SigInWidget();
          }
        },
      ),
    );
  }
}
