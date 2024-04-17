// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../constants/breakpoints.dart';

/// 최대 콘텐츠 너비 제약이 있는 자식을 표시하기 위한 재사용 가능한 위젯입니다.
/// 사용 가능한 너비가 최대 너비보다 크면 자식이 가운데에 배치됩니다.
/// 사용 가능한 너비가 최대 너비보다 작으면 자식은 사용 가능한 모든 너비를 사용합니다.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 최대 너비(엄격한 제약 조건)를 지정하려면 SizedBox와 함께 *제약되지 않은* 너비(느슨한 제약 조건)가 있으므로 Center를 사용합니다.
    return Center(
      // 자세한 내용은 이 스레드를 참조하세요:
      // https://twitter.com/biz84/status/1445400059894542337
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// [ResponsiveCenter]에 해당하는 슬리버.
class ResponsiveSliverCenter extends StatelessWidget {
  const ResponsiveSliverCenter({
    super.key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        padding: padding,
        child: child,
      ),
    );
  }
}
