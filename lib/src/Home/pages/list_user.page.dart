import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({Key? key}) : super(key: key);
  static const routeName = '/ListUserPage';

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final TextEditingController groupName = TextEditingController();
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user_accounts');
  int count = 2;

  final List _selectCategory = [];

  final _auth = FirebaseFirestore.instance;

//** For Selecting list of User id Form login */
// =================================================
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

//**  Group submit creating */
// ===========================
  void _submitGroup() {
    FocusScope.of(context).unfocus();
    // context.read<FireStoreProvider>().addGroup(
    //       groupName.text.trim(),
    //       _selectCategory,
    //     );
    Navigator.of(context).popUntil((route) => route.isFirst);
    // Navigator.popUntil(
    //     context, ModalRoute.withName(Navigator.defaultRouteName));
    // Navigator.popUntil(context, ModalRoute.withName('/'));

    groupName.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final ids = asyncSnapshot.data.docs;
            log('Show List of user form logIn $ids');

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return CheckboxListTile(
                    tristate: true,
                    secondary: const Icon(Icons.person),
                    title: Text(ids[index]['email'].isEmpty
                        ? ids[index]['phone_number']
                        : ids[index]['email']),
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
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text(
                              "Enter Group Name",
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextField(
                            controller: groupName,
                            decoration: const InputDecoration(
                              hintText: "Enter Group Name",
                              border: InputBorder.none,
                            ),
                            maxLines: 8,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _submitGroup();
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ));
              });
        },
        child: _selectCategory.isEmpty
            ? const Icon(Icons.add)
            : const Icon(Icons.done),
      ),
    );
  }
}
