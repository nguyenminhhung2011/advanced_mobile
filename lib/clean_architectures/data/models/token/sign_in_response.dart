import 'package:flutter_base_clean_architecture/clean_architectures/data/models/token/token_model.dart';

class SignInResponse {
  final TokenModel token;
  SignInResponse(this.token);

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
      TokenModel.fromJson(json['tokens'] as Map<String, dynamic>));
}
