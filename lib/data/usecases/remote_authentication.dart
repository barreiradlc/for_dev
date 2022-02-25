import 'package:for_dev/data/http/http_client.dart';
import 'package:for_dev/data/http/http_error.dart';

import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';

class RemoteAuthetication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthetication({required this.httpClient, required this.url});

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAutheticationParams.fromDomain(params).toJson();
    try {
      // TODO, extrair lógica de retorno de Map vazio
      final response = await httpClient.request(url: url, method: 'post', body: body) ?? {};
      return AccountEntity.fromJson(response);
    } on HttpError catch (error) {
      print(error);
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
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
