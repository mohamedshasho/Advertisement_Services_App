import 'package:auth/model/Response.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'start_page.dart';

class AddADCampaign extends StatelessWidget {
  static const String id = 'addAdCampaign';

  const AddADCampaign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Complete_the_order")),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Consumer<AdsProvider>(
        builder: (c, ads, _) {
          return Column(
            children: [
              Text(getTranslated(context, "Payment_type")),
              RadioListTile<int>(
                value: 1,
                activeColor: AppColors.iconColor,
                title: Text(getTranslated(context, "cash")),
                groupValue: ads.priceType,
                onChanged: (v) {
                  ads.changePriceType(v!);
                },
              ),
              RadioListTile<int>(
                value: 2,
                activeColor: AppColors.iconColor,
                title: Text(getTranslated(context, "electronic")),
                groupValue: ads.priceType,
                onChanged: (v) {
                  ads.changePriceType(v!);
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: AppColors.assentColor),
                    label: Text(
                      getTranslated(
                          context, "(Optional)_Description_of_the_ad"),
                      style: const TextStyle(color: AppColors.primaryColor),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ))),
                minLines: 3,
                maxLines: 5,
                onChanged: (v) {
                  ads.setDescription(v);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.darkPrimaryColor),
                ),
                onPressed: () async {
                  Response res = await ads.addAdsCampaign();

                  if (res.status == true) {
                    showMessage(context, res.message!);
                    ads.clear();
                    Navigator.pushNamedAndRemoveUntil(
                        context, StartPage.id, (route) => false);
                  } else {
                    showMessage(context, res.message!);
                  }
                },
                child: Text(getTranslated(context, "order_registration")),
              )
            ],
          );
        },
      ),
    );
  }

  showMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
        elevation: 5,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }
}
