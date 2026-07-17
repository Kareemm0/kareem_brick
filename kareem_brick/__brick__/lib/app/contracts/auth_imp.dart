import '../../core/core.dart';
import '../../domain/repos.dart';
import 'auth_contract.dart';

class LoginContractImpl
    implements LoginContract<FutureEitherFailureOr<LoginResponse>, LoginInput> {
  final AuthRepo _authRepo;

  LoginContractImpl({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  FutureEitherFailureOr<LoginResponse> call(
    LoginInput params,
  ) async {
    final result = await _authRepo.login(params);

    return result;
  }
}
