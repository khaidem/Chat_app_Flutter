// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:goole_sigin_firebase/src/core/auth_flow.const.dart';
import 'package:goole_sigin_firebase/src/router/root.route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        name: 'AuthflowRouter',
        path: 'AuthFlow',
        page: AuthFlow,
        initial: true,
        children: [
          rootRoute,
        ]),
  ],
)
class $AppRouter {}
