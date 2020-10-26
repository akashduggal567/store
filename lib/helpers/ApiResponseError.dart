// To parse this JSON data, do
//
//     final apiResponseError = apiResponseErrorFromJson(jsonString);

import 'dart:convert';

ApiResponseError apiResponseErrorFromJson(String str) => ApiResponseError.fromJson(json.decode(str));

String apiResponseErrorToJson(ApiResponseError data) => json.encode(data.toJson());

class ApiResponseError {
  ApiResponseError({
    this.status,
    this.requestId,
    this.exception,
  });

  String status;
  String requestId;
  Exception exception;

  factory ApiResponseError.fromJson(Map<String, dynamic> json) => ApiResponseError(
    status: json["status"] == null ? null : json["status"],
    requestId: json["requestId"] == null ? null : json["requestId"],
    exception: json["exception"] == null ? null : Exception.fromJson(json["exception"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "requestId": requestId == null ? null : requestId,
    "exception": exception == null ? null : exception.toJson(),
  };
}

class Exception {
  Exception({
    this.error,
  });

  Error error;

  factory Exception.fromJson(Map<String, dynamic> json) => Exception(
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error.toJson(),
  };
}

class Error {
  Error({
    this.code,
    this.description,
    this.message,
    this.extras,
  });

  int code;
  String description;
  String message;
  String extras;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"] == null ? null : json["code"],
    description: json["description"] == null ? null : json["description"],
    message: json["message"] == null ? null : json["message"],
    extras: json["extras"] == null ? null : json["extras"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "description": description == null ? null : description,
    "message": message == null ? null : message,
    "extras": extras == null ? null : extras,
  };
}
