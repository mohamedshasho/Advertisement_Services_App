

import 'package:auth/providers/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key? key}) : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String? language;
  final List<String> langCode = ["en", "ar"];
  @override
  void didChangeDependencies() {
    language = context.read<LanguageProvider>().direction;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        getTranslated(context, 'choose_Language'),
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          RadioListTile(
              title: Text('English'),
              value: 'en',
              groupValue: language,
              onChanged: (val) {
                setState(() {
                  language = val.toString();
                  _changeLan(langCode[0]);
                });
              }),
          RadioListTile(
              title: Text('Arabic'),
              value: 'ar',
              groupValue: language,
              onChanged: (val) {
                setState(() {
                  language = val.toString();
                  _changeLan(langCode[1]);
                });
              }),
        ],
      ),
    );
  }

  void _changeLan(String language) async {
    Locale _locale = await setLocale(language);
    MyApp.setLocale(context, _locale);
  }
}
