// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:auto_route/empty_router_widgets.dart' as _i3;
import 'package:flutter/material.dart' as _i7;

import '../core/auth_flow.const.dart' as _i1;
import '../Home/pages/home.page.dart' as _i4;
import '../Home/widgets/widgets.dart' as _i5;
import '../root/tab_bar.root.dart' as _i2;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthflowRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlow(),
      );
    },
    RootRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.TabBarRoot(),
      );
    },
    HomeRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    OnboardingRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.OnBoardingPage(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'AuthFlow',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          AuthflowRouter.name,
          path: 'AuthFlow',
          children: [
            _i6.RouteConfig(
              RootRouter.name,
              path: 'tab-bar-root',
              parent: AuthflowRouter.name,
              children: [
                _i6.RouteConfig(
                  HomeRouter.name,
                  path: 'Home',
                  parent: RootRouter.name,
                  children: [
                    _i6.RouteConfig(
                      HomeRoute.name,
                      path: '',
                      parent: HomeRouter.name,
                    ),
                    _i6.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: HomeRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i6.RouteConfig(
                  OnboardingRouter.name,
                  path: 'Onboarding',
                  parent: RootRouter.name,
                  children: [
                    _i6.RouteConfig(
                      OnBoardingRoute.name,
                      path: '',
                      parent: OnboardingRouter.name,
                    ),
                    _i6.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: OnboardingRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthFlow]
class AuthflowRouter extends _i6.PageRouteInfo<void> {
  const AuthflowRouter({List<_i6.PageRouteInfo>? children})
      : super(
          AuthflowRouter.name,
          path: 'AuthFlow',
          initialChildren: children,
        );

  static const String name = 'AuthflowRouter';
}

/// generated route for
/// [_i2.TabBarRoot]
class RootRouter extends _i6.PageRouteInfo<void> {
  const RootRouter({List<_i6.PageRouteInfo>? children})
      : super(
          RootRouter.name,
          path: 'tab-bar-root',
          initialChildren: children,
        );

  static const String name = 'RootRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class HomeRouter extends _i6.PageRouteInfo<void> {
  const HomeRouter({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'Home',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class OnboardingRouter extends _i6.PageRouteInfo<void> {
  const OnboardingRouter({List<_i6.PageRouteInfo>? children})
      : super(
          OnboardingRouter.name,
          path: 'Onboarding',
          initialChildren: children,
        );

  static const String name = 'OnboardingRouter';
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.OnBoardingPage]
class OnBoardingRoute extends _i6.PageRouteInfo<void> {
  const OnBoardingRoute()
      : super(
          OnBoardingRoute.name,
          path: '',
        );

  static const String name = 'OnBoardingRoute';
}
