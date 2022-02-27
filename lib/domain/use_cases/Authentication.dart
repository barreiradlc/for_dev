import 'package:equatable/equatable.dart';
import 'package:for_dev/domain/entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity>? auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;

  @override
  List<Object> get props => [email, secret];

  AuthenticationParams({required this.email, required this.secret});
}
