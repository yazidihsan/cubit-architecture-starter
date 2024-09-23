import 'package:crudmvvm/theme_manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size,
    required this.title,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: size,
          backgroundColor: backgroundColor ?? ColorManager.primary,
          foregroundColor: foregroundColor ?? Colors.white,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
