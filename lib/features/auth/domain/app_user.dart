// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// Firebase에서 사용자 ID를 정의하는 타입입니다.
typedef UserID = String;

/// 사용자 UID 및 이메일을 나타내는 간단한 클래스입니다.
@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required final String uid,
    required final String email,
  }) = _AppUser;
}
