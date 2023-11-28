import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';

class Messages {
  static void showSnackbar(
    BuildContext context,
    String message, {
    bool error = true,
  }) {
    final overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: AppStyle.topPadding + 10,
        left: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: AppStyle.size.width - 40,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: error
                  ? AppColor.error.withOpacity(0.9)
                  : AppColor.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppColor.white.withOpacity(0.8),
                  size: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "${AppText.alert}!",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.white.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
