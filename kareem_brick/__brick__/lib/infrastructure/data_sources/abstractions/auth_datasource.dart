import '../../../core/core.dart';

abstract class AuthDatasource {
  FutureEitherFailureOrMap login(LoginInput input);
}
