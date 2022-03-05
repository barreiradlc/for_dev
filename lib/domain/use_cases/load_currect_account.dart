import 'package:for_dev/domain/entities/account_entity.dart';

abstract class LoadCurrentAccount{
  Future<AccountEntity?>? load();
}