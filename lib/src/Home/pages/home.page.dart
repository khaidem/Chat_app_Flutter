import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/google_sigin.provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text('GoogleSigIn'),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final provider = context.read<GoogleSigInProvider>();
                    provider.onLoginButtonPressedEvent();
                    print(provider);
                  },
                  child: const Text('Sigin With Google'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
