import 'package:for_dev/data/http/http_client.dart';
import 'package:for_dev/data/http/http_error.dart';

import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/add_account.dart';

class RemoteAddAccount  {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({required this.httpClient, required this.url});

  Future<AccountEntity?>? add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final response = await httpClient.request(url: url, method: 'post', body: body);
      return response;  
    } on HttpError catch(e) {
      if(e == HttpError.forbbiden) {
        throw DomainError.emailInUse;
      }
      throw DomainError.unexpected;
    }    
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({
    required this.name, 
    required this.email, 
    required this.password,
    required this.passwordConfirmation
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) =>
      RemoteAddAccountParams(
        name: params.name, 
        email: params.email, 
        password: params.password,
        passwordConfirmation: params.passwordConfirmation,
      );

  Map toJson() => {
    'name': name, 
    'email': email, 
    'password': password,
    'passwordConfirmation': passwordConfirmation,
  };
}
