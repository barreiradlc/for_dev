import 'package:faker/faker.dart';
import 'package:for_dev/domain/entities/account_entity.dart';
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
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account == null ? '/login' : '/surveys';
    } catch (e) {
      _navigateTo.value = '/login';
    }
  }  

}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

main() {
    late GetxSplashPresenter sut;
    late LoadCurrentAccountSpy loadCurrentAccount;

  When loadCurrentAccountCall() {
    return when(() => loadCurrentAccount.load());
  }

  void mockLoadCurrentAccount({ AccountEntity? account }){
    loadCurrentAccountCall().thenAnswer((_) async => account);
  }
  
  void mockLoadCurrentAccountError(){
    loadCurrentAccountCall().thenThrow(Exception());
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount:loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(() => loadCurrentAccount.load()).called(1);
  });
  
  test('Should got to surveys page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });
  
  test('Should got to login on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
  
  test('Should got to login on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

}