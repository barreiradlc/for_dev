enum DomainError { unexpected, invalidCredentials }

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this) {
      case DomainError.invalidCredentials: return 'Credenciais inválidas';
      case DomainError.unexpected: return 'Algo deu errado, tente novamente em segundos';
      default: return '';
    }
  }
}