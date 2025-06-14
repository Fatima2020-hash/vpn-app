import 'package:flaticon/flaticon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vpn_app/core/app_assets.dart';
import 'package:vpn_app/core/app_static_route_paths.dart';

import '../../../core/app_shadows.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/app_themes.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            context.pushNamed(AppStaticRoutePaths.menuScreen);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [AppShadows.containerShadow],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                HugeIcons.strokeRoundedDashboardSquare01,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            context.pushNamed(AppStaticRoutePaths.manageSubscription);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppThemes.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                spacing: 10,
                children: [
                  SvgPicture.asset(AppAssets.crownIcon, color: Colors.white),
                  Text(
                    'Go Premium',
                    style: AppTextStyles.bodyText.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
