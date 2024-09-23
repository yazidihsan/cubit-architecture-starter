import 'package:crudmvvm/theme_manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorManager.primary,
    );
  }
}
