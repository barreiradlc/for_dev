import 'package:for_dev/domain/use_cases/load_currect_account.dart';
import 'package:for_dev/ui/pages/splash/splash_presenter.dart';
import 'package:get/get.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount; 
  var _navigateTo = RxString('');

  Stream<String> get navigateToStream => _navigateTo.stream;

  GetxSplashPresenter({ required this.loadCurrentAccount });

  @override
  Future<void>? checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account == null ? '/login' : '/surveys';
    } catch (e) {
      _navigateTo.value = '/login';
    }
  }  

}
