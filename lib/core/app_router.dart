import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_app/views/choose-location/pages/choose_location_screen.dart';
import 'package:vpn_app/views/contact-us/pages/contact_us_screen.dart';
import 'package:vpn_app/views/home/pages/home_screen.dart';
import 'package:vpn_app/views/menu/pages/menu_screen.dart';
import 'package:vpn_app/views/refer-friends/pages/refer_friend_screen.dart';

import '../views/manage-subscription/pages/manage_subscription_screen.dart';
import '../views/splash/pages/splash_screen.dart';
import 'app_static_route_paths.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GoRouter appRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppStaticRoutePaths.splashScreen,
      name: AppStaticRoutePaths.splashScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: AppStaticRoutePaths.homeScreen,
      name: AppStaticRoutePaths.homeScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: AppStaticRoutePaths.chooseLocationScreen,
      name: AppStaticRoutePaths.chooseLocationScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: ChooseLocationScreen(),
      ),
    ),
    GoRoute(
      path: AppStaticRoutePaths.menuScreen,
      name: AppStaticRoutePaths.menuScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: MenuScreen(),
      ),
    ),
    GoRoute(
      path: AppStaticRoutePaths.contactUs,
      name: AppStaticRoutePaths.contactUs,
      pageBuilder: (context, state) => MaterialPage(
        child: ContactUsScreen(),
      ),
    ),
    GoRoute(
      path: AppStaticRoutePaths.referFriendScreen,
      name: AppStaticRoutePaths.referFriendScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: ReferFriendScreen(),
      ),
    ),
    GoRoute(
      path: AppStaticRoutePaths.manageSubscription,
      name: AppStaticRoutePaths.manageSubscription,
      pageBuilder: (context, state) => MaterialPage(
        child: ManageSubscriptionScreen(),
      ),
    ),
  ],
);
