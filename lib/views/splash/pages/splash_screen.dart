import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_app/core/app_assets.dart';
import 'package:vpn_app/core/app_constants.dart';
import 'package:vpn_app/core/app_screen_utils.dart';
import 'package:vpn_app/core/app_static_route_paths.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/core/app_themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    print('Init state called');
    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
    context.goNamed(AppStaticRoutePaths.homeScreen);
    });
    print('Init state end');

  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  Center(
                    child: Column(
                      children: [
                       SizedBox(
                           height: context.width / 1.5,
                           child: Image.asset('assets/images/SECURE VPN-01.png')),

                        Text('SECURED VPN', style: AppTextStyles.heading1.copyWith(color: AppThemes.primaryColor),)
                      ],
                    ),
                  ),
                  Text(
                    'Enjoy surfing!Enjoy life!',
                    style: AppTextStyles.heading3.copyWith(
                      color: AppThemes.primaryColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Welcome to dedicated \nservers of Netflix, Hbo, etc',
                        style: AppTextStyles.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
