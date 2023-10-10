import 'package:auth/model/Media.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CardMedia extends StatelessWidget {
  final Medias media;
  final BoxConstraints constraints;

  const CardMedia(this.media, this.constraints, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth * 0.8,
      height: constraints.maxHeight,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: '$apiImage${media.picture}',
                fadeOutDuration: const Duration(milliseconds: 400),
                fit: BoxFit.fill,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.25,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/5.png'),
              ),
            ),
            ListTile(
              title: Text(
                getTranslated(context, "social_Media_Name"),
              ),
              subtitle: Text(
                '${media.mediaName}',
              ),
              leading: Image.asset(
                "assets/images/social_media.png",
                height: 32,
                width: 32,
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(getTranslated(context, "social_Media_Type")),
              subtitle: Text('${media.socialMediaType}'),
              leading: Image.asset("assets/images/social_media2.png",
                  height: 32, width: 32),
            ),
            const Divider(),
            ListTile(
              title: Text(getTranslated(context, "number_of_following")),
              subtitle: Text('${media.numFollowing}'),
              leading: Image.asset(
                "assets/images/followers.png",
                height: 32,
                width: 32,
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(getTranslated(context, "price")),
              subtitle: Text('${media.price}'),
              leading: Image.asset(
                "assets/images/price_tag.png",
                height: 32,
                width: 32,
              ),
            ),
            Consumer<AdsProvider>(
              builder: (ctx, ads, _) {
                bool selected = ads.isMediaAdded(media.id!);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (selected) {
                          ads.cancelMedia(media.id!);
                        } else {
                          ads.selectMedia(media.id!);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.buttonColor),
                      ),
                      child: Text(
                        selected
                            ? getTranslated(context, 'cancel')
                            : getTranslated(context, 'select'),
                        style:const TextStyle(color: AppColors.textColorBlack),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
