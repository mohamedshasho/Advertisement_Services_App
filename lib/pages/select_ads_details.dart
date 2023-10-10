import 'dart:io';

import 'package:auth/constants.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:auth/widgets/DesignInfo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'SelectADsTypes.dart';

class SelectAdsDetails extends StatefulWidget {
  static const String id = 'selectads';

  const SelectAdsDetails({Key? key}) : super(key: key);

  @override
  State<SelectAdsDetails> createState() => _SelectAdsDetailsState();
}

class _SelectAdsDetailsState extends State<SelectAdsDetails> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    List<String> date =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          getTranslated(context, "Choose_and_Select"),
          style: TextStyle(color: AppColors.textColorBlack),
        ),
        centerTitle: true,
      ),
      body: Consumer<AdsProvider>(
        builder: (ctx, data, _) {
          if (data.dataAds == null) {
            return const Center(child: CircularProgressIndicator());
          }
          List<String>? specialties = data.dataAds!.specialties!;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(getTranslated(context, "purpose")),
                DropdownButton<String>(
                  style: const TextStyle(
                      color: AppColors.darkPrimaryColor, fontSize: 18),
                  isExpanded: true,
                  elevation: 5,
                  value: data.specialty,
                  items: specialties
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    data.changeSpecialty(val!);
                  },
                ),
                Text(getTranslated(context, "AD")),
                RadioListTile(
                  value: '1',
                  title: Text(getTranslated(context, "I_have_a_design")),
                  activeColor: AppColors.iconColor,
                  groupValue: data.haveDesign,
                  onChanged: (v) {
                    data.changeHaveDesign(v.toString());
                  },
                ),
                RadioListTile(
                  value: '0',
                  title: Text(getTranslated(context, "I_don't_have_a_design")),
                  groupValue: data.haveDesign,
                  activeColor: AppColors.iconColor,
                  onChanged: (v) {
                    data.changeHaveDesign(v.toString());
                  },
                ),
                data.design != null && data.haveDesign == '1'
                    ? Image.file(
                        data.design!,
                        height: height * 0.2,
                        width: width,
                      )
                    : const SizedBox(),
                data.haveDesign == '1'
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.buttonColor),
                        ),
                        onPressed: () {
                          getImage().then((file) {
                            if (file != null) {
                              data.changeDesign(file);
                            }
                          });
                        },
                        child: Text(
                          getTranslated(context, "Select_Design"),
                          style:
                              const TextStyle(color: AppColors.textColorBlack),
                        ),
                      )
                    : const DesignInfo(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.darkPrimaryColor),
                    ),
                    onPressed: () {
                      data.setAdsDetails(
                        date.first,
                        date.last,
                      );
                      if (data.haveDesign == '0') {
                        if (data.adPurpose == null || data.adPurpose!.isEmpty) {
                          showMessage(context, 'يجب كتابة الوصف');
                          return;
                        }
                        if (data.colors.isEmpty) {
                          showMessage(context, 'يجب تحديد الالوان');
                          return;
                        }
                        Navigator.pushNamed(context, SelectAdsTypes.id);
                      } else {
                        if (data.design == null) {
                          showMessage(context, 'يجب تحديد التصميم');
                          return;
                        }
                        Navigator.pushNamed(context, SelectAdsTypes.id);
                      }
                    },
                    child: Text(getTranslated(context, "Next")),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<File?> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  showMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.errorColor,
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
