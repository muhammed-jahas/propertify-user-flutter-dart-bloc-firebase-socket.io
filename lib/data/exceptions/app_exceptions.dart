class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class InternetException extends AppException {
  InternetException() : super('No Internet connection');
}

class RequestTimeOUtException extends AppException {
  RequestTimeOUtException() : super('Request time out');
}

class BadRequestException extends AppException {
  BadRequestException() : super('Something went wrong');
}
