// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../widgets/empty_placeholder_widget.dart';

/// 404 오류(웹에서 페이지를 찾을 수 없음)에 사용되는 간단한 찾을 수 없음 화면
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EmptyPlaceholderWidget(message: '404 - Page not found!'),
    );
  }
}
