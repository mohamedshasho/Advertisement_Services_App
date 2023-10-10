import 'package:auth/pages/ads_campaign_page.dart';
import 'package:auth/pages/ads_examples_screen.dart';
import 'package:auth/pages/home_screen.dart';
import 'package:auth/pages/settings_page.dart';
import 'package:flutter/foundation.dart';

import '../pages/contract_page.dart';

class DrawerProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  List pages = [
    const HomeScreen(),
    const ContractScreen(),
    const ADsCampaignScreen(),
    const ADsExamplesScreen(),
    const SettingPage(),
  ];
  List<String> titles = [
    "main",
    "invoice_book",
    "order_book",
    "Ads_Examples",
    "Settings",
  ];

  void changePage(int index) {
    _index = index;
    notifyListeners();
  }
}
