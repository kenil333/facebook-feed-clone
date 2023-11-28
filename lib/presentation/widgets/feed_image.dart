import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../data/model/feed_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_style.dart';
import '../provider/app_provider.dart';
import 'error_in_image.dart';

class FeedImage extends StatelessWidget {
  final FeedModel model;
  const FeedImage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AppProvider>(context, listen: false)
          .loadImage(model.id, model.image!),
      builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: AppColor.primary.withOpacity(0.1),
              child: Center(
                child: SpinKitWaveSpinner(
                  size: AppStyle.getSize(60),
                  color: AppColor.primary,
                ),
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return Image.file(
            snapshot.data!,
            width: double.infinity,
            fit: BoxFit.contain,
          );
        } else {
          return const ErrorInImage();
        }
      },
    );
  }
}
