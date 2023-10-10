import 'package:auth/model/DataAds.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:auth/widgets/cardBillboard.dart';
import 'package:auth/widgets/cardMedia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'AddADCampaign.dart';

class SelectAdsTypes extends StatelessWidget {
  static const String id = 'SelectAdsTypes';

  const SelectAdsTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(getTranslated(context, 'choose_and_select'),style:
        TextStyle(color: AppColors.textColorBlack),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<AdsProvider>(
          builder: (ctx, data, _) {
            if (data.dataAds == null) {
              return const Center(child: CircularProgressIndicator());
            }
            DataAds dataAds = data.dataAds!;

            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: 1,
                        activeColor: AppColors.iconColor,
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(getTranslated(context, 'billboard')),
                        groupValue: data.adType,
                        onChanged: (v) {
                          data.changeAdType(int.parse(v.toString()));
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: 2,
                        activeColor: AppColors.iconColor,
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(getTranslated(context, 'media')),
                        groupValue: data.adType,
                        onChanged: (v) {
                          data.changeAdType(int.parse(v.toString()));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.7,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.adType == 1
                              ? dataAds.billboards!.length
                              : dataAds.medias!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            if (data.adType == 1) {
                              print(data.controllers.length);
                              data.controllers.add(TextEditingController(text: '1'));
                              return CardBillboard(
                                dataAds.billboards![index],
                                constraints,
                                data.controllers[index]
                              );
                            } else {
                              return CardMedia(
                                dataAds.medias![index],
                                constraints,
                              );
                            }
                          });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddADCampaign.id);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.darkPrimaryColor),
                    ),
                    child: Text(getTranslated(context, 'Next')),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
