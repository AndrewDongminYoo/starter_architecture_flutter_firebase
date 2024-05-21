// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import '../constants/app_sizes.dart' show Sizes, gapH32;
import '../features/auth/data/firebase_auth_repository.dart' show authRepositoryProvider;
import '../routing/app_router.dart' show AppRoute;
import 'primary_button.dart' show PrimaryButton;

/// 홈 화면으로 돌아가기 위한 메시지와 CTA를 표시하는 플레이스홀더 위젯입니다.
class EmptyPlaceholderWidget extends ConsumerWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () {
                final isLoggedIn =
                    ref.watch(authRepositoryProvider).currentUser != null;
                context.goNamed(
                  isLoggedIn ? AppRoute.jobs.name : AppRoute.signIn.name,
                );
              },
              text: 'Go Home',
            ),
          ],
        ),
      ),
    );
  }
}
