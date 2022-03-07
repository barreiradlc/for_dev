import 'package:faker/faker.dart';
import 'package:for_dev/data/usecases/add_account/remote_add_account.dart';
import 'package:for_dev/domain/use_cases/add_account.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:for_dev/domain/helpers/domain_error.dart';

import 'package:for_dev/data/http/http_error.dart';
import 'package:for_dev/data/usecases/authentication/remote_authentication.dart';
import 'package:for_dev/data/http/http_client.dart';

class HttpClientSpy extends Mock implements HttpClient {}

main() {
  late HttpClientSpy httpClient;
  late String url;
  late RemoteAddAccount sut;
  late AddAccountParams params;

  When mockRequest() => when(() => httpClient.request(url: url, method: 'post', body: any(named: 'body')));

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(httpClient: httpClient, url: url);

    params = AddAccountParams(
      name: faker.person.name(), 
      email: faker.internet.email(), 
      password: faker.internet.password(),
      passwordConfirmation: faker.internet.password()
    );
  });  

  test('Should Call HTTP Client with the correct Values', () async {    
    await sut.add(params);

    verify(() => httpClient.request(url: url, method: 'post', body: {
      'name': params.name, 
      'email': params.email, 
      'password': params.password,
      'passwordConfirmation': params.passwordConfirmation
    }));
  });
  
  test('Should throw unexpectedError if httpClient return 400', () async {    
    mockHttpError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  
  test('Should throw unexpectedError if httpClient return 404', () async {    
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  
}
