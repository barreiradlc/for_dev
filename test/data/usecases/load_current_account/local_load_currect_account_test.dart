import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:for_dev/domain/use_cases/load_currect_account.dart';
import 'package:for_dev/domain/entities/account_entity.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({ required this.fetchSecureCacheStorage });

  Future<AccountEntity> load() async{
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    return AccountEntity(token);
  }
}

abstract class FetchSecureCacheStorage{
  Future<String> fetchSecure(String key);
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage{}

main() {
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(() => fetchSecureCacheStorage.fetchSecure('token'));
  });
  
  test('Should return an AccountEntity ', () async {
    final token = faker.guid.guid();
    when(() => fetchSecureCacheStorage.fetchSecure('token')).thenAnswer((_) async => token);
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });
}