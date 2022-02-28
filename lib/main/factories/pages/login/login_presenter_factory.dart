
import 'package:for_dev/main/factories/pages/login/login_validation_factory.dart';
import 'package:for_dev/main/factories/usecases/authentication_factory.dart';
import 'package:for_dev/presentation/presenters/stream_login_presenter.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
  );  
}