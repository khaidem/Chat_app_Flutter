import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
        actions: [
          ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
              },
              child: const Text('Logout'))
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
                        builder: (ctx) => const MessagePage(),
                        settings: RouteSettings(
                          arguments: chatDoc[index]['goup_name'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 30,
                    child: Center(
                      child: Text(
                        chatDoc[index]['goup_name'],
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

                      context
                          .read<AuthProvider>()
                          .addGroup(groupName.text.trim());

                      Navigator.of(context).pop();
                      groupName.clear();
                    },
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
