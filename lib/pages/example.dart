import 'package:auth/constants.dart';
import 'package:auth/model/Billboard.dart';
import 'package:auth/model/Media.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Example extends StatelessWidget {
  static const String id = 'examplesAds';

  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var type = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('$type'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: screenHeight * 8,
        width: screenWidth,
        child: Consumer<AdsProvider>(
          builder: (ctx, data, _) {
            if (data.dataAds == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: type == getTranslated(context, "billboard")
                    ? data.dataAds!.billboards!.length
                    : data.dataAds!.medias!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (_, index) {
                  if (type == getTranslated(context, "billboard")) {
                    return cardBillboard(context,
                        data.dataAds!.billboards![index], screenHeight);
                  } else {
                    return cardMedia(
                        context, data.dataAds!.medias![index], screenHeight);
                  }
                });
          },
        ),
      ),
    );
  }

  Card cardBillboard(
      BuildContext context, Billboard billboard, double screenHeight) {
    double price =0;
    if (billboard.discount != null) {
      price = billboard.price! - (billboard.price! * billboard.discount! / 100);
    }
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: '$apiImage${billboard.picture}',
              // fit: BoxFit.fill,
              // height: screenHeight * 0.4,
              fadeOutDuration: const Duration(milliseconds: 400),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/5.png'),
            ),
          ),
          ListTile(
            title: Text(getTranslated(context, 'size')),
            subtitle: Text('${billboard.measurementsName}'),
            leading: Image.asset(
              "assets/images/measure.png",
              height: 32,
              width: 32,
            ),
          ),
          ListTile(
            title: Text(getTranslated(context, 'measurement') +
                '(' +
                getTranslated(context, 'width') +
                '*' +
                getTranslated(context, 'height') +
                ')'),
            subtitle: Text(
                '(${billboard.measurementsHeight})*(${billboard.measurementsWidth})'),
            leading: Image.asset(
              "assets/images/square_measurement.png",
              height: 32,
              width: 32,
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(getTranslated(context, "Region:")),
            subtitle: Text(
                '${billboard.regionName} - ${billboard.siteName} (${billboard.siteType})'),
            leading: const Icon(Icons.location_city),
          ),
          const Divider(),
          ListTile(
            title: Text(getTranslated(context, "price")),
            subtitle: billboard.discount == null
                ? Text(' ${billboard.price} ')
                : Row(
                    children: [
                      Text(
                        ' ${billboard.price} ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough),
                      ),
                      Text(' ${price.toString()} ')
                    ],
                  ),
            leading: Image.asset(
              "assets/images/price_tag.png",
              height: 32,
              width: 32,
            ),
          ),
        ],
      ),
    );
  }

  Card cardMedia(BuildContext context, Medias media, double screenHeight) {
    return Card(
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
              // fit: BoxFit.fill,
              fadeOutDuration: const Duration(milliseconds: 400),
              // height: screenHeight * 0.35,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/5.png'),
            ),
          ),
          ListTile(
            title: Text(getTranslated(context, "social_Media_Name")),
            subtitle: Text('${media.mediaName}'),
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
            leading: Image.asset(
              "assets/images/social_media2.png",
              height: 32,
              width: 32,
            ),
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
            title: Text(getTranslated(context, "Description")),
            subtitle: Text(' ${media.mediaDescription} '),
            leading: const Icon(Icons.description),
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
        ],
      ),
    );
  }
}
