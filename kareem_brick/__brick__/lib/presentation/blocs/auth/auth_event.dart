part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final BaseInput input;

  const LoginEvent({required this.input});

  @override
  List<Object> get props => [input];
}
