import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:for_dev/data/usecases/load_current_account/local_load_current_account.dart';
import 'package:for_dev/data/cache/fetch_secure_cache_storage.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/entities/account_entity.dart';

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage{}

main() {
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  When mockFetchSecureCall() => when(() => fetchSecureCacheStorage.fetchSecure('token'));

  void mockFetchSecure() {
    mockFetchSecureCall().thenAnswer((_) async => token);
  }
  
  void mockFetchSecureError() {
    mockFetchSecureCall().thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(() => fetchSecureCacheStorage.fetchSecure('token'));
  });
  
  test('Should return an AccountEntity ', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });
  
  test('Should throws if FetchSecureCacheStorage throws', () async {

    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });


}