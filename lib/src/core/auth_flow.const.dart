import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goole_sigin_firebase/src/OnBaording/logic/cubit/auth_flow_cubit.dart';
import 'package:goole_sigin_firebase/src/router/router.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthFlowCubit>().state;
    return AutoRouter.declarative(
      routes: (context) {
        switch (state.status) {
          case AuthStatus.islogin:
            return [const HomeRoute()];
          case AuthStatus.isLogout:
            return [const ListUserRoute()];
        }
      },
    );
  }
}
