import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? iconColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final double? height;

  const CustomFormField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.fillColor,
    this.iconColor,
    this.borderColor,
    this.borderRadius = 7.0,
    this.contentPadding,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor ?? theme.colorScheme.outline.withOpacity(0.3),
        width: 1.0,
      ),
    );

    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor ?? theme.colorScheme.primary,
        width: 1.0, // نفس العرض في كل الحالات
      ),
    );

    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          color: enabled
              ? theme.colorScheme.onSurface
              : theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              icon,
              size: 22,
              color: iconColor ?? theme.colorScheme.primary.withOpacity(0.8),
            ),
          ),
          border: commonBorder,
          enabledBorder: commonBorder,
          focusedBorder: focusedBorder,
          errorBorder: commonBorder, // نفس البوردر
          focusedErrorBorder: focusedBorder, // نفس البوردر
          filled: true,
          fillColor:
          fillColor ?? theme.colorScheme.surfaceVariant.withOpacity(0.2),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 12.0,
              ),
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12,
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
