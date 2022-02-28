import 'package:for_dev/data/usecases/save_current_account/local_save_current_account.dart';
import 'package:for_dev/domain/use_cases/save_currect_account.dart';
import 'package:for_dev/main/factories/cache/local_storage_adapter_factory.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() {
  return LocalSaveCurrentAccount(
    saveSecureCacheStorage: makeLocalStorageAdapter()
  );
}