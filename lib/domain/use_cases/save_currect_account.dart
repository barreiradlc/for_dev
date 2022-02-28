import 'package:for_dev/domain/entities/account_entity.dart';

abstract class SaveCurrectAccount{
  Future<void> save(AccountEntity account);
}