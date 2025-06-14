import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_shadows.dart';
import '../../../core/app_text_styles.dart';
class CustomAppbar extends StatelessWidget {
  String title;
  VoidCallback onTap;
  bool isInverted;

  CustomAppbar({super.key, required this.title, required this.onTap, this.isInverted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Title
          Center(child: Text(title, style: AppTextStyles.heading3.copyWith(color:  isInverted ? Colors.white : Colors.black),)),

          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  boxShadow: [AppShadows.containerShadow],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(HugeIcons.strokeRoundedArrowLeft01),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
