// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_method.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import '../../utils/route_text.dart';
import '../provider/app_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      if (await InternetConnectionChecker().hasConnection) {
        await Provider.of<AppProvider>(context, listen: false).getFeeds();
        AppMethod.pushAndRemoveAllRoute(context, route: RouteText.home);
      } else {
        await Future.delayed(const Duration(seconds: 1));
        AppMethod.pushAndRemoveAllRoute(context, route: RouteText.offline);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    AppStyle.setupData(MediaQuery.of(context));
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              AppImage.appLogo,
              fit: BoxFit.contain,
              width: AppStyle.getSize(120),
            ),
          ),
          Positioned(
            bottom: AppStyle.bottomPadding + 40,
            child: SizedBox(
              width: AppStyle.size.width,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Text(
                    AppText.appName,
                    style: TextStyle(
                      fontSize: AppStyle.getSize(32),
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
