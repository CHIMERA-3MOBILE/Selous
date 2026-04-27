/// Base exception class for SELous
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;
  
  const AppException(this.message, {this.code, this.stackTrace});
  
  @override
  String toString() => '[$code] $message';
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code ?? 'NETWORK_ERROR', stackTrace: stackTrace);
}

/// Connection-specific exceptions
class ConnectionException extends NetworkException {
  const ConnectionException(String message, {StackTrace? stackTrace})
      : super(message, code: 'CONNECTION_ERROR', stackTrace: stackTrace);
}

/// Timeout exceptions
class TimeoutException extends NetworkException {
  const TimeoutException(String message, {StackTrace? stackTrace})
      : super(message, code: 'TIMEOUT_ERROR', stackTrace: stackTrace);
}

/// Encryption-related exceptions
class EncryptionException extends AppException {
  const EncryptionException(String message, {StackTrace? stackTrace})
      : super(message, code: 'ENCRYPTION_ERROR', stackTrace: stackTrace);
}

/// Decryption failures
class DecryptionException extends EncryptionException {
  const DecryptionException(String message, {StackTrace? stackTrace})
      : super(message, stackTrace: stackTrace);
}

/// Key management errors
class KeyException extends EncryptionException {
  const KeyException(String message, {StackTrace? stackTrace})
      : super(message, stackTrace: stackTrace);
}

/// Storage-related exceptions
class StorageException extends AppException {
  const StorageException(String message, {StackTrace? stackTrace})
      : super(message, code: 'STORAGE_ERROR', stackTrace: stackTrace);
}

/// Validation errors
class ValidationException extends AppException {
  const ValidationException(String message, {StackTrace? stackTrace})
      : super(message, code: 'VALIDATION_ERROR', stackTrace: stackTrace);
}

/// Permission denied
class PermissionException extends AppException {
  const PermissionException(String message, {StackTrace? stackTrace})
      : super(message, code: 'PERMISSION_DENIED', stackTrace: stackTrace);
}

/// Not found
class NotFoundException extends AppException {
  const NotFoundException(String message, {StackTrace? stackTrace})
      : super(message, code: 'NOT_FOUND', stackTrace: stackTrace);
}

/// Unexpected errors
class UnexpectedException extends AppException {
  const UnexpectedException(String message, {StackTrace? stackTrace})
      : super(message, code: 'UNEXPECTED_ERROR', stackTrace: stackTrace);
}
