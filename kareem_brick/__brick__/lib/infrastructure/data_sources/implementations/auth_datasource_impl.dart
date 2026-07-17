import '../../../core/core.dart';
import '../../data_sources.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final ApiConsumer _apiConsumer;

  AuthDatasourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  FutureEitherFailureOrMap login(LoginInput input) async {
    final response = await _apiConsumer.post(
      path: EndPoints.login,
      body: input.toJson(),
    );
    return response;
  }
}
