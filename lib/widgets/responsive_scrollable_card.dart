// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../constants/app_sizes.dart';
import '../constants/breakpoints.dart';
import 'responsive_center.dart';

/// 지정된 하위 위젯과 함께 반응형 카드를 표시하는 스크롤 가능한 위젯입니다.
/// 스크롤이 필요한 양식 및 기타 위젯을 표시하는 데 유용합니다.
class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
