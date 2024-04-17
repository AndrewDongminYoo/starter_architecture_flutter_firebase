part of 'alert_dialogs.dart';

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(dynamic exception) {
  if (exception is FirebaseException) {
    return exception.message ?? exception.toString();
  }
  if (exception is PlatformException) {
    return exception.message ?? exception.toString();
  }
  return exception.toString();
}

// NOTE: FirebaseAuth 오류의 전체 목록은 여기에 저장되어 있습니다:
// https://github.com/firebase/firebase-ios-sdk/blob/2e77efd786e4895d50c3788371ec15980c729053/Firebase/Auth/Source/FIRAuthErrorUtils.m
// 이메일 및 비밀번호 로그인과 가장 관련성이 높은 기능입니다:
Map<String, String> errors = {
  'ERROR_WEAK_PASSWORD': '비밀번호는 6자 이상이어야 합니다.',
  'ERROR_INVALID_CREDENTIAL': '제공한 인증 자격 증명이 잘못되었거나 만료되었습니다.',
  'ERROR_EMAIL_ALREADY_IN_USE': '이메일 주소가 다른 계정에서 이미 사용 중입니다.',
  'ERROR_INVALID_EMAIL': '이메일 주소의 형식이 잘못되었습니다.',
  'ERROR_WRONG_PASSWORD': '비밀번호가 유효하지 않거나 사용자에게 비밀번호가 없습니다.',
  'ERROR_USER_NOT_FOUND': '이 식별자에 해당하는 사용자 레코드가 없습니다.',
  'ERROR_TOO_MANY_REQUESTS': '비정상적인 활동으로 인해 이 장치의 모든 요청을 차단했습니다.',
  'ERROR_OPERATION_NOT_ALLOWED':
      '지정된 로그인 공급자가 이 Firebase 프로젝트에 대해 비활성화되어 있습니다.',

  'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
      '이메일 주소는 같지만 로그인 자격 증명이 다른 계정이 이미 존재합니다.',
  'ERROR_APP_NOT_AUTHORIZED': '이 앱은 제공된 API 키로 Firebase 인증을 사용할 수 있는 권한이 없습니다.',
  'ERROR_APP_NOT_VERIFIED': 'Firebase가 무음 푸시 알림을 검색할 수 없어 앱을 인증할 수 없습니다.',
  'ERROR_APP_VERIFICATION_USER_INTERACTION_FAILURE':
      '앱 인증 프로세스가 실패했습니다. 자세한 내용은 오류 세부 정보를 인쇄하고 검사하십시오.',
  'ERROR_CAPTCHA_CHECK_FAILED':
      '제공된 reCAPTCHA 응답 토큰이 유효하지 않거나 만료되었거나 이미 만료되었습니다.',
  'ERROR_CREDENTIAL_ALREADY_IN_USE': '이 자격 증명이 이미 다른 사용자 계정과 연결되어 있습니다.',
  'ERROR_CUSTOM_TOKEN_MISMATCH': '사용자 지정 토큰이 다른 대상에 해당합니다.',
  'ERROR_EXPIRED_ACTION_CODE': '액션 코드가 만료되었습니다.',
  'ERROR_GAME_KIT_NOT_LINKED': 'GameKit 프레임워크가 연결되지 않았습니다.',
  'ERROR_INTERNAL_ERROR': '내부 오류가 발생했습니다. 자세한 내용은 오류 세부 정보를 인쇄하여 확인하세요.',
  'ERROR_INVALID_ACTION_CODE': '액션 코드가 유효하지 않습니다.',
  'ERROR_INVALID_API_KEY': '요청에 잘못된 API 키가 제공되었습니다.',
  'ERROR_INVALID_APP_CREDENTIAL':
      '제공된 APNs 장치 토큰이 올바르지 않거나 Firebase 콘솔에 업로드한 비공개 인증서와 일치하지 않습니다.',
  'ERROR_INVALID_CLIENT_ID':
      '제공된 OAuth 클라이언트 ID가 유효하지 않거나 지정된 API 키와 일치하지 않습니다.',
  'ERROR_INVALID_CONTINUE_URI': '요청에 제공된 계속 URL이 유효하지 않습니다.',
  'ERROR_INVALID_CUSTOM_TOKEN': '사용자 지정 토큰 형식이 올바르지 않습니다.',
  'ERROR_INVALID_DYNAMIC_LINK_DOMAIN':
      '사용된 Firebase 동적 링크 도메인이 구성되어 있지 않거나 현재 프로젝트에 대해 권한이 없습니다.',
  'ERROR_INVALID_MESSAGE_PAYLOAD': '액션 코드가 유효하지 않습니다.',
  'ERROR_INVALID_PHONE_NUMBER': '제공된 전화 번호의 형식이 올바르지 않습니다.',
  'ERROR_INVALID_RECIPIENT_EMAIL': '작업 코드가 유효하지 않습니다.',
  'ERROR_INVALID_SENDER': '이 작업에 해당하는 이메일 템플릿에 메시지에 잘못된 문자가 포함되어 있습니다.',
  'ERROR_INVALID_USER_TOKEN': '이 사용자의 자격 증명이 이 프로젝트에 유효하지 않습니다.',
  'ERROR_INVALID_VERIFICATION_CODE':
      '전화 인증 자격 증명을 만드는 데 사용된 SMS 인증 코드가 유효하지 않습니다.',
  'ERROR_INVALID_VERIFICATION_ID': '휴대폰 인증 자격 증명을 만드는 데 사용된 인증 ID가 유효하지 않습니다.',
  'ERROR_KEYCHAIN_ERROR': '키 체인에 액세스할 때 오류가 발생했습니다.',
  'ERROR_LOCAL_PLAYER_NOT_AUTHENTICATED': '로컬 플레이어가 인증되지 않았습니다.',
  'ERROR_MALFORMED_JWT': 'JWT를 구문 분석하지 못했습니다.',
  'ERROR_MISSING_ANDROID_PACKAGE_NAME':
      'Android 앱을 설치해야 하는 경우 Android 패키지 이름을 제공해야 합니다.',
  'ERROR_MISSING_APP_CREDENTIAL': '휴대폰 인증 요청에 APNs 디바이스 토큰이 누락되었습니다.',
  'ERROR_MISSING_APP_TOKEN':
      '프로젝트의 Firebase 전화 번호 인증 설정에 문제가 있는 것 같습니다. https://firebase.google.com/docs/auth/ios/phone-auth 에 있는 지침을 따르세요.',
  'ERROR_MISSING_CONTINUE_URI': '요청에 계속 URL을 제공해야 합니다.',
  'ERROR_MISSING_EMAIL': '이메일 주소를 제공해야 합니다.',
  'ERROR_MISSING_IOS_BUNDLE_ID': '앱 스토어 ID가 제공된 경우 iOS 번들 ID를 제공해야 합니다.',
  'ERROR_MISSING_PHONE_NUMBER': '인증 코드를 보내려면 수신자의 휴대폰 번호를 입력합니다.',
  'ERROR_MISSING_VERIFICATION_CODE': '휴대폰 인증 자격 증명이 빈 SMS 인증 코드로 생성되었습니다.',
  'ERROR_MISSING_VERIFICATION_ID': '휴대폰 인증 자격 증명이 빈 인증 ID로 생성되었습니다.',
  'ERROR_NETWORK_ERROR': '네트워크 오류(예: 시간 초과, 연결 중단 또는 연결할 수 없는 호스트)가 발생했습니다.',
  'ERROR_NO_SUCH_PROVIDER': '사용자가 지정된 공급업체의 계정에 연결되지 않았습니다.',
  'ERROR_NOTIFICATION_NOT_FORWARDED':
      '앱 델리게이트 스위즐링이 비활성화되어 있는 경우, UIApplicationDelegate가 수신한 원격 알림을 FIRAuth의 canHandleNotification: 메서드로 전달해야 합니다.',
  'ERROR_NULL_USER': '널이 아닌 사용자 객체가 필요한 연산에 대한 인수로 널 사용자 객체가 제공되었습니다.',
  'ERROR_PROVIDER_ALREADY_LINKED':
      '[ERROR_PROVIDER_ALREADY_LINKED] - 사용자는 지정된 공급자에 대해 하나의 ID에만 연결할 수 있습니다.',
  'ERROR_QUOTA_EXCEEDED': '이 프로젝트의 전화 인증 할당량이 초과되었습니다.',
  'ERROR_SESSION_EXPIRED': 'SMS 코드가 만료되었습니다.',
  'ERROR_UNAUTHORIZED_DOMAIN': '계속 URL의 도메인이 화이트리스트에 등록되지 않았습니다.',
  'ERROR_USER_DISABLED': '관리자가 사용자 계정을 비활성화했습니다.',
  'ERROR_USER_MISMATCH': '제공된 자격 증명이 이전에 로그인한 사용자와 일치하지 않습니다.',
  'ERROR_USER_TOKEN_EXPIRED': "The user's credential is no longer valid",
  'ERROR_WEB_CONTEXT_ALREADY_PRESENTED':
      '사용자 상호 작용이 아직 진행 중이므로 다른 보기를 표시할 수 없습니다.',
  'ERROR_WEB_CONTEXT_CANCELLED': '사용자가 상호작용을 취소했습니다.',
  'ERROR_WEB_INTERNAL_ERROR':
      'SFSafariViewController 또는 UIWebView 내에서 내부 오류가 발생했습니다.',
  'ERROR_WEB_REQUEST_FAILED':
      '웹 컨텍스트 내에서 네트워크 오류(예: 시간 초과, 연결 중단 또는 연결할 수 없는 호스트)가 발생했습니다.',
};
