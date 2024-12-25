class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_message $_prefix";
  }
}

class NetworkError extends AppException {
  NetworkError([String? super.message]);
}

class TimeoutException extends AppException {
  TimeoutException([String? super.message]);
}

class FirebaseAuthException extends AppException {
  FirebaseAuthException([String? super.message]);
}
