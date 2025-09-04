import '../core.dart';

class LoginInput extends BaseInput {
  final String password;

  const LoginInput({required this.password});
  @override
  List<Object?> get props => [password];

  @override
  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }
}
