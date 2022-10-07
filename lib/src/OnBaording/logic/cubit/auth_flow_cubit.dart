import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_flow_state.dart';

class AuthFlowCubit extends Cubit<AuthFlowState> {
  AuthFlowCubit() : super(const AuthFlowState(status: AuthStatus.isLogout)) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((user) {
      if (user != null) {
        emit(const AuthFlowState(status: AuthStatus.islogin));
      } else {
        emit(const AuthFlowState(status: AuthStatus.isLogout));
      }
    });
  }
}
