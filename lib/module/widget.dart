import 'package:flutter/material.dart';

class EditBox extends StatelessWidget {
  final String hint;
  final bool password;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const EditBox({
    super.key,
    required this.hint,
    this.password = false,
    this.prefixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: password,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Theme.of(context).iconTheme.color)
              : null,
          hintText: hint,
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[500] : Colors.grey[500],
          ),
          filled: true,
          fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? Colors.grey.shade700! : Colors.grey.shade300!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}