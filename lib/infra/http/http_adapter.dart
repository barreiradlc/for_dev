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

    var response = Response('', 500);

    try {
      if (method == 'post') {
        response = await client.post(url, headers: headers, body: jsonBody);
      }
    } catch (e) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }
    if (response.statusCode == 204) {
      return null;
    }
    if (response.statusCode == 400) {
      throw HttpError.badRequest;
    }
    if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    }
    if (response.statusCode == 403) {
      throw HttpError.forbbiden;
    }
    if (response.statusCode == 404) {
      throw HttpError.notFound;
    }
    if (response.statusCode == 500) {
      throw HttpError.serverError;
    }
    throw HttpError.serverError;
  }
}
