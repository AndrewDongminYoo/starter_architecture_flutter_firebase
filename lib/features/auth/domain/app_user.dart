// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// Type defining a user ID from Firebase.
typedef UserID = String;

/// Simple class representing the user UID and email.
@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required final String uid,
    required final String email,
  }) = _AppUser;
}
