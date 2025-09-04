import '../../core/core.dart';

abstract class AuthRepo {
  FutureEitherFailureOr<LoginResponse> login(LoginInput input);
}
