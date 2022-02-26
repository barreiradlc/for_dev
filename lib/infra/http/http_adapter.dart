import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:for_dev/data/http/http_error.dart';

import 'package:for_dev/data/http/http_client.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({@required String url, @required String method, Map body}) async {
    final headers = {'content-type': 'application/json', 'accept': 'application/json'};
    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(url, headers: headers, body: jsonBody);

    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    if (response.statusCode == 204) {
      return null;
    }
    if (response.statusCode == 400) {
      throw HttpError.badRequest;
    }
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}
