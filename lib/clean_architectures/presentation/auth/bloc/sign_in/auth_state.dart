import 'package:flutter/material.dart';

class Credential {
  final String email;
  final String password;

  const Credential({required this.email, required this.password});
}

@immutable

///[Can not change after init]
abstract class AuthState {}

class SignInSuccessMessage implements AuthState {
  const SignInSuccessMessage();
}

class SignInErrorMessage implements AuthState {
  final Object? error;
  final String? message;
  const SignInErrorMessage({this.error, this.message});

  @override
  String toString() =>
      "SignInErrorMessage => {message=${message ?? ''}, error=${error ?? ''}}";
}

class InvalidFormatMessage implements AuthState {
  const InvalidFormatMessage();
}
