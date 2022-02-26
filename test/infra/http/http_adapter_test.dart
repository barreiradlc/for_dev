import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev/data/http/http_error.dart';

import 'package:for_dev/infra/http/http_adapter.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    PostExpectation mockRequest() => when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode, {body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call the post method with the correct values', () async {
      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(url, headers: {'content-type': 'application/json', 'accept': 'application/json'}, body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('Should return data if the result is 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null data if the result is 200 without response', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('Should return null if post return 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('Should return null if post return 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('Should return badRequestError if post return 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });
    test('Should return badRequestError if post return 400 without body', () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });
    test('Should return unauthorizedError if post return 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });
    test('Should return forbidden if post return 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbbiden));
    });
    test('Should return notFound if post return 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });
    test('Should return serverError if post return 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
