import 'package:auth/pages/login_page.dart';
import 'package:auth/providers/AuthProvider.dart';
import 'package:auth/providers/DrawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:auth/constants.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthProvider>();
    var drawer = context.read<DrawerProvider>();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              drawer.changePage(4);
              Navigator.pop(context);
            },
            title: Text(
              getTranslated(context, "Settings"),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.iconColor,
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            leading: const Icon(
              Icons.settings,
              color: AppColors.iconColor,
            ),
          ),
          const Divider(
            endIndent: 30,
            indent: 30,
            color: AppColors.darkPrimaryColor,
            thickness: 2,
          ),
          ListTile(
            onTap: () {
              if (auth.user == null) {
                Navigator.pushNamed(context, Login.id);
              } else {
                drawer.changePage(1);
                Navigator.pop(context);
              }
            },
            title: Text(
              getTranslated(context, "invoice_book"),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.iconColor,
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            leading: const Icon(
              Icons.library_books,
              color: AppColors.iconColor,
            ),
          ),
          const Divider(
            endIndent: 30,
            indent: 30,
            color: AppColors.darkPrimaryColor,
            thickness: 2,
          ),
          ListTile(
            onTap: () {
              if (auth.user == null) {
                Navigator.pushNamed(context, Login.id);
              } else {
                drawer.changePage(2);
                Navigator.pop(context);
              }
            },
            title: Text(
              getTranslated(context, "order_book"),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.iconColor,
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            leading: const Icon(
              Icons.wysiwyg,
              color: AppColors.iconColor,
            ),
          ),
          const Divider(
            endIndent: 30,
            indent: 30,
            color: AppColors.darkPrimaryColor,
            thickness: 2,
            height: 20,
          ),
          ListTile(
            onTap: () {
              drawer.changePage(3);
              Navigator.pop(context);
            },
            title: Text(
              getTranslated(context, "Ads_Examples"),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.iconColor,
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            leading: const Icon(
              Icons.computer,
              color: AppColors.iconColor,
            ),
          ),
          const Divider(
            endIndent: 30,
            indent: 30,
            color: AppColors.darkPrimaryColor,
            thickness: 2,
            height: 20,
          ),
          ListTile(
            onTap: () {
              drawer.changePage(0);
              Navigator.pop(context);
            },
            title: Text(
              getTranslated(context, "main"),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.iconColor,
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            leading: const Icon(
              Icons.home,
              color: AppColors.iconColor,
            ),
          ),


        ],
      ),
    );
  }
}
