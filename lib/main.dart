// ignore_for_file: depend_on_referenced_packages

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

// 🌎 Project imports:
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 웹에서 URL의 #를 제거합니다.
  usePathUrlStrategy();
  // * 에러 핸들러를 등록합니다. 자세한 내용은 다음을 참조하세요:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();
  // * Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // * 앱의 진입 지점
  runApp(const ProviderScope(child: MyApp()));
}

void registerErrorHandlers() {
  // * 잡히지 않은 예외가 발생할 경우 오류 UI 표시
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * 기본 플랫폼/OS에서 발생하는 오류 처리
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * 앱의 위젯이 빌드에 실패하면 오류 UI 표시
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.tr()),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
