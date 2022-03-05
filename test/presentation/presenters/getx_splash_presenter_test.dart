import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/use_cases/load_currect_account.dart';
import 'package:for_dev/presentation/presenters/getx_splash_presenter.dart';

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
    await sut.checkAccount(durationsInSeconds: 0);

    verify(() => loadCurrentAccount.load()).called(1);
  });
  
  test('Should got to surveys page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount(durationsInSeconds: 0);
  });
  
  test('Should got to login on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationsInSeconds: 0);
  });
  
  test('Should got to login on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationsInSeconds: 0);
  });

}