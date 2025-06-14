import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/views/home/providers/app_connection_provider.dart';
import 'core/app_constants.dart';
import 'core/app_router.dart';
import 'core/app_themes.dart';
import 'globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppConnectionProvider()),
    ],
    child: MyApp(
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      title: AppConstants.appName,
      routerConfig: appRoutes,
    );
  }
}
