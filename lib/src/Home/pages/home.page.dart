import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/app/my_app.dart';

import '../example.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('group_chat');
  final TextEditingController groupName = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Group List Name'),
      //   actions: [
      //     DropdownButtonHideUnderline(
      //       child: DropdownButton(
      //         icon: const Icon(
      //           Icons.more_vert,
      //           color: Colors.white,
      //         ),
      //         items: const [
      //           DropdownMenuItem(
      //             value: 'Add New user',
      //             child: SizedBox(
      //               child: Text("Logout"),
      //             ),
      //           ),
      //         ],
      //         onChanged: (value) {
      //           if (value == 'Add New user') {
      //             context.read<AuthProvider>().signOut();
      //             Navigator.of(context).pushReplacementNamed('/');
      //           }
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: StreamBuilder(
        stream: collectionRef.where('uid_list',
            arrayContainsAny: [_auth.currentUser!.uid]).snapshots(),
        builder: (ctx, AsyncSnapshot snapShot) {
          log('${_auth.currentUser!.email}');
          log('${_auth.currentUser!.phoneNumber}');
          if (!snapShot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapShot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data Found'),
            );
          } else {
            final chatDoc = snapShot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: chatDoc.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      navigatorKey.currentState?.push(
                        MaterialPageRoute(
                          builder: (ctx) => MessagePage(
                            groupId: chatDoc[index]['group_id'],
                            groupName: chatDoc[index]['group_name'],
                            uidList: chatDoc[index]['uid_list'],
                          ),
                          settings: RouteSettings(
                            arguments: chatDoc[index],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(chatDoc[index]['group_name']),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      // leading: Text(chatDoc[index]['uid']),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(ListUserPage.routeName);
      //   },
      //   child: const Icon(Icons.group_add),
      // ),
    );
  }
}
