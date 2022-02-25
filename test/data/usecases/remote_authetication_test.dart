import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev/domain/use_cases/authentication.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';

import 'package:for_dev/data/http/http_error.dart';
import 'package:for_dev/data/usecases/remote_authentication.dart';
import 'package:for_dev/data/http/http_client.dart';

class HttpClientSpy extends Mock implements HttpClient {}

main() {
  final httpClient = HttpClientSpy();
  final url = faker.internet.httpUrl();
  final sut = RemoteAuthetication(httpClient: httpClient, url: url);
  final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());

  test('Should Call HTTP Client with the correct Values', () async {
    final body = RemoteAutheticationParams.fromDomain(params).toJson();

    when(httpClient.request(url: url, method: 'post', body: body))
        .thenAnswer((_) async => {'accessToken': faker.guid.guid(), 'name': faker.person.name()});

    await sut.auth(params);

    verify(httpClient.request(url: url, method: 'post', body: {'email': params.email, 'password': params.secret}));
  });

  test('Should Throws an error when HttpClient returns 400', () async {
    final anyBody = RemoteAutheticationParams.fromDomain(params).toJson();

    when(httpClient.request(url: url, method: 'post', body: anyBody)).thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should Throws an error when HttpClient returns 404', () async {
    final anyBody = RemoteAutheticationParams.fromDomain(params).toJson();

    when(httpClient.request(url: url, method: 'post', body: anyBody)).thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should Throws an error when HttpClient returns 500', () async {
    final anyBody = RemoteAutheticationParams.fromDomain(params).toJson();

    when(httpClient.request(url: url, method: 'post', body: anyBody)).thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should Throws InvalidCredentailsError when HttpClient returns 401', () async {
    final anyBody = RemoteAutheticationParams.fromDomain(params).toJson();

    when(httpClient.request(url: url, method: 'post', body: anyBody)).thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });
  test('Should return an Account when HttpClient returns 200', () async {
    final anyBody = RemoteAutheticationParams.fromDomain(params).toJson();
    final acessToken = faker.guid.guid();

    when(httpClient.request(url: url, method: 'post', body: anyBody))
        .thenAnswer((_) async => {'accessToken': acessToken, 'name': faker.person.name()});

    final account = await sut.auth(params);

    expect(account.token, acessToken);
  });
}
