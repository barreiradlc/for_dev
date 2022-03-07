enum DomainError { unexpected, invalidCredentials, emailInUse }

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this) {
      case DomainError.invalidCredentials: return 'Credenciais inválidas';
      case DomainError.unexpected: return 'Algo deu errado, tente novamente em segundos';
      case DomainError.emailInUse: return 'Email em uso';
      default: return '';
    }
  }
}