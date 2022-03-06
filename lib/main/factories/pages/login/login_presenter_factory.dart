import 'package:for_dev/main/factories/pages/login/login_validation_factory.dart';
import 'package:for_dev/main/factories/usecases/authentication_factory.dart';
import 'package:for_dev/main/factories/usecases/save_current_account_factory.dart';
import 'package:for_dev/presentation/presenters/getx_login_presenter.dart';
import 'package:for_dev/presentation/presenters/stream_login_presenter.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';

LoginPresenter makeStremLoginPresenter() {
  return StreamLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
  );
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}
