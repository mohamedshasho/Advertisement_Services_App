

import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier
{
  String direction = 'ar';

  void setDirection(String dir) {
    direction = dir;
  }

}