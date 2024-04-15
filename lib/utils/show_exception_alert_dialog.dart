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

// NOTE: The full list of FirebaseAuth errors is stored here:
// https://github.com/firebase/firebase-ios-sdk/blob/2e77efd786e4895d50c3788371ec15980c729053/Firebase/Auth/Source/FIRAuthErrorUtils.m
// These are just the most relevant for email & password sign in:
Map<String, String> errors = {
  'ERROR_WEAK_PASSWORD': 'The password must be 6 characters long or more.',
  'ERROR_INVALID_CREDENTIAL': 'The supplied auth credential is malformed or has expired.',
  'ERROR_EMAIL_ALREADY_IN_USE': 'The email address is already in use by another account.',
  'ERROR_INVALID_EMAIL': 'The email address is badly formatted.',
  'ERROR_WRONG_PASSWORD': 'The password is invalid or the user does not have a password.',
  'ERROR_USER_NOT_FOUND': 'There is no user record corresponding to this identifier',
  'ERROR_TOO_MANY_REQUESTS': 'We have blocked all requests from this device due to unusual activity',
  'ERROR_OPERATION_NOT_ALLOWED': 'The given sign-in provider is disabled for this Firebase project',

  'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL': 'An account already exists with the same email address but different sign-in credentials',
  'ERROR_APP_NOT_AUTHORIZED': 'This app is not authorized to use Firebase Authentication with the provided API key',
  'ERROR_APP_NOT_VERIFIED': 'Firebase could not retrieve the silent push notification and therefore could not verify your app',
  'ERROR_APP_VERIFICATION_USER_INTERACTION_FAILURE': 'The app verification process has failed, print and inspect the error details for more information',
  'ERROR_CAPTCHA_CHECK_FAILED': 'The reCAPTCHA response token provided is either invalid, expired or already',
  'ERROR_CREDENTIAL_ALREADY_IN_USE': 'This credential is already associated with a different user account.',
  'ERROR_CUSTOM_TOKEN_MISMATCH': 'The custom token corresponds to a different audience.',
  'ERROR_EXPIRED_ACTION_CODE': 'The action code has expired.',
  'ERROR_GAME_KIT_NOT_LINKED': 'The GameKit framework is not linked',
  'ERROR_INTERNAL_ERROR': 'An internal error has occurred, print and inspect the error details for more information.',
  'ERROR_INVALID_ACTION_CODE': 'The action code is invalid',
  'ERROR_INVALID_API_KEY': 'An invalid API Key was supplied in the request.',
  'ERROR_INVALID_APP_CREDENTIAL': 'The APNs device token provided is either incorrect or does not match the private certificate uploaded to the Firebase Console.',
  'ERROR_INVALID_CLIENT_ID': 'The OAuth client ID provided is either invalid or does not match the specified API key.',
  'ERROR_INVALID_CONTINUE_URI': 'The continue URL provided in the request is invalid.',
  'ERROR_INVALID_CUSTOM_TOKEN': 'The custom token format is incorrect',
  'ERROR_INVALID_DYNAMIC_LINK_DOMAIN': 'The Firebase Dynamic Link domain used is either not configured or is unauthorized for the current project.',
  'ERROR_INVALID_MESSAGE_PAYLOAD': 'The action code is invalid',
  'ERROR_INVALID_PHONE_NUMBER': 'The format of the phone number provided is incorrect',
  'ERROR_INVALID_RECIPIENT_EMAIL': 'The action code is invalid',
  'ERROR_INVALID_SENDER': 'The email template corresponding to this action contains invalid characters in its message',
  'ERROR_INVALID_USER_TOKEN': "This user's credential isn't valid for this project",
  'ERROR_INVALID_VERIFICATION_CODE': 'The SMS verification code used to create the phone auth credential is invalid',
  'ERROR_INVALID_VERIFICATION_ID': 'The verification ID used to create the phone auth credential is invalid.',
  'ERROR_KEYCHAIN_ERROR': 'An error occurred when accessing the keychain',
  'ERROR_LOCAL_PLAYER_NOT_AUTHENTICATED': 'The local player is not authenticated',
  'ERROR_MALFORMED_JWT': 'Failed to parse JWT',
  'ERROR_MISSING_ANDROID_PACKAGE_NAME': 'An Android Package Name must be provided if the Android App is required to be installed.',
  'ERROR_MISSING_APP_CREDENTIAL': 'The phone verification request is missing an APNs Device token',
  'ERROR_MISSING_APP_TOKEN': "There seems to be a problem with your project's Firebase phone number authentication set-up, please make sure to follow the instructions found at https://firebase.google.com/docs/auth/ios/phone-auth",
  'ERROR_MISSING_CONTINUE_URI': 'A continue URL must be provided in the request.',
  'ERROR_MISSING_EMAIL': 'An email address must be provided.',
  'ERROR_MISSING_IOS_BUNDLE_ID': 'An iOS Bundle ID must be provided if an App Store ID is provided.',
  'ERROR_MISSING_PHONE_NUMBER': 'To send verification codes, provide a phone number for the recipient.',
  'ERROR_MISSING_VERIFICATION_CODE': 'The phone auth credential was created with an empty SMS verification Code.',
  'ERROR_MISSING_VERIFICATION_ID': 'The phone auth credential was created with an empty verification ID.',
  'ERROR_NETWORK_ERROR': 'Network error (such as timeout, interrupted connection or unreachable host) has occurred.',
  'ERROR_NO_SUCH_PROVIDER': 'User was not linked to an account with the given provider.',
  'ERROR_NOTIFICATION_NOT_FORWARDED': "If app delegate swizzling is disabled, remote notifications received by UIApplicationDelegate need to be forwarded to FIRAuth's canHandleNotification: method.",
  'ERROR_NULL_USER': 'A null user object was provided as the argument for an operation which requires a non-null user object.',
  'ERROR_PROVIDER_ALREADY_LINKED': '[ERROR_PROVIDER_ALREADY_LINKED] - User can only be linked to one identity for the given provider.',
  'ERROR_QUOTA_EXCEEDED': 'The phone verification quota for this project has been exceeded.',
  'ERROR_SESSION_EXPIRED': 'The SMS code has expired',
  'ERROR_UNAUTHORIZED_DOMAIN': 'The domain of the continue URL is not whitelisted',
  'ERROR_USER_DISABLED': 'The user account has been disabled by an administrator.',
  'ERROR_USER_MISMATCH': 'The supplied credentials do not correspond to the previously signed in user.',
  'ERROR_USER_TOKEN_EXPIRED': "The user's credential is no longer valid",
  'ERROR_WEB_CONTEXT_ALREADY_PRESENTED': 'User interaction is still ongoing, another view cannot be presented.',
  'ERROR_WEB_CONTEXT_CANCELLED': 'The interaction was cancelled by the user.',
  'ERROR_WEB_INTERNAL_ERROR': 'An internal error has occurred within the SFSafariViewController or UIWebView.',
  'ERROR_WEB_REQUEST_FAILED': 'A network error (such as timeout, interrupted connection, or unreachable host) has occurred within the web context.',
};
