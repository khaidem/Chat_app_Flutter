import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/example.dart';

class TabBarRouter extends StatefulWidget {
  const TabBarRouter({Key? key}) : super(key: key);
  static const routeName = '/TabBarRouter';

  @override
  State<TabBarRouter> createState() => _TabBarRouterState();
}

class _TabBarRouterState extends State<TabBarRouter>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 42, 126, 44),
          title: const Text('Bubble Chat'),
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
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                // icon: Icon(Icons.chat),
                text: 'Group name'.toUpperCase(),
              ),
              Tab(
                // icon: Icon(Icons.person),
                text: 'All Person'.toUpperCase(),
              ),
            ],
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: const [HomePage(), ListUserPage()]),
      ),
    );
  }
}
