import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:goole_sigin_firebase/src/router/router.dart';

class TabBarRoot extends StatelessWidget {
  const TabBarRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [HomeRoute(), OnBoardingRoute()],
      builder: (context, child, controller) {
        // final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(' Drawer'),
                    )
                  ],
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(context.topRoute.name),
            leading: const AutoLeadingButton(),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: '1', icon: Icon(Icons.home)),
                Tab(text: '2', icon: Icon(Icons.person)),
                // Tab(text: '3', icon: Icon(Icons.menu)),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
