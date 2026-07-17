import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

class InterceptorLink extends HttpLink {
  final String graphQLBaseUrl;
  final void Function(http.Response response)? responseInterceptor;

  InterceptorLink({required this.graphQLBaseUrl, this.responseInterceptor})
    : super(
        graphQLBaseUrl,
        httpResponseDecoder: (response) {
          final Map<String, dynamic>? result =
              json.decode(utf8.decode(response.bodyBytes))
                  as Map<String, dynamic>?;

          responseInterceptor?.call(response);

          return result;
        },
      );
}
