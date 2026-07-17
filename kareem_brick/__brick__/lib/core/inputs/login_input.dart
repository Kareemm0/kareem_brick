import '../base/base_input.dart';

class LoginInput extends BaseInput {
  final String password;
  final String email;

  const LoginInput({required this.password, required this.email});
  @override
  List<Object?> get props => [password, email];

  @override
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }
}
