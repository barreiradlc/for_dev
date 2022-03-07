import 'package:equatable/equatable.dart';
import 'package:for_dev/domain/entities/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity?>? add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  @override
  List<Object> get props => [name, email, password, passwordConfirmation];

  AddAccountParams({
    required this.name, 
    required this.email,
    required this.password, 
    required this.passwordConfirmation, 
  });
}
