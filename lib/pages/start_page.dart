import 'package:auth/providers/DrawerProvider.dart';
import 'package:auth/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class StartPage extends StatelessWidget {
  static const String id = "StartPage";

  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Consumer<DrawerProvider>(
          builder: (ctx, data, _) =>
              Text(getTranslated(context, data.titles[data.index])),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Consumer<DrawerProvider>(
        builder: (context, data, _) {
          return data.pages[data.index];
        },
      ),
    );
  }
}
