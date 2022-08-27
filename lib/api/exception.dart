

class AppException implements Exception {
  String? code;
  String? message;
  String? details;

  AppException({ this.code,  this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String details) : super(
    code: "Fetch-Data",
    message: "Error during communication",
    details: details
  );
}

class InvalideInputException extends AppException {
  InvalideInputException(String details) : super(
    code: "Invalid-Input",
    message: "Invalid input provided",
    details: details
  );
}
class BadRequestException extends AppException {
  BadRequestException(String details) : super(
    code: "Bad-Request",
    message: "Bad request to the server",
    details: details
  );
}
class UnauthorisedException extends AppException {
  UnauthorisedException(String details) : super(
    code: "Unauthorised",
    message: "Unauthorised request or invalid credentials",
    details: details
  );
}
class AuthenticationException extends AppException {
  AuthenticationException(String details) : super(
    code: "Auth-failed",
    message: "Authentication failed or expired",
    details: details
  );
}
class TimeoutExceptionx extends AppException {
  TimeoutExceptionx(String details) : super(
    code: "Timeout",
    message: "Timeout exception occured",
    details: details
  );
}


