import 'package:graphql/client.dart'
    as gclient
    show GraphQLClient, MutationOptions, QueryOptions, gql, FetchPolicy;

import '../../../core/network.dart';


class GraphQLClientImpl implements BaseGraphClient {
  final gclient.GraphQLClient _client;

  GraphQLClientImpl({required gclient.GraphQLClient client}) : _client = client;

  @override
  Future<QueryResult> query(QueryOptions options) async {
    final result = await _client.query(
      gclient.QueryOptions(
        document: gclient.gql(options.query),
        operationName: options.operationName,
        variables: options.variables,
        fetchPolicy: gclient.FetchPolicy.noCache,
      ),
    );
    return QueryResult(data: result.data, exception: result.exception);
  }

  @override
  Future<QueryResult> mutate(QueryOptions options) async {
    final result = await _client.mutate(
      gclient.MutationOptions(
        document: gclient.gql(options.query),
        operationName: options.operationName,
        variables: options.variables,
        fetchPolicy: gclient.FetchPolicy.noCache,
      ),
    );
    return QueryResult(data: result.data, exception: result.exception);
  }
}
