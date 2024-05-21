// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import '../features/auth/data/firebase_auth_repository.dart' show authRepositoryProvider;
import '../features/auth/ui/custom_profile_screen.dart' show CustomProfileScreen;
import '../features/auth/ui/custom_sign_in_screen.dart' show CustomSignInScreen;
import '../features/entries/domain/entry.dart' show Entry;
import '../features/entries/ui/entries_screen.dart' show EntriesScreen;
import '../features/entries/ui/entry_screen/entry_screen.dart' show EntryScreen;
import '../features/jobs/domain/job.dart' show Job;
import '../features/jobs/ui/edit_job_screen/edit_job_screen.dart' show EditJobScreen;
import '../features/jobs/ui/job_entries_screen/job_entries_screen.dart' show JobEntriesScreen;
import '../features/jobs/ui/jobs_screen/jobs_screen.dart' show JobsScreen;
import '../features/onboarding/data/onboarding_repository.dart' show onboardingRepositoryProvider;
import '../features/onboarding/ui/onboarding_screen.dart' show OnboardingScreen;
import 'app_startup.dart' show AppStartupWidget, appStartupProvider;
import 'go_router_refresh_stream.dart' show GoRouterRefreshStream;
import 'not_found_screen.dart' show NotFoundScreen;
import 'scaffold_with_nested_navigation.dart' show ScaffoldWithNestedNavigation;

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _jobsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'jobs');
final _entriesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'entries');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  onboarding,
  signIn,
  jobs,
  job,
  addJob,
  editJob,
  entry,
  addEntry,
  editEntry,
  entries,
  profile,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  // 앱 시작 상태가 변경되면 GoRouter 재빌드
  final appStartupState = ref.watch(appStartupProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // 앱이 아직 초기화 중인 경우 /startup 경로를 표시합니다.
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }
      final onboardingRepository =
          ref.read(onboardingRepositoryProvider).requireValue;
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;
      if (!didCompleteOnboarding) {
        // 널이 아닌 경로를 반환하기 전에 항상 state.subloc을 확인합니다.
        // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
        if (path != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/signIn')) {
          return '/jobs';
        }
      } else {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/jobs') ||
            path.startsWith('/entries') ||
            path.startsWith('/account')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            // * 이것은 단지 플레이스홀더일 뿐입니다.
            // * 로드된 경로는 상태 변경 시 GoRouter에서 관리합니다.
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingScreen()),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CustomSignInScreen()),
      ),
      // 스테이트풀 내비게이션 출처:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,
          ),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _jobsNavigatorKey,
            routes: [
              GoRoute(
                path: '/jobs',
                name: AppRoute.jobs.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: JobsScreen()),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: AppRoute.addJob.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return const MaterialPage(
                        fullscreenDialog: true,
                        child: EditJobScreen(),
                      );
                    },
                  ),
                  GoRoute(
                    path: ':id',
                    name: AppRoute.job.name,
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return MaterialPage(
                        child: JobEntriesScreen(jobId: id),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'entries/add',
                        name: AppRoute.addEntry.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        pageBuilder: (context, state) {
                          final jobId = state.pathParameters['id']!;
                          return MaterialPage(
                            fullscreenDialog: true,
                            child: EntryScreen(jobId: jobId),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'entries/:eid',
                        name: AppRoute.entry.name,
                        pageBuilder: (context, state) {
                          final jobId = state.pathParameters['id']!;
                          final entryId = state.pathParameters['eid']!;
                          final entry = state.extra as Entry?;
                          return MaterialPage(
                            child: EntryScreen(
                              jobId: jobId,
                              entryId: entryId,
                              entry: entry,
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'edit',
                        name: AppRoute.editJob.name,
                        pageBuilder: (context, state) {
                          final jobId = state.pathParameters['id'];
                          final job = state.extra as Job?;
                          return MaterialPage(
                            fullscreenDialog: true,
                            child: EditJobScreen(
                              jobId: jobId,
                              job: job,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _entriesNavigatorKey,
            routes: [
              GoRoute(
                path: '/entries',
                name: AppRoute.entries.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: EntriesScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: CustomProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: NotFoundScreen()),
  );
}
