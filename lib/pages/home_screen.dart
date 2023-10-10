import 'package:auth/pages/about_us.dart';
import 'package:auth/widgets/view_pager.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'start_ad_campaign.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const ViewPager(),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            child: SizedBox(
              width: height * 0.2,
              height: width * 0.3,
              child: Card(
                  shadowColor: AppColors.grayColor,
                  elevation: 10,
                  color: AppColors.cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.legend_toggle_sharp,
                        size: 30,
                      ),
                      Text(getTranslated(context, "Start_AD"))
                    ],
                  )),
            ),
            onTap: () {
              Navigator.pushNamed(context, StartAdCampaign.id);
            },
          ),
          const SizedBox(height: 20),
          InkWell(
            child: SizedBox(
              width: height * 0.2,
              height: width * 0.3,
              child: Card(
                  shadowColor: AppColors.grayColor,
                  color: AppColors.cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 30,
                      ),
                      Text(getTranslated(context, "about_US"))
                    ],
                  )),
            ),
            onTap: () {
              Navigator.pushNamed(context, AboutUS.id);
            },
          ),
        ],
      ),
    );
  }
}
