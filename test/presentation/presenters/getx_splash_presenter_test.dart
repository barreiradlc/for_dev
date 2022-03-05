import 'package:for_dev/domain/use_cases/load_currect_account.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:for_dev/ui/pages/splash/splash_presenter.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount; 
  var _navigateTo = RxString('');

  Stream<String> get navigateToStream => _navigateTo.stream;

  GetxSplashPresenter({ required this.loadCurrentAccount });

  @override
  Future<void>? checkAccount() async {
    await loadCurrentAccount.load();
  }  

}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();
    final sut = GetxSplashPresenter(loadCurrentAccount:loadCurrentAccount);

    await sut.checkAccount();

    verify(() => loadCurrentAccount.load()).called(1);
  });
}