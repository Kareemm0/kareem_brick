import 'query_options.dart' show QueryOptions;
import 'query_result.dart' show QueryResult;

/// An abstract interface for a GraphQL client that
/// provides methods to execute queries and mutations.
abstract interface class BaseGraphClient {
  /// This method is used to execute a query and return the result.
  Future<QueryResult> query(QueryOptions options);

  /// This method is used to execute a mutation and return the result.
  Future<QueryResult> mutate(QueryOptions options);
}
