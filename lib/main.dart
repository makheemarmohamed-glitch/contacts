import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'core/app_colors.dart';
void main() {
  runApp(const RouteContactsApp());
}

class RouteContactsApp extends StatelessWidget {
  const RouteContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Contacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: AppColors.primary,
      ),
      home: const SplashScreen(),
    );
  }
}
