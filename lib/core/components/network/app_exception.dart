// ignore_for_file: non_constant_identifier_names

class AppException implements Exception {
  final String message;
  final int? code;
  final int? s;
  AppException({required this.message, this.code, this.s});
}

