import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:for_dev/infra/cache/local_storage_adapter.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

main() {
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter sut;
  late String key;
  late String value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('saveSecure', () {
    test('Should call save secure with the correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(() => secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () async {
        when(() => secureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenThrow(Exception());

        final future = sut.saveSecure(key: key, value: value);

        expect(future, throwsA(TypeMatcher<Exception>()));
      });
  });


  group('fetchSecure', () {
    When mockFetchSecureCall() => when(() => secureStorage.read(key: any(named: 'key')));
    
    mockFetchSecure() {
      mockFetchSecureCall().thenAnswer((_) async => value);
    }
    
    mockFetchSecureError() {
      mockFetchSecureCall().thenThrow(Exception());
    }

    setUp(() {
      mockFetchSecure();
    });

    test('Should call fetch secure with correct value', () async {
      await sut.fetchSecure(key);

      verify(() => secureStorage.read(key: key));
    });
    
    test('Should call correct value on succeess', () async {
      final fetchedValue = await sut.fetchSecure(key);

      expect(fetchedValue, value);
    });
    
    test('Should throw on error', () async {
      mockFetchSecureError();

      final future = sut.fetchSecure(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });

  });

}