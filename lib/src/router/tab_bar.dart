import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Home/example.dart';
import '../core/const.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class TabBarRouter extends StatefulWidget {
  const TabBarRouter({Key? key}) : super(key: key);
  static const routeName = '/TabBarRouter';

  @override
  State<TabBarRouter> createState() => _TabBarRouterState();
}

class _TabBarRouterState extends State<TabBarRouter>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  int currentIndex = 0;
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
        appBar: _buildAppBar(context, _tabController),
        body: TabBarView(
          controller: _tabController,
          children: const [
            HomePage(),
            ListUserPage(),
          ],
        ),
      ),
    );
  }
}

//** AppBar  */
PreferredSizeWidget _buildAppBar(
    BuildContext context, TabController tabController) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: mainColors,
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
        controller: tabController,
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
        indicatorColor: Colors.white),
  );
}
