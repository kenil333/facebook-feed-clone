import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/app_color.dart';
import '../../utils/app_style.dart';

class OverLayTitle extends StatelessWidget {
  final bool calling;
  final String title;
  const OverLayTitle({
    super.key,
    required this.calling,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: calling,
      child: Container(
        color: AppColor.white.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              size: AppStyle.getSize(60),
              color: AppColor.black,
            ),
            SizedBox(height: AppStyle.getSize(10)),
            Text(
              title,
              style: TextStyle(
                fontSize: AppStyle.getSize(18),
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
