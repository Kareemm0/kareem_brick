class QueryResult {
  Map<String, dynamic>? data;
  Exception? exception;
  QueryResult({this.data, this.exception});
  bool get hasException => exception != null;
}