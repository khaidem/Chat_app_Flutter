import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: const Text('List of Group Name'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Add New user',
                  child: SizedBox(
                    child: Text("Logout"),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'Add New user') {
                  context.read<AuthProvider>().signOut();
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: collectionRef.where('uid_list',
            arrayContainsAny: [_auth.currentUser!.uid]).snapshots(),
        builder: (ctx, AsyncSnapshot snapShot) {
          log('${_auth.currentUser!.email}');
          log('${_auth.currentUser!.phoneNumber}');

          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapShot.connectionState == ConnectionState.active ||
              snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasError) {
              return const Text('Error');
            } else if (snapShot.hasData) {
              final chatDoc = snapShot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      thickness: 1,
                    );
                  }),
                  itemCount: chatDoc.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
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
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text(chatDoc[index]['group_name']),
                          trailing: const Icon(Icons.arrow_forward),
                          // leading: Text(chatDoc[index]['uid']),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('Empty data'));
            }
          } else {
            return Text('State: ${snapShot.connectionState}');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ListUserPage.routeName);
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
