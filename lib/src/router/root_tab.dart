import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import 'package:goole_sigin_firebase/src/router/router.dart';

import '../Home/example.dart';

const rootTab = AutoRoute(page: TabBarRouter, name: 'TabBarRouter', children: [
  AutoRoute(
    path: 'Home',
    name: "HomeRouter",
    page: EmptyRouterPage,
    children: [
      AutoRoute(path: '', page: HomePage),
      RedirectRoute(path: '*', redirectTo: ''),
    ],
  ),
  AutoRoute(
    path: 'Onboarding',
    name: "OnboardingRouter",
    page: EmptyRouterPage,
    children: [
      AutoRoute(path: '', page: OnBoardingPage),
      RedirectRoute(path: '*', redirectTo: ''),
    ],
  ),
]);
