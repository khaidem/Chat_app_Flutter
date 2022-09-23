import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/example.dart';
import 'package:provider/provider.dart';

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

  final List _selectCategory = [];

  final _auth = FirebaseFirestore.instance;
  List<UserModel> userModel = [];
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

//**  group submit creating */
  void _submitGroup() {
    FocusScope.of(context).unfocus();
    context.read<AuthProvider>().addGroup(
          groupName.text.trim(),
          _selectCategory,
        );
    Navigator.of(context).popUntil((route) => route.isFirst);

    // users.add(
    //   {
    //     'active': true,
    //     'create_at': DateTime.now(),
    //     'goup_name': groupName.text.trim(),
    //     'uid_list': _selectCategory,
    //   },
    // ).then(
    //   (DocumentReference docRef) => docRef.update(
    //     {'group_id': docRef.id},
    //   ),
    // );

    groupName.clear();
  }

  Future<void> getData() async {
    var queryDocumentSnapshot =
        await FirebaseFirestore.instance.collection('user_accounts').get();
    var allData = queryDocumentSnapshot.docs.map((e) => e.data()).toList();
    setState(() {
      userModel = allData.cast<UserModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthProvider>().getData();
            },
            child: const Text('data'),
          ),
        ],
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
                  // String phone = userName[index]['phone_number'];
                  // String email = userName[index]['email'];
                  // String phoneNumber = ids[index]['email'];

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
                    onPressed: _submitGroup,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          );
        },
        child: _selectCategory.isEmpty
            ? const Icon(Icons.add)
            : const Icon(Icons.done),
      ),
    );
  }
}
