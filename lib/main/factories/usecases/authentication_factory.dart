import 'package:for_dev/data/usecases/authentication/remote_authentication.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';
import 'package:for_dev/main/factories/http/api_url_factory.dart';
import 'package:for_dev/main/factories/http/http_client_factory.dart';


Authentication makeRemoteAuthentication() {
  return RemoteAuthetication(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('login')
  );
}