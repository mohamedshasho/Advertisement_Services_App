import 'package:flutter/material.dart';

import '../constants.dart';

class AboutUS extends StatelessWidget {
  static const String id = 'about_us';

  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "about_US")),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/1.png',
            fit: BoxFit.fill,
            height: height * 0.2,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            color: AppColors.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTranslated(context, 'about_us_content'),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColorBlack,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              color: AppColors.cardColor,
              child:const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(
                  "للدفع الالكتروني :\n"
                      "كاش ام تي ان  :*2021#\n كاش سيرياتيل  :*3040#\n بنك بيمو : 7777777\n رقم للحوالات المالية :0998856712",
                  textAlign: TextAlign.justify,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorBlack,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
