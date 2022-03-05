
import 'package:for_dev/main/factories/usecases/load_current_account_factory.dart';
import 'package:for_dev/presentation/presenters/getx_splash_presenter.dart';
import 'package:for_dev/ui/pages/splash/splash_presenter.dart';

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter(
    loadCurrentAccount: makeLocalLoadCurrentAccount()
  );  
}