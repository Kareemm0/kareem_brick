part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginInput inputs;

  const LoginEvent({required this.inputs});

  @override
  List<Object> get props => [inputs];
}
