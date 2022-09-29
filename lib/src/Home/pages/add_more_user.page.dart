import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/data/repo/firebase_api.repo.dart';
import 'package:goole_sigin_firebase/src/Home/example.dart';
import 'package:provider/provider.dart';

class AddMoreUserPage extends StatefulWidget {
  const AddMoreUserPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.uidList,
  }) : super(key: key);
  static const routeName = '/AddMoreUserPage';
  final String groupId;
  final String groupName;
  final List<dynamic> uidList;

  @override
  State<AddMoreUserPage> createState() => _AddMoreUserPageState();
}

class _AddMoreUserPageState extends State<AddMoreUserPage> {
  ///**FireStore data Store */
  final curd = Curd();

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user_accounts');
  final List _selectCategory = [];
  bool isChecked = false;

  //** For Selecting list of User id Form login */
  // ==============================================
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
        title: const Text(' Add User '),
      ),
      body: StreamBuilder(
        stream: collectionRef
            // .where('uid', isNotEqualTo: widget.uidList)
            .snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final ids = asyncSnapshot.data.docs;
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
                      style: TextStyle(
                          decoration: widget.uidList.contains(ids[index]['uid'])
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: widget.uidList.contains(ids[index]['uid'])
                              ? Colors.grey
                              : Colors.black),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    value: _selectCategory.contains(
                      ids[index]['uid'],
                    ),
                    onChanged: (value) {
                      widget.uidList.contains(ids[index]['uid'])
                          ? showDialog(
                              context: context,
                              builder: (ctx) {
                                return const AlertDialog(
                                  content: Text('Already in the group'),
                                );
                              })
                          : setState(() {
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
