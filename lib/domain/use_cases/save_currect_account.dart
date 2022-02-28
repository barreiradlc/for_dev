import 'package:for_dev/domain/entities/account_entity.dart';

abstract class SaveCurrentAccount{
  Future<void>? save(AccountEntity account);
}