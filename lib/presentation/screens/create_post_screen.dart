import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/image_repository.dart';
import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import '../provider/app_provider.dart';
import '../widgets/messages.dart';
import '../widgets/overlay_title.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final ImageRepository imageRepo = ImageRepository();
  final TextEditingController descriptionTC = TextEditingController();
  final ValueNotifier<bool> allowPost = ValueNotifier(false);
  final ValueNotifier<File?> imageFile = ValueNotifier(null);

  void pickImage() async {
    imageFile.value = await imageRepo.pickImage(error: (String error) {
      Messages.showSnackbar(context, error);
    });
    debugPrint("=======>  File Path  :::  ${imageFile.value!.path}");
  }

  @override
  void dispose() {
    descriptionTC.dispose();
    allowPost.dispose();
    imageFile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider provider =
        Provider.of<AppProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: AppStyle.topPadding + AppStyle.getSize(15),
                      bottom: AppStyle.getSize(15),
                      left: AppStyle.getSize(15),
                      right: AppStyle.getSize(15),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border(
                        bottom:
                            BorderSide(color: AppColor.black.withOpacity(0.1)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Builder(builder: (ctx) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: AppStyle.getSize(24),
                            ),
                          );
                        }),
                        SizedBox(width: AppStyle.getSize(15)),
                        Text(
                          AppText.createPost,
                          style: TextStyle(
                            fontSize: AppStyle.getSize(18),
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(child: Container()),
                        ValueListenableBuilder(
                          valueListenable: allowPost,
                          builder: (context, allow, child) => GestureDetector(
                            onTap: () {
                              if (allow) {
                                FocusScope.of(context).unfocus();
                                provider.createPost(
                                  descriptionTC.text.trim(),
                                  imageFile.value,
                                  error: (String error) {
                                    Messages.showSnackbar(context, error);
                                  },
                                  success: () {
                                    imageRepo.deletePickedImages();
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                            child: Text(
                              AppText.post,
                              style: TextStyle(
                                fontSize: AppStyle.getSize(16),
                                color:
                                    allow ? AppColor.primary : AppColor.devider,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppStyle.getSize(15)),
                        child: Column(
                          children: [
                            SizedBox(height: AppStyle.getSize(16)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    AppImage.appLogo,
                                    width: AppStyle.getSize(45),
                                    height: AppStyle.getSize(45),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: AppStyle.getSize(15)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppStyle.getSize(2)),
                                      Text(
                                        "Crazzy Skull",
                                        style: TextStyle(
                                          fontSize: AppStyle.getSize(16),
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppStyle.getSize(16)),
                            TextField(
                              controller: descriptionTC,
                              cursorColor: AppColor.primary,
                              style: TextStyle(
                                fontSize: AppStyle.getSize(14),
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: AppText.writeSomethingHere,
                                hintStyle: TextStyle(
                                  fontSize: AppStyle.getSize(14),
                                  color: AppColor.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                    color: AppColor.black.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                    color: AppColor.black.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                    color: AppColor.black.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                    color: AppColor.black.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppStyle.getSize(16),
                                  horizontal: AppStyle.getSize(16),
                                ),
                              ),
                              maxLines: 5,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3000),
                              ],
                              onChanged: (String value) {
                                if (value.trim().isNotEmpty) {
                                  if (!allowPost.value) {
                                    allowPost.value = true;
                                  }
                                } else {
                                  if (allowPost.value) {
                                    allowPost.value = false;
                                  }
                                }
                              },
                            ),
                            SizedBox(height: AppStyle.getSize(16)),
                            ValueListenableBuilder<File?>(
                              valueListenable: imageFile,
                              builder: (context, file, child) => file == null
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            pickImage();
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AppImage.photoSelect,
                                                fit: BoxFit.contain,
                                                width: AppStyle.getSize(24),
                                                height: AppStyle.getSize(24),
                                              ),
                                              SizedBox(
                                                  width: AppStyle.getSize(8)),
                                              Text(
                                                AppText.photo,
                                                style: TextStyle(
                                                  fontSize:
                                                      AppStyle.getSize(12),
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(height: AppStyle.getSize(16)),
                                        Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(
                                                AppStyle.getSize(8),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  file,
                                                  fit: BoxFit.contain,
                                                  width: double.infinity,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  imageFile.value = null;
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                child: Container(
                                                  width: AppStyle.getSize(24),
                                                  height: AppStyle.getSize(24),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: AppColor.error,
                                                  ),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    size: AppStyle.getSize(18),
                                                    color: AppColor.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
                            SizedBox(
                              height:
                                  AppStyle.bottomPadding + AppStyle.getSize(16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Selector<AppProvider, bool>(
              builder: (context, calling, child) => OverLayTitle(
                calling: calling,
                title: AppText.uploadingImage,
              ),
              selector: (context, cp) => cp.uploadingImage,
            ),
            Selector<AppProvider, bool>(
              builder: (context, calling, child) => OverLayTitle(
                calling: calling,
                title: AppText.creatingPost,
              ),
              selector: (context, cp) => cp.creatingPost,
            ),
          ],
        ),
      ),
    );
  }
}
