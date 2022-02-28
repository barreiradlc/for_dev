import 'package:for_dev/data/cache/save_secure_cache_storage.dart';
import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/save_currect_account.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  late SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({ required this.saveSecureCacheStorage });

  Future<void>? save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}