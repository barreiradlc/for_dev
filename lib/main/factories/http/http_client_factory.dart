import 'package:http/http.dart';

import 'package:for_dev/data/http/http_client.dart';

import 'package:for_dev/infra/http/http_adapter.dart';


HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}