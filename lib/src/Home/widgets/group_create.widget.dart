import 'package:flutter/material.dart';

class GroupCreateWidget extends StatefulWidget {
  const GroupCreateWidget({Key? key}) : super(key: key);
  static const routeName = '/GroupCreateWidget';

  @override
  State<GroupCreateWidget> createState() => _GroupCreateWidgetState();
}

class _GroupCreateWidgetState extends State<GroupCreateWidget> {
  final TextEditingController _groupName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              controller: _groupName,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter group Name",
                labelText: 'Enter group Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
