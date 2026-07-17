import 'package:fpdart/fpdart.dart';

import '../core.dart';

typedef FutureEitherFailureOr<T> = Future<Either<Failure, T>>;
typedef FutureEitherFailureOrMap = FutureEitherFailureOr<Map<String, dynamic>>;
