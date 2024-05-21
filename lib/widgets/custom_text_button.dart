// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../constants/app_sizes.dart' show Sizes;

/// 고정 높이의 사용자 지정 텍스트 버튼
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.style,
    this.onPressed,
  });

  final String text;
  final TextStyle? style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: style, textAlign: TextAlign.center),
      ),
    );
  }
}
