import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:for_dev/data/usecases/save_current_account/local_save_current_account.dart';
import 'package:for_dev/data/cache/save_secure_cache_storage.dart';
import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';

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
