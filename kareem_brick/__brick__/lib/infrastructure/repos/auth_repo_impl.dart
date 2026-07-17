import 'package:fpdart/fpdart.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data_sources.dart' show AuthDatasource;

class AuthRepoImpl implements AuthRepo {
  final AuthDatasource _datasource;

  AuthRepoImpl({required AuthDatasource datasource}) : _datasource = datasource;
  @override
  FutureEitherFailureOr<LoginResponse> login(LoginInput input) async {
    final response = await _datasource.login(input);

    try {
      return response.map(LoginResponse.fromJson);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}
