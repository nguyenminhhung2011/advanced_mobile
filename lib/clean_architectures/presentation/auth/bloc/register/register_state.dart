import 'package:flutter/material.dart';

class CredentialState {
  final String email;
  final String password;

  const CredentialState({required this.email, required this.password});
}

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

class InvalidFormatRegisterMessage implements RegisterState {
  final String? message;
  const InvalidFormatRegisterMessage({this.message});
}
