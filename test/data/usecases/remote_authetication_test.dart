import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteAuthetication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthetication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void>? request({required String url, String method = "get"});
}

class HttpClientSpy extends Mock implements HttpClient {}

main() {
  test('Should Call HTTP Client with the correct Values', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthetication(httpClient: httpClient, url: url);

    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
