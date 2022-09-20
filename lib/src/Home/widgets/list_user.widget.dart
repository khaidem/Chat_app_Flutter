import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/example.dart';

class ListUserWidget extends StatefulWidget {
  const ListUserWidget({Key? key}) : super(key: key);
  static const routeName = '/ListUserWidget';

  @override
  State<ListUserWidget> createState() => _ListUserWidgetState();
}

class _ListUserWidgetState extends State<ListUserWidget> {
  final TextEditingController groupName = TextEditingController();
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user_accounts');
  CollectionReference users =
      FirebaseFirestore.instance.collection('group_chat');

  final List _selectCategory = [];

  DocumentReference? doc;
  void _onCategorySelected(bool? selected, code) {
    if (selected == true) {
      setState(() {
        _selectCategory.add(code);
      });
    } else {
      setState(() {
        _selectCategory.remove(code);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // var data = _selectCategory;
              // log(data.toString());
              // context.read<AuthProvider>().getData();
              // var uid = FirebaseAuth.instance.currentUser!.uid;
              // log(uid.toString());
              var data = doc!.id;
              log(data.toString());
            },
            child: const Text('data'),
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final userName = asyncSnapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {},
                    child: CheckboxListTile(
                      tristate: true,
                      secondary: const Icon(Icons.person),
                      title: Text(userName[index]['uid']),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      value: _selectCategory.contains(
                        userName[index]['uid'],
                      ),
                      onChanged: (value) {
                        setState(() {
                          _onCategorySelected(value, userName[index]['uid']);
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: ((context, index) {
                  return const Divider(
                    thickness: 3,
                  );
                }),
                itemCount: userName.length),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Center(
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: groupName,
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
                ),
              ),
              // content: const Text('Username or password wrong'),
              actions: [
                Center(
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      users.add(
                        {
                          'active': true,
                          'create_at': DateTime.now(),
                          'goup_name': groupName.text.trim(),
                          'uid_list': _selectCategory,
                        },
                      ).then(
                        (DocumentReference docRef) => docRef.update(
                          {'group_id': docRef.id},
                        ),
                      );
                      Navigator.of(context).popAndPushNamed(HomePage.routeName);

                      groupName.clear();
                    },
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
