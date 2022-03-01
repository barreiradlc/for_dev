import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalLoadCurrentAccount {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({ required this.fetchSecureCacheStorage });

  Future<void>? load() async{
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

abstract class FetchSecureCacheStorage{
  Future<void>? fetchSecure(String key);
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage{}

main() {
  test('Should call FetchSecureCacheStorage with correct value', () async {
    final fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    final sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);

    await sut.load();

    verify(() => fetchSecureCacheStorage.fetchSecure('token'));
  });
}