import 'dart:io';

import 'package:auth/providers/ADsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class DesignInfo extends StatefulWidget {
  const DesignInfo({Key? key}) : super(key: key);

  @override
  _DesignInfoState createState() => _DesignInfoState();
}

class _DesignInfoState extends State<DesignInfo> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<AdsProvider>(
      builder: (ctx, data, _) => Column(
        children: [
          // Text(
          //   getTranslated(context,
          //       "we_will_make_a_design_for_you_and_that_will_added_to_invoice"),
          // ),
          const SizedBox(height: 10),
          Text(getTranslated(context, "design_info_for_people")),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
                labelStyle: const TextStyle(color: AppColors.primaryColor),

                label: Text(getTranslated(context, 'Description')),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.assentColor,
                  width: 2,
                ))),
            minLines: 2,
            maxLines: 4,
            onChanged: (v) {
              data.adPurpose = v;
            },
          ),
          const SizedBox(height: 5),
          Text(getTranslated(context, 'design_colors')),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.buttonColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                minimumSize:
                    MaterialStateProperty.all(Size(width, height * 0.04))),
            onPressed: () {
              showColorPicker().then((color) {
                if (color != null) {
                  data.addColor(color);
                }
              });
            },
            child: Text(
              getTranslated(context, 'choose_color'),
              style: const TextStyle(color: AppColors.textColorBlack),
            ),
          ),
          data.colors.isNotEmpty
              ? InkWell(
                  onTap: () {
                    showColorPicker().then((color) {
                      if (color != null) {
                        data.addColor(color);
                      }
                    });
                  },
                  child: Card(
                    color: AppColors.buttonColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: width,
                          ),
                          child: Row(
                            children: data.colors
                                .map((e) => cardColorSelected(
                                      e.value.toRadixString(16),
                                      e,
                                      () {
                                        data.colors.remove(e);
                                        setState(() {});
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 5),
          Text(getTranslated(context, 'logo_user')),
          data.design != null
              ? Image.file(
                  data.design!,
                  fit: BoxFit.fill,
                  height: height * 0.15,
                  width: width * 0.5,
                )
              : const SizedBox(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
            ),
            onPressed: () {
              getImage().then((file) {
                if (file != null) {
                  data.changeDesign(file);
                }
              });
            },
            child: Text(
              getTranslated(context, 'choose_logo'),
              style: const TextStyle(color: AppColors.textColorBlack),
            ),
          ),
        ],
      ),
    );
  }

  Future<Color?> showColorPicker() async {
    Color color = AppColors.assentColor;
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ColorPicker(
                    hexInputBar: true,
                    pickerColor: color,
                    onColorChanged: (v) {
                      color = v;
                    },
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(ctx, color),
                        child: Text(
                          getTranslated(context, 'ok'),
                          style: const TextStyle(color: AppColors.textColorBlack),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () => Navigator.pop(ctx),
                        child: Text(
                          getTranslated(context, 'cancel'),
                          style:
                              const TextStyle(color: AppColors.textColorBlack),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }).then((value) {
      return value;
    });
  }

  Future<File?> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Card cardColorSelected(String title, Color color, Function()? onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            Text(title),
            InkWell(
              onTap: onTap,
              child: const Icon(Icons.clear),
            ),
          ],
        ),
      ),
    );
  }
}
