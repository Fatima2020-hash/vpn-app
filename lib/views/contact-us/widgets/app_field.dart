import 'package:flutter/material.dart';

import '../../../core/app_shadows.dart';

class AppField extends StatelessWidget {
  TextEditingController textEditingController;
  String hint;
  int maxLines;
  final String? Function(String?)? validator; //

  AppField({
    super.key,
    required this.textEditingController,
    required this.hint,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [AppShadows.slightShadow]),
      child: TextFormField(
        validator: validator,
        maxLines: maxLines,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: hint,
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, // Remove visible border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, // Optional: highlight color
          ),
        ),
      ),
    );
  }
}
