import 'package:for_dev/data/http/http_client.dart';
import 'package:for_dev/data/http/http_error.dart';

import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';

class RemoteAuthetication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthetication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = RemoteAutheticationParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}

class RemoteAutheticationParams {
  final String email;
  final String password;

  RemoteAutheticationParams({required this.email, required this.password});

  factory RemoteAutheticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAutheticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
