import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMoreUserPage extends StatefulWidget {
  const AddMoreUserPage(
      {Key? key, required this.groupId, required this.groupName})
      : super(key: key);
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
        title: const Text('Add new User'),
      ),
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final userName = asyncSnapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    // String phone = userName[index]['phone_number'];
                    // String email = userName[index]['email'];
                    String uid = userName[index]['uid'];

                    return CheckboxListTile(
                      tristate: true,
                      secondary: const Icon(Icons.person),
                      title: Text(uid),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      value: _selectCategory.contains(
                        userName[index]['uid'],
                      ),
                      onChanged: (value) {
                        setState(() {
                          _onCategorySelected(
                            value,
                            userName[index]['uid'],
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
                  itemCount: userName.length),
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
        onPressed: () async {
          final CollectionReference newUserAdd =
              FirebaseFirestore.instance.collection('group_chat');
          await newUserAdd
              .doc(widget.groupId)
              .update({'uid_list': _selectCategory});
          Navigator.of(context).pop();
        },
        child: _selectCategory.isEmpty
            ? const Icon(Icons.add)
            : const Icon(Icons.done),
      ),
    );
  }
}
