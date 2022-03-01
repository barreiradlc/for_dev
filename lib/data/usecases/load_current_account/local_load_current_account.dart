
import 'package:for_dev/data/cache/fetch_secure_cache_storage.dart';
import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/load_currect_account.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({ required this.fetchSecureCacheStorage });

  Future<AccountEntity> load() async{
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token!);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}


