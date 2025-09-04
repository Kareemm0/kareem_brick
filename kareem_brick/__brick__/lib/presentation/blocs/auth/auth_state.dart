part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

abstract final class AuthenticatedState extends AuthState {}

abstract final class UnauthenticatedState extends AuthState {}

final class AuthInitial extends UnauthenticatedState {}

final class LoginLoadingState extends UnauthenticatedState {}

final class LoginFailureState extends UnauthenticatedState {
  final String msg;

  LoginFailureState({required this.msg});

  @override
  List<Object> get props => [msg];
}

final class LoginSuccessState extends AuthenticatedState {}
