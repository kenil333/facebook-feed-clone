import 'package:flutter/material.dart';

import '../presentation/screens/create_post_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/offline_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../presentation/screens/splash_screen.dart';
import 'route_text.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case RouteText.splash:
            return const SplashScreen();
          case RouteText.home:
            return const HomeScreen();
          case RouteText.createPost:
            return const CreatePostScreen();
          case RouteText.offline:
            return const OfflineScreen();
          case RouteText.profile:
            return const ProfileScreen();
          default:
            return const SplashScreen();
        }
      },
      // settings: RouteSettings(name: settings.name),
    );
  }
}
