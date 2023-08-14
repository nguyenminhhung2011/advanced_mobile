import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String userName,
    required String password,
    String? email,
    String? phoneNumber,
    String? creditCardNumber,
    String? photoUrl,
    String? bio,
  }) = _User;
}
