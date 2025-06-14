import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_app/core/app_assets.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/core/app_themes.dart';
import 'package:vpn_app/views/menu/widgets/custom_appbar.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // child: Image.asset(
              //   AppAssets.subscriptionImage,
              //   fit: BoxFit.cover,
              // ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppAssets.subscriptionImage,),fit: BoxFit.cover),
                  
                ),
                child: Column(
                  children: [
                    CustomAppbar(title: 'Upgrade to premium', onTap: (){
                      context.pop();
                    }, isInverted: true,)
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 18,
                ),
                child: Column(
                  children: [
                    Text('SELECT YOUR PLAN', style: AppTextStyles.heading2),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppThemes.primaryColor,),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Yearly', style: AppTextStyles.heading3),
                                  RichText(
                                    text: TextSpan(
                                      text: "\$XX.XX",
                                      style: AppTextStyles.heading2.copyWith(
                                        color: AppThemes.primaryColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "/year",
                                          style: AppTextStyles.captionDark,
                                        ),
                                        TextSpan(
                                          text: '  (only \$x.xx /month)',
                                          style: AppTextStyles.microDark,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppThemes.primaryColor,),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Monthly', style: AppTextStyles.heading3),
                                  RichText(
                                    text: TextSpan(
                                      text: "\$XX.XX",
                                      style: AppTextStyles.heading2.copyWith(
                                        color: AppThemes.primaryColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "/month",
                                          style: AppTextStyles.captionDark,
                                        ),
                                        TextSpan(
                                          text: '  (only \$x.xx /month)',
                                          style: AppTextStyles.microDark,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
