import 'package:crudmvvm/theme_manager/color_manager.dart';
import 'package:crudmvvm/theme_manager/space_manager.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    bool? obscureText,
    Widget? suffixIcon,
    String? hintText,
    String? valueInit,
    required TextEditingController controller,
    required String title,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    void Function(String)? onChanged,
    TextInputType? keyboardType,
  })  : _keyboardType = keyboardType,
        _onChanged = onChanged,
        _valueInit = valueInit,
        _controller = controller,
        _obscureText = obscureText,
        _title = title,
        _hintText = hintText,
        _textInputAction = textInputAction,
        _suffixIcon = suffixIcon,
        _validator = validator;

  final TextEditingController _controller;
  final String _title;
  final String? _valueInit;
  final String? Function(String?)? _validator;
  final TextInputAction? _textInputAction;
  final void Function(String)? _onChanged;
  final TextInputType? _keyboardType;
  final bool? _obscureText;
  final String? _hintText;
  final Widget? _suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        8.0.spaceY,
        TextFormField(
          initialValue: _valueInit,
          controller: _controller,
          onChanged: _onChanged,
          cursorColor: ColorManager.primary,
          textInputAction: _textInputAction,
          obscureText: _obscureText ?? false,
          keyboardType: _keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            hintText: _hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: _suffixIcon,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFBCBCBC),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10), // Default border color
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primary,
                  width: 1.0), // Border color when focused
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          validator: _validator,
        )
      ],
    );
  }
}
