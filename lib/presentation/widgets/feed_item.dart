import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/feed_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_enum.dart';
import '../../utils/app_image.dart';
import '../../utils/app_method.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import '../provider/app_provider.dart';
import '../screens/comment_screen.dart';
import 'feed_btn.dart';
import 'feed_image.dart';
import 'messages.dart';

class FeedItem extends StatelessWidget {
  final FeedModel model;
  final int feedIndex;
  const FeedItem({
    super.key,
    required this.model,
    required this.feedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final AppProvider provider =
        Provider.of<AppProvider>(context, listen: false);
    const List<Reaction> reactions = Reaction.values;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (provider.reactionFeedId.isNotEmpty) {
              provider.changeReactionFeedId({});
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: AppStyle.getSize(12)),
            margin: EdgeInsets.only(bottom: AppStyle.getSize(8)),
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppStyle.getSize(15)),
                  child: Row(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(height: AppStyle.getSize(2)),
                            Text(
                              AppMethod.displayTime(
                                DateTime.fromMillisecondsSinceEpoch(
                                    model.timestemp),
                              ),
                              style: TextStyle(
                                fontSize: AppStyle.getSize(11),
                                color: AppColor.black.withOpacity(0.4),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppStyle.getSize(15)),
                      Icon(
                        Icons.more_horiz_rounded,
                        size: AppStyle.getSize(25),
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      SizedBox(width: AppStyle.getSize(15)),
                      Icon(
                        Icons.close_rounded,
                        size: AppStyle.getSize(25),
                        color: AppColor.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppStyle.getSize(15)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppStyle.getSize(15)),
                  child: Text(
                    model.description,
                    style: TextStyle(
                      fontSize: AppStyle.getSize(14),
                      color: AppColor.black,
                    ),
                  ),
                ),
                SizedBox(height: AppStyle.getSize(10)),
                if (model.image != null) FeedImage(model: model),
                SizedBox(height: AppStyle.getSize(10)),
                Selector<AppProvider, bool>(
                  builder: (context, updating, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppStyle.getSize(15)),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImage.like,
                                  width: AppStyle.getSize(18),
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: AppStyle.getSize(5)),
                                Text(
                                  provider.feeds[feedIndex].likes.length
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: AppStyle.getSize(12),
                                    color: AppColor.black.withOpacity(0.4),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Text(
                              "${provider.feeds[feedIndex].comments.length} ${AppText.comments}",
                              style: TextStyle(
                                fontSize: AppStyle.getSize(12),
                                color: AppColor.black.withOpacity(0.4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: AppStyle.getSize(2),
                              height: AppStyle.getSize(2),
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppStyle.getSize(5)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColor.black,
                              ),
                            ),
                            Text(
                              "0 ${AppText.shares}",
                              style: TextStyle(
                                fontSize: AppStyle.getSize(12),
                                color: AppColor.black.withOpacity(0.4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppStyle.getSize(10)),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        margin: EdgeInsets.symmetric(
                            horizontal: AppStyle.getSize(15)),
                        color: AppColor.black.withOpacity(0.2),
                      ),
                      SizedBox(height: AppStyle.getSize(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppStyle.getSize(16)),
                        child: Selector<AppProvider, String?>(
                          builder: (context, id, child) => id != null
                              ? Row(
                                  children: [
                                    for (int i = 0; i < 10; i++)
                                      Expanded(
                                        child: SizedBox(
                                          height: AppStyle.getSize(20),
                                          child: Row(
                                            children: [
                                              Expanded(child: Container()),
                                              Container(
                                                width: AppStyle.getSize(2),
                                                height: AppStyle.getSize(2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: AppColor.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : Builder(
                                  builder: (ctx) {
                                    Reaction? reactionType;
                                    final int ui = provider
                                        .feeds[feedIndex].likes
                                        .indexWhere((element) =>
                                            element.userId == "thisUser");
                                    if (ui != -1) {
                                      reactionType = AppMethod.getTheReaction(
                                          provider
                                              .feeds[feedIndex].likes[ui].type);
                                    }
                                    return Row(
                                      children: [
                                        FeedBtn(
                                          title: reactionType != null
                                              ? reactionType.key
                                              : AppText.like,
                                          imgPath: reactionType != null
                                              ? reactionType.imagePath
                                              : AppImage.likeInitial,
                                          imgColor: reactionType != null
                                              ? null
                                              : AppColor.black.withOpacity(0.5),
                                          titleColor: reactionType != null
                                              ? reactionType.color
                                              : AppColor.black.withOpacity(0.5),
                                          onPress: () {
                                            provider.likePress(
                                              Reaction.like,
                                              model.id,
                                              error: (String error) {
                                                Messages.showSnackbar(
                                                    context, error);
                                              },
                                              fromReaction: false,
                                            );
                                          },
                                          alignment: Alignment.centerLeft,
                                          onLongPress: () {
                                            provider.changeReactionFeedId(
                                                {model.id: "show"});
                                          },
                                        ),
                                        FeedBtn(
                                          title: AppText.comment,
                                          imgPath: AppImage.comment,
                                          imgColor:
                                              AppColor.black.withOpacity(0.5),
                                          titleColor:
                                              AppColor.black.withOpacity(0.5),
                                          onPress: () {
                                            AppMethod.openBottomSheet(
                                              ctx,
                                              CommentScreen(
                                                feedIndex: feedIndex,
                                              ),
                                            );
                                          },
                                          alignment: Alignment.centerLeft,
                                        ),
                                        FeedBtn(
                                          title: AppText.send,
                                          imgPath: AppImage.send,
                                          imgColor:
                                              AppColor.black.withOpacity(0.5),
                                          titleColor:
                                              AppColor.black.withOpacity(0.5),
                                          onPress: () {},
                                          alignment: Alignment.centerRight,
                                        ),
                                        FeedBtn(
                                          title: AppText.share,
                                          imgPath: AppImage.share,
                                          imgColor:
                                              AppColor.black.withOpacity(0.5),
                                          titleColor:
                                              AppColor.black.withOpacity(0.5),
                                          onPress: () {},
                                          alignment: Alignment.centerRight,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          selector: (context, cp) =>
                              cp.reactionFeedId[model.id],
                        ),
                      ),
                    ],
                  ),
                  selector: (context, cp) => cp.updateFeeds,
                ),
              ],
            ),
          ),
        ),
        Selector<AppProvider, String?>(
          builder: (context, id, child) => AnimatedPositioned(
            bottom: id != null ? AppStyle.getSize(70) : (-AppStyle.getSize(50)),
            left: id != null ? AppStyle.getSize(15) : 0,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            child: Container(
              height: AppStyle.getSize(50),
              padding: EdgeInsets.symmetric(horizontal: AppStyle.getSize(4)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  for (int i = 0; i < reactions.length; i++)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppStyle.getSize(4)),
                      child: GestureDetector(
                        onTap: () {
                          provider.likePress(
                            reactions[i],
                            model.id,
                            error: (String error) {
                              Messages.showSnackbar(context, error);
                            },
                            fromReaction: true,
                          );
                        },
                        child: Image.asset(
                          reactions[i].imagePath,
                          width: AppStyle.getSize(38),
                          height: AppStyle.getSize(38),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          selector: (context, cp) => cp.reactionFeedId[model.id],
        ),
      ],
    );
  }
}
