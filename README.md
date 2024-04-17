# Flutter & Firebase를 이용한 시간 추적 앱

Flutter & Firebase를 사용하여 구축된 시간 추적 애플리케이션:

![](/.github/images/time-tracker-screenshots.png)

이는 제가 개발한 [Riverpod 아키텍처](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)를 기반으로 한 **참조 앱**입니다.

> **참고**: 이 프로젝트는 이전에 "Flutter & Firebase를 위한 시작 아키텍처"라고 불렸으며 (이 [옛 아티클](https://codewithandrea.com/videos/starter-architecture-flutter-firebase/)에 기반), 2023년 1월 현재, 제가 업데이트한 [Riverpod 아키텍처](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)를 따르고 있습니다.

## Flutter 웹 미리보기

앱의 Flutter 웹 미리보기는 여기에서 확인할 수 있습니다:

- [Time Tracker | Flutter 웹 데모](https://starter-architecture-flutter.web.app)

## 기능들

- **간단한 온보딩 페이지**
- **전체 인증 흐름** (이메일 & 비밀번호 사용)
- **작업**: 사용자는 자신의 개인 작업을 보고, 생성하고, 편집하고, 삭제할 수 있습니다 (각 작업은 이름과 시간당 요금을 가짐)
- **엔트리**: 각 작업에 대해 사용자는 해당 엔트리를 보고, 생성하고, 편집하고, 삭제할 수 있습니다 (엔트리는 시작 및 종료 시간을 가진 작업이며, 선택적으로 댓글을 달 수 있음)
- **보고서 페이지**는 모든 작업의 일일 분석, 근무 시간 및 급여를 보여주며 총액을 함께 표시합니다.

모든 데이터는 Firestore에 영구 저장되며 여러 기기에서 동기화됩니다.

## 로드맵

- [ ] 누락된 테스트 추가
- [x] 상태 유지 중첩 탐색 (GoRouter 7.1부터 사용 가능)
- [ ] 앱 전체에서 일관되게 컨트롤러 / 노티파이어 사용 (일부 코드는 아직 업데이트 필요)
- [ ] 지역화 추가
- [ ] 새로운 Firebase UI 패키지 사용
- [ ] 반응형 UI

> 이 로드맵은 잠정적입니다. 위의 사항들에 대한 예정된 완료 시기는 없습니다. 이 프로젝트는 우선 순위가 낮으며 관리할 시간이 많지 않습니다.

## 관련 아티클

앱은 제가 설명한 Flutter Riverpod 아키텍처를 기반으로 합니다:

- [Flutter 앱 아키텍처와 Riverpod: 소개](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
- [Flutter 프로젝트 구조: 기능별 또는 레이어별?](https://codewithandrea.com/articles/flutter-project-structure/)
- [Flutter 앱 아키텍처: 리포지토리 패턴](https://codewithandrea.com/articles/flutter-repository-pattern/)

Riverpod에 대한 자세한 정보는 다음을 읽어보세요:

- [Flutter Riverpod 2.0: 최고의 가이드](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

## 사용 중인 패키지

앱에서 사용 중인 주요 패키지는 다음과 같습니다:

- [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod) 데이터 캐싱, 종속성 주입 등을 위해
- [Riverpod Generator](https://pub.dev/packages/riverpod_generator) 및 [Riverpod Lint](https://pub.dev/packages/riverpod_lint) 최신 Riverpod API를 위해
- [GoRouter](https://pub.dev/packages/go_router) 네비게이션을 위해
- [Firebase Auth](https://pub.dev/packages/firebase_auth) 및 [Firebase UI Auth](https://pub.dev/packages/firebase_ui_auth) 인증을 위해
- [Cloud Firestore](https://pub.dev/packages/cloud_firestore) 실시간 데이터베이스로서
- [Firebase UI for Firestore](https://pub.dev/packages/firebase_ui_firestore) 페이지네이션 지원이 있는 `FirestoreListView` 위젯을 위해
- [RxDart](https://pub.dev/packages/rxdart) 필요에 따라 여러 Firestore 컬렉션을 결합하기 위해
- [Intl](https://pub.dev/packages/intl) 통화, 날짜, 시간 형식 지정을 위해
- [Mocktail](https://pub.dev/packages/mocktail) 테스팅을 위해
- [Freezed](https://pub.dev/packages/freezed) 모델 클래스에서 보일러플레이트 코드를 줄이기 위해

전체 목록은 [pubspec.yaml](pubspec.yaml) 파일을 확인하세요.

## Firebase와 함께 프로젝트 실행

이 프로젝트를 Firebase와 함께 사용하려면 다음 단계를 따르세요:

- Firebase 콘솔에서 새 프로젝트를 만듭니다
- Firebase 콘솔에서 Firebase 인증을 활성화하고 이메일/비밀번호 인증 로그인 제공자를 활성화합니다 (Authentication > 로그인 방법 > 이메일/비밀번호 > 편집 > 활성화 > 저장)
- Cloud Firestore를 활성화합니다

그런 다음 아래 두 가지 접근 방식 중 하나를 따르세요. 👇

### 1. CLI 사용하기

Firebase CLI와 [FlutterFire CLI](https://pub.dev/packages/flutterfire_cli)가 설치되어 있는지 확인하세요.

그런 다음 이 프로젝트의 루트에서 터미널에서 다음을 실행하세요:

- `firebase login`을 실행하여 만든 Firebase 프로젝트에 접근하세요
- `flutterfire configure`를 실행하고 모든 단계를 따르세요

더 많은 정보를 위해서는 이 가이드를 따르세요:

- [FlutterFire CLI로 Flutter 앱에 Firebase 추가하기](https://codewithandrea.com/articles/flutter-firebase-flutterfire-cli/)

### 2. 수동 방식 (추천하지 않음)

FlutterFire CLI를 사용하고 싶지 않다면 대신 이 단계를 따르세요:

- Firebase 프로젝트 설정에서 별도의 iOS, Android 및 웹 앱을 등록하세요.
- Android에서는 패키지 이름으로 `com.example.starter_architecture_flutter_firebase`를 사용하세요.
- 그런 다음, `google-services.json`을 [다운로드하고 복사](https://firebase.google.com/docs/flutter/setup#configure_an_android_app)하여 `android/app`에 넣으세요.
- iOS에서는 번들 ID로 `com.example.starterArchitectureFlutterFirebase`를 사용하세요.
- 그런 다음, `GoogleService-Info.plist`를 [다운로드하고 복사](https://firebase.google.com/docs/flutter/setup#configure_an_ios_app)하여 `iOS/Runner`에 넣고 Xcode의 Runner 타겟에 추가하세요.

즐거운 시간 되세요!

## [라이선스: MIT](LICENSE.md)
