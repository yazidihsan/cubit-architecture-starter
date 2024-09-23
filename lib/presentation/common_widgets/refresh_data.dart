import 'package:flutter/material.dart';

class RefreshData extends StatelessWidget {
  const RefreshData({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
    );
  }
}
