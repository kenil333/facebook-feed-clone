import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../../../utils/app_method.dart';
import '../../../utils/app_style.dart';
import '../../../utils/app_text.dart';
import '../../../utils/route_text.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withOpacity(0.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: AppStyle.getSize(30)),
            padding: EdgeInsets.symmetric(
              vertical: AppStyle.getSize(40),
              horizontal: AppStyle.getSize(25),
            ),
            child: Column(
              children: [
                Image.asset(
                  AppImage.noInternet,
                  width: AppStyle.getSize(200),
                  fit: BoxFit.contain,
                ),
                SizedBox(height: AppStyle.getSize(25)),
                Text(
                  AppText.checkInternetConnection,
                  style: TextStyle(
                    fontSize: AppStyle.getSize(20),
                    color: AppColor.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppStyle.getSize(30)),
                Text(
                  AppText.afterConnectingRestartApp,
                  style: TextStyle(
                    fontSize: AppStyle.getSize(16),
                    color: AppColor.error,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: AppStyle.getSize(20)),
          Row(
            children: [
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  AppMethod.pushAndRemoveAllRoute(
                    context,
                    route: RouteText.splash,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppStyle.getSize(20),
                    vertical: AppStyle.getSize(10),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColor.white,
                  ),
                  child: Text(
                    AppText.reload,
                    style: TextStyle(
                      fontSize: AppStyle.getSize(20),
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
