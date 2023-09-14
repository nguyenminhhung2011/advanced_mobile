import 'package:flutter/material.dart';

@immutable
abstract class RegisterState {}

class RegisterSuccess implements RegisterState {
  final String message;
  RegisterSuccess({this.message = "Register success"});
}

class RegisterError implements RegisterState {
  final Object? error;
  final String message;
  RegisterError(this.error, {this.message = "Register error"});
}

class InvalidFormatMessage implements RegisterState {
  final String? message;
  const InvalidFormatMessage({this.message});
}
