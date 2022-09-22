import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/list_user.widget.dart';
import 'package:provider/provider.dart';

import '../example.dart';
import 'message.page.dart';

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

  String dropdownValue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthProvider>().signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Text('Logout'),
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (ctx, AsyncSnapshot shapShot) {
          if (shapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDoc = shapShot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              separatorBuilder: ((context, index) {
                return const Divider(
                  thickness: 3,
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
                          groupName: chatDoc[index]['goup_name'],
                        ),
                        settings: RouteSettings(
                          arguments: chatDoc[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        chatDoc[index]['goup_name'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ListUserWidget.routeName);
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
