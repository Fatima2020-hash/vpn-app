import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/core/app_shadows.dart';
import 'package:vpn_app/core/app_static_route_paths.dart';
import 'package:vpn_app/core/app_text_styles.dart';
import 'package:vpn_app/core/app_themes.dart';

import '../providers/app_connection_provider.dart';
import '../widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppConnectionProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  HomeAppbar(),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [AppShadows.containerShadow],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        UploadWidgetLeft(
                          speed:
                              provider.userConnectionState ==
                                  UserConnectionState.connected
                              ? provider.downloadSpeed.toString()
                              :
                              '0.00',
                        ),
                        UploadWidgetRight(
                          speed:
                              provider.userConnectionState ==
                                  UserConnectionState.connected
                              ? provider.uploadSpeed.toString()
                              :
                              '0.00',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (provider.userConnectionState ==
                                UserConnectionState.disconnected) {
                              await provider.connectVpn();
                            } else if (provider.userConnectionState ==
                                UserConnectionState.connected) {
                              await provider.disconnectVpn();
                            } else if (provider.userConnectionState ==
                                UserConnectionState.error) {
                              // check some permissions and stuff here
                              await provider.connectVpn();
                            } else if (provider.userConnectionState ==
                                UserConnectionState.loading) {}
                          },
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(400),
                                color: Colors.white,
                                boxShadow: [AppShadows.slightShadow],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: getConnectionColor(
                                        provider.userConnectionState,
                                      ),
                                      width: 0.4,
                                    ),
                                    borderRadius: BorderRadius.circular(400),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          HugeIcons.strokeRoundedLogout04,
                                          size: 48,
                                          color: getConnectionColor(
                                            provider.userConnectionState,
                                          ),
                                        ),
                                        Text(
                                          getConnectionButtonTitle(
                                            provider.userConnectionState,
                                          ),
                                          style: AppTextStyles.bodyText
                                              .copyWith(
                                                color: getConnectionColor(
                                                  provider.userConnectionState,
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          getConnectionTitle(provider.userConnectionState),
                          style: AppTextStyles.bodyTextBold,
                        ),
                        Text(
                          provider.formattedConnectionTime,
                          style: AppTextStyles.bodyTextBold.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      context.pushNamed(
                        AppStaticRoutePaths.chooseLocationScreen,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppThemes.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),

                                    image: DecorationImage(
                                      image: AssetImage(
                                        'icons/flags/png100px/fr.png',
                                        package: 'country_icons',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  'France',
                                  style: AppTextStyles.bodyText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String getConnectionTitle(UserConnectionState userConnectionState) {
  switch (userConnectionState) {
    case UserConnectionState.disconnected:
      return 'Disconnected';
    case UserConnectionState.connected:
      return 'Securely Connected';
    case UserConnectionState.loading:
      return 'Connecting...';
    case UserConnectionState.error:
      return 'Unable to connect';
  }
}

String getConnectionButtonTitle(UserConnectionState userConnectionState) {
  switch (userConnectionState) {
    case UserConnectionState.disconnected:
      return 'Start';
    case UserConnectionState.connected:
      return 'Stop';
    case UserConnectionState.loading:
      return 'Wait';
    case UserConnectionState.error:
      return 'Retry';
  }
}

Color getConnectionColor(UserConnectionState userConnectionState) {
  switch (userConnectionState) {
    case UserConnectionState.disconnected:
      return Colors.red;
    case UserConnectionState.connected:
      return AppThemes.primaryColor;
    case UserConnectionState.loading:
      return Colors.orange;
    case UserConnectionState.error:
      return Colors.red;
  }
}

class UploadWidgetLeft extends StatelessWidget {
  String speed;

  UploadWidgetLeft({super.key, required this.speed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 0.2, color: Colors.grey)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Download', style: AppTextStyles.bodyTextBold),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppThemes.primaryColor.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            HugeIcons.strokeRoundedArrowDown02,
                            color: AppThemes.primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: speed,
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.grey.shade500,
                      ),
                      children: [
                        TextSpan(
                          text: "kb/s",
                          style: AppTextStyles.captionDark.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadWidgetRight extends StatelessWidget {
  String speed;

  UploadWidgetRight({super.key, required this.speed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 0.2, color: Colors.grey)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upload', style: AppTextStyles.bodyTextBold),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppThemes.primaryColor.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            HugeIcons.strokeRoundedArrowUp02,
                            color: AppThemes.primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: speed,
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.grey.shade500,
                      ),
                      children: [
                        TextSpan(
                          text: "kb/s",
                          style: AppTextStyles.captionDark.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
