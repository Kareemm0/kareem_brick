class QueryOptions {
  final String query;
  final String? operationName;
  final Map<String, dynamic> variables;

  QueryOptions({
    required this.query,
    this.operationName,
    this.variables = const {},
  });
}
