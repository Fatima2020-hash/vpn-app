import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vpn_app/core/app_assets.dart';
import 'package:vpn_app/core/app_shadows.dart';
import 'package:vpn_app/core/app_static_route_paths.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/core/app_themes.dart';
import 'package:vpn_app/views/menu/widgets/custom_appbar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar(
                title: 'Menu',
                onTap: () {
                  context.pop();
                },
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppThemes.primaryColor.withOpacity(0.2)
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text('''You don't have any subscription plan yet'''),
                  )),
              // Stack(
              //   alignment: Alignment.center,
              //
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(400),
              //         color: AppThemes.primaryColor.withOpacity(0.2),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: SizedBox(
              //           height: 120,
              //           width: 120,
              //           child: CircularProgressIndicator(
              //             value: 0.3, // set to null for indeterminate spinner
              //             strokeWidth: 3,
              //             backgroundColor: Colors.white,
              //             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Column(
              //       children: [
              //         Text(
              //           'Expire',
              //           style: AppTextStyles.caption.copyWith(
              //             color: Colors.grey.shade800,
              //           ),
              //         ),
              //         Text('248', style: AppTextStyles.heading2),
              //         Text(
              //           'Days',
              //           style: AppTextStyles.caption.copyWith(
              //             color: Colors.grey.shade800,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20),
              // Column(
              //   children: [
              //     Text('You are secured Until', style: AppTextStyles.captionDark),
              //     Text('Oct 22nd, 2021', style: AppTextStyles.caption),
              //   ],
              // ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    MenuTile(

                      onTap: (){
                        context.pushNamed(AppStaticRoutePaths.manageSubscription);
                      },
                      title: 'Manage Subscription',
                      iconData:AppAssets.crownIcon
                    ),
                    Divider(height: 10, thickness: 0.5, color: Colors.grey),
                    MenuTile(
                      onTap: (){
                        context.pushNamed(AppStaticRoutePaths.referFriendScreen);
                      },
                      title: 'Refer Friends',
                        iconData:AppAssets.giftIcon
                    ),
                    Divider(height: 10, thickness: 0.5, color: Colors.grey),
                    MenuTile(
                      title: 'Contact Us',
                        iconData:AppAssets.contactIcon,
                      onTap: (){
                        context.pushNamed(AppStaticRoutePaths.contactUs);
                      },
                    ),
                    Divider(height: 10, thickness: 0.5, color: Colors.grey),
                    MenuTile(
                      title: 'Exit App',
                        iconData:AppAssets.login,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  String iconData;
  String title;
  VoidCallback? onTap;
  MenuTile({super.key, required this.title, required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 20,
              children: [
                SvgPicture.asset(iconData, color: AppThemes.primaryColor),
                Text(title, style: AppTextStyles.bodyTextMedBold),
              ],
            ),
            Icon(HugeIcons.strokeRoundedArrowRight01, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
