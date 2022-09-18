import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/logic/provider/auth.provider.dart';
import 'package:goole_sigin_firebase/src/Home/widgets/single_chat.widget.dart';
import 'package:provider/provider.dart';

final database1 = FirebaseFirestore.instance;
Future<QuerySnapshot> years = database1.collection('user_accounts').get();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('user_accounts');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionRef.snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> shapShot) {
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
                        builder: (ctx) => SingleChatWidget(
                          name: chatDoc[index]['name'],
                        ),
                        settings: RouteSettings(
                          arguments: chatDoc[index],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      chatDoc[index]['name'],
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
          context.read<AuthProvider>().getData();
          // Navigator.pushNamed(context, GroupCreateWidget.routeName);
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }

  getUser(AsyncSnapshot<QuerySnapshot> snapShot) {
    return snapShot.data!.docs
        .map(
          (doc) => ListTile(
            title: Text(
              doc["name"],
            ),
          ),
        )
        .toList();
  }
}
