part of 'auth_flow_cubit.dart';

enum AuthStatus { islogin, isLogout }

class AuthFlowState extends Equatable {
  const AuthFlowState({required this.status});
  final AuthStatus status;

  @override
  List<Object> get props => [status];
}
