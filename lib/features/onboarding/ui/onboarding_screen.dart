// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import '../../../constants/app_sizes.dart' show gapH16;
import '../../../routing/app_router.dart' show AppRoute;
import '../../../widgets/primary_button.dart' show PrimaryButton;
import '../../../widgets/responsive_center.dart' show ResponsiveCenter;
import 'onboarding_controller.dart' show onboardingControllerProvider;

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    return Scaffold(
      body: ResponsiveCenter(
        maxContentWidth: 450,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Track your time.\nBecause time counts.',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            gapH16,
            SvgPicture.asset(
              'assets/time-tracking.svg',
              width: 200,
              height: 200,
              semanticsLabel: 'Time tracking logo',
            ),
            gapH16,
            PrimaryButton(
              text: 'Get Started'.tr(),
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(onboardingControllerProvider.notifier)
                          .completeOnboarding();
                      if (context.mounted) {
                        // 온보딩 완료 후 로그인 페이지로 이동합니다.
                        context.goNamed(AppRoute.signIn.name);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
