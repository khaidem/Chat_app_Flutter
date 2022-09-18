import 'package:flutter/material.dart';

class SingleChatWidget extends StatelessWidget {
  const SingleChatWidget({Key? key, required this.name}) : super(key: key);
  static const routeName = '/SingleChatWidget';
  final String name;

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(todo),
      ),
    );
  }
}
