part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

final class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthInitial extends UnAuthenticatedState {
  @override
  List<Object> get props => [];
}

final class LoginLoadingState extends UnAuthenticatedState {
  @override
  List<Object> get props => [];
}

final class LoginSuccessState extends AuthenticatedState {
  @override
  List<Object> get props => [];
}

final class LoginFailureState extends UnAuthenticatedState {
  final String message;

  LoginFailureState(this.message);
  @override
  List<Object> get props => [message];
}
