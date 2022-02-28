import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/save_currect_account.dart';

class LocalSaveCurrentAccount implements SaveCurrectAccount {
  late SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({ required this.saveSecureCacheStorage });

  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void>? saveSecure({ required String key, required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

main() {
  late SaveSecureCacheStorageSpy saveSecureCacheStorage;
  late LocalSaveCurrentAccount sut;
  late AccountEntity account;

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });
  
  test('Should saveSecure cache storage with correct values', () async {
    await sut.save(account);

    verify(() => saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });
  
  test('Should throws Unexpected if cache storage throws', () async {    
    when(() => saveSecureCacheStorage.saveSecure(key: any(named: 'key'), value: any(named: 'value')))
      .thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });

}
