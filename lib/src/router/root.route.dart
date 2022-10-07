import 'package:auto_route/auto_route.dart';
import 'package:goole_sigin_firebase/src/router/home.router.dart';
import 'package:goole_sigin_firebase/src/router/list_user.router.dart';
import 'package:goole_sigin_firebase/src/router/router.dart';

const rootRoute = AutoRoute(
  page: TabBarRouter,
  initial: true,
  name: 'RootRouter',
  children: [
    homeTab,
    listUserTab,
  ],
);
