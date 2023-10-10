import '../constants.dart';
import '../pages/about_app.dart';
import '../pages/login_page.dart';
import '../pages/start_page.dart';
import '../providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/languageDialog.dart';
import 'EditAccountPage.dart';

class SettingPage extends StatelessWidget {
  static const String id = 'SettingsPage';

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthProvider>();
    return Column(children: [
      auth.user == null
          ? const SizedBox()
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, EditAccount.id);
                      },
                      title: Text(getTranslated(context, "Account_Setting")),
                      subtitle: Text(getTranslated(context, "edit_account")),
                      trailing: const Icon(
                        Icons.person,
                        color: AppColors.iconColor,
                      ),
                      leading: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.iconColor,
                      ),
                    ),
                    const Divider(indent: 10, endIndent: 10, thickness: 1),
                  ],
                ),
              ),
            ),
      Container(
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 20,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                onTap: () {},
                title: Text(
                    getTranslated(context, "tell_us_about_an_problem_in_app")),
                trailing: const Icon(
                  Icons.error_outline,
                  color: AppColors.iconColor,
                ),
                leading: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.iconColor,
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return const LanguageDialog();
                      });
                },
                title: Text(
                  getTranslated(context, 'change_language'),
                  textAlign: TextAlign.center,
                ),
                trailing: const Icon(
                  Icons.language,
                  color: AppColors.iconColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AboutApp.id);
                },
                title: Text(getTranslated(context, "about_app")),
                trailing: const Icon(
                  Icons.animation,
                  color: AppColors.iconColor,
                ),
                leading: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.iconColor,
                ),
              ),
              const Divider(indent: 10, endIndent: 10, thickness: 1),
              ListTile(
                onTap: () async {
                  if (auth.user == null) {
                    Navigator.pushNamed(context, Login.id);
                  } else {
                    if (await auth.logout()) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, StartPage.id, (route) => false);
                    }
                  }
                },
                title: auth.user == null
                    ? Text(getTranslated(context, "login"))
                    : Text(getTranslated(context, "Log_out")),
                trailing: const Icon(
                  Icons.add_to_home_screen_outlined,
                  color: AppColors.iconColor,
                ),
                leading: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
