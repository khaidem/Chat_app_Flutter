import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/example.dart';
import 'package:provider/provider.dart';

class AddMoreUserPage extends StatefulWidget {
  const AddMoreUserPage({
    Key? key,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);
  static const routeName = '/AddMoreUserPage';
  final String groupId;
  final String groupName;

  @override
  State<AddMoreUserPage> createState() => _AddMoreUserPageState();
}

class _AddMoreUserPageState extends State<AddMoreUserPage> {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user_accounts');
  final List _selectCategory = [];

  //** For Selecting list of User id Form login */
  void _onCategorySelected(bool? selected, code) {
    if (selected == true) {
      setState(
        () {
          _selectCategory.add(code);
        },
      );
    } else {
      setState(
        () {
          _selectCategory.remove(code);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final ids = asyncSnapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return CheckboxListTile(
                    tristate: true,
                    secondary: const Icon(Icons.person),
                    title: Text(
                      ids[index]['email'].isEmpty
                          ? ids[index]['phone_number']
                          : ids[index]['email'],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    value: _selectCategory.contains(
                      ids[index]['uid'],
                    ),
                    onChanged: (value) {
                      setState(() {
                        _onCategorySelected(
                          value,
                          ids[index]['uid'],
                        );
                      });
                    },
                  );
                },
                separatorBuilder: ((context, index) {
                  return const Divider(
                    thickness: 3,
                  );
                }),
                itemCount: ids.length,
              ),
            );
          } else if (asyncSnapshot.hasError) {
            return const Text(' Error');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<AuthProvider>()
              .newUserAdd(widget.groupId, context, _selectCategory);
        },
        child: _selectCategory.isEmpty
            ? const Icon(Icons.add)
            : const Icon(Icons.done),
      ),
    );
  }
}
