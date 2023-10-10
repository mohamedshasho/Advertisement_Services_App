import 'package:flutter/material.dart';

import '../constants.dart';

class AboutApp extends StatelessWidget {
  static const String id = 'about_app';

  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "about_app")),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
            height: height * 0.2,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTranslated(context, "about_app_content"),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
