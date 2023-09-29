import 'package:flutter/material.dart';

@immutable
abstract class EBooState {}

class GetEBooSuccess implements EBooState {
  final String message;
  const GetEBooSuccess({this.message = "Fetch data success"});
}

class GetEBooFailed implements EBooState {
  final Object? error;
  final String? message;
  const GetEBooFailed({this.error, this.message});

  @override
  String toString() =>
      "FetchDataFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}
