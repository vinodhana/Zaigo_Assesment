class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message]) : super(message, "Forbidden exception: ");
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, "NotFound exception: ");
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message]) : super(message, "InternalServer exception: ");
}
