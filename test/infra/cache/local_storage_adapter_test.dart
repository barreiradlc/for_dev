import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:for_dev/data/cache/save_secure_cache_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({ required this.secureStorage });

  Future<void>? saveSecure({ required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

main() {
  
  test('Should call save secure with the correct values', () async {
    final secureStorage = FlutterSecureStorageSpy();
    final sut = LocalStorageAdapter(secureStorage: secureStorage);
    final key = faker.lorem.word();
    final value = faker.guid.guid();

    await sut.saveSecure(key: key, value: value);

    verify(() => secureStorage.write(key: key, value: value));
  });

}