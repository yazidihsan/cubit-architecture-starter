import 'package:crudmvvm/theme_manager/color_manager.dart';
import 'package:crudmvvm/theme_manager/font_family_manager.dart';
import 'package:crudmvvm/theme_manager/space_manager.dart';
import 'package:flutter/material.dart';

class CustomCardList extends StatelessWidget {
  const CustomCardList({
    super.key,
    this.icon,
    this.name,
    this.email,
    this.phone,
    this.onDeletePressed,
    this.onEditPressed,
  });

  final Widget? icon;
  final String? name;
  final String? email;
  final String? phone;

  final VoidCallback? onDeletePressed;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.secondary,
      margin: const EdgeInsets.only(bottom: 8.0, left: 14.0, right: 14.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 39,
                height: 38,
                color: Colors.white,
                child: Center(
                  child: icon,
                ),
              ),
            ),
            12.0.spaceX,
            Column(
              children: [
                Text(
                  name ?? '-',
                  style: grey500BoldTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  email ?? '-',
                  style: grey500BoldTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  phone ?? '-',
                  style: grey500BoldTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            6.0.spaceX,
            GestureDetector(
              onTap: onEditPressed,
              child: Icon(
                Icons.edit,
                color: ColorManager.grey300,
              ),
            ),
            GestureDetector(
              onTap: onDeletePressed,
              child: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
