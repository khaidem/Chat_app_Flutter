import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goole_sigin_firebase/src/Home/pages/group_user_list.page.dart';

import '../../core/const.dart';
import '../example.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.uidList,
  }) : super(key: key);
  static const routeName = '/MessagePage';
  final String groupId;
  final String groupName;

  final List<dynamic> uidList;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: mainColors,
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => GroupUserList(
                  groupId: widget.groupId,
                  uidList: widget.uidList,
                ),
              ),
            );
          },
          child: Text(widget.groupName),
        ),
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
                    child: Text("Add New User"),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != 'Add New User') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddMoreUserPage(
                        groupId: widget.groupId,
                        groupName: widget.groupName,
                        uidList: widget.uidList,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SendingMessageBodyWidget(
              groupId: widget.groupId,
              uidList: widget.uidList,
            ),
          ),
          MessageTextWidget(
            groupId: widget.groupId,
          )
        ],
      ),
    );
  }
}
