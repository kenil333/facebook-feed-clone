import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import '../provider/app_provider.dart';
import '../widgets/comment_widget.dart';
import '../widgets/messages.dart';

class CommentScreen extends StatefulWidget {
  final int feedIndex;
  const CommentScreen({
    super.key,
    required this.feedIndex,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen>
    with WidgetsBindingObserver {
  final TextEditingController commentTc = TextEditingController();
  final ValueNotifier<bool> sendComment = ValueNotifier(false);
  final ValueNotifier<bool> keyboardOpen = ValueNotifier(false);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    keyboardOpen.value = bottomInset > 0.0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    commentTc.dispose();
    sendComment.dispose();
    keyboardOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider provider =
        Provider.of<AppProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: AppStyle.size.height - AppStyle.topPadding,
          color: AppColor.white,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: AppStyle.getSize(15),
                  bottom: AppStyle.getSize(15),
                  left: AppStyle.getSize(15),
                  right: AppStyle.getSize(15),
                ),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border(
                    bottom: BorderSide(color: AppColor.black.withOpacity(0.1)),
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
                      AppText.comment,
                      style: TextStyle(
                        fontSize: AppStyle.getSize(18),
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Selector<AppProvider, bool>(
                builder: (context, updating, child) => Expanded(
                  child: provider.feeds[widget.feedIndex].comments.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.only(
                            left: AppStyle.getSize(15),
                            right: AppStyle.getSize(15),
                            top: AppStyle.getSize(10),
                          ),
                          itemCount:
                              provider.feeds[widget.feedIndex].comments.length,
                          reverse: true,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics(),
                          ),
                          itemBuilder: (context, i) => CommentWidget(
                            model: provider.feeds[widget.feedIndex].comments[i],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImage.noComment,
                              width: AppStyle.getSize(100),
                            ),
                            SizedBox(height: AppStyle.getSize(25)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppStyle.getSize(32),
                              ),
                              child: Text(
                                AppText.emptyCommentNote,
                                style: TextStyle(
                                  fontSize: AppStyle.getSize(16),
                                  color: AppColor.black.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                ),
                selector: (context, cp) => cp.updateFeeds,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: AppColor.black.withOpacity(0.1),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: AppStyle.getSize(15),
                  vertical: AppStyle.getSize(10),
                ),
                decoration: BoxDecoration(
                  color: AppColor.commentBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentTc,
                        cursorColor: AppColor.primary,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                            fontSize: AppStyle.getSize(14),
                            color: AppColor.black,
                            fontWeight: FontWeight.w500),
                        onChanged: (String value) {
                          if (value.isNotEmpty &&
                              value.trim().isNotEmpty &&
                              value.trim().length > 1) {
                            if (sendComment.value != true) {
                              sendComment.value = true;
                            }
                          } else {
                            if (sendComment.value != false) {
                              sendComment.value = false;
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: AppStyle.getSize(10),
                            horizontal: AppStyle.getSize(15),
                          ),
                          hintText: AppText.writeCommentHere,
                          hintStyle: TextStyle(
                            fontSize: AppStyle.getSize(14),
                            color: AppColor.black.withOpacity(0.4),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny('\n'),
                          LengthLimitingTextInputFormatter(400)
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: sendComment,
                      builder: (context, allowToSend, child) => Stack(
                        children: [
                          if (allowToSend)
                            Positioned(
                              top: AppStyle.getSize(5),
                              left: AppStyle.getSize(8),
                              child: Container(
                                width: AppStyle.getSize(14),
                                height: AppStyle.getSize(20),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              if (sendComment.value) {
                                FocusScope.of(context).unfocus();
                                provider.addComment(
                                  commentTc.text.trim(),
                                  provider.feeds[widget.feedIndex].id,
                                  error: (String error) {
                                    Messages.showSnackbar(context, error);
                                  },
                                  success: () {
                                    commentTc.clear();
                                    sendComment.value = false;
                                  },
                                );
                              }
                            },
                            child: Icon(
                              CupertinoIcons.arrow_up_circle_fill,
                              color: allowToSend
                                  ? AppColor.primary
                                  : AppColor.primary.withOpacity(0.2),
                              size: AppStyle.getSize(32),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppStyle.getSize(4)),
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: keyboardOpen,
                builder: (context, open, child) => Container(
                  height: !open ? AppStyle.bottomPadding : 0,
                  width: double.infinity,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
