abstract class HttpClient {
  Future<Map>? request({required String url, String method = "get", Map body});
}
