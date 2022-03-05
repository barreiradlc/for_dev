import 'package:for_dev/data/usecases/load_current_account/local_load_current_account.dart';
import 'package:for_dev/domain/use_cases/load_currect_account.dart';
import 'package:for_dev/main/factories/cache/local_storage_adapter_factory.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
    fetchSecureCacheStorage: makeLocalStorageAdapter()
  );
}