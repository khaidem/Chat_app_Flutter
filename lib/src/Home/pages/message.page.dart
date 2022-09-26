import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/Home/pages/group_user_list.page.dart';

import '../example.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);
  static const routeName = '/MessagePage';
  final String groupId;
  final String groupName;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => GroupUserList(
                  groupId: widget.groupId,
                  uidList: const [],
                ),
              ),
            );
          },
          child: Text(widget.groupName),
        ),
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'Add New user',
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AddMoreUserPage(
                          groupId: widget.groupId,
                          groupName: widget.groupName,
                        ),
                      ),
                    );
                  },
                  child: const SizedBox(
                    child: Text("Add New User"),
                  ),
                ),
              )
            ],
            onChanged: (value) {},
          )
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: SendingMessageBodyWidget(
                groupId: widget.groupId,
              ),
            ),
            MessageTextWidget(
              groupId: widget.groupId,
            )
          ],
        ),
      ),
    );
  }
}
