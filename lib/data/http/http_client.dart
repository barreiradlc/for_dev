abstract class HttpClient {
  Future<void>? request({required String url, String method = "get", Map body});
}
