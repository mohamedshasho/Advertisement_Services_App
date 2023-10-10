import 'pages/about_app.dart';
import 'pages/about_us.dart';
import 'pages/select_ads_details.dart';
import 'pages/start_Ad_campaign.dart';
import 'pages/home_screen.dart';
import 'pages/start_page.dart';
import 'providers/ADsProvider.dart';
import 'providers/AuthProvider.dart';
import 'providers/DrawerProvider.dart';
import 'providers/LanguageProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';
import 'constants.dart';
import 'pages/AddADCampaign.dart';
import 'pages/EditAccountPage.dart';
import 'pages/SelectADsTypes.dart';
import 'pages/ads_campaign_page.dart';
import 'pages/ads_examples_screen.dart';
import 'pages/contract_page.dart';
import 'pages/example.dart';
import 'pages/settings_page.dart';
import 'pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'providers/AdsCampiagnProvider.dart';
import 'providers/ContractProvider.dart';
import 'services/api_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  pref.then((value) {

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(ApiRequest())..initial(value)),
        ChangeNotifierProvider<AdsProvider>(
            create: (_) => AdsProvider()..getData()),
        ChangeNotifierProvider<AdsCampaignProvider>(
            create: (_) => AdsCampaignProvider()),
        ChangeNotifierProvider<DrawerProvider>(create: (_) => DrawerProvider()),
        ChangeNotifierProvider<ContractProvider>(create: (_) => ContractProvider()..getContract()),
        ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    if (mounted) {
      setState(() {
        context.read<LanguageProvider>().setDirection(locale.languageCode);
        _locale = locale;
      });
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      context.read<LanguageProvider>().setDirection(locale.languageCode);
      if (mounted) {
        setState(() {
          _locale = locale;
        });
      }
    });
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale, //, for default language app
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: StartPage.id,
      routes: {
        SignUpScreen.id: (context) => const SignUpScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        StartPage.id: (context) => const StartPage(),
        ADsExamplesScreen.id: (context) => const ADsExamplesScreen(),
        Login.id: (context) => const Login(),
        StartAdCampaign.id: (context) => const StartAdCampaign(),
        SettingPage.id: (context) => const SettingPage(),
        Example.id: (context) => const Example(),
        SelectAdsDetails.id: (context) => const SelectAdsDetails(),
        AddADCampaign.id: (context) => const AddADCampaign(),
        ADsCampaignScreen.id: (context) => const ADsCampaignScreen(),
        SelectAdsTypes.id: (context) => const SelectAdsTypes(),
        ContractScreen.id: (context) => const ContractScreen(),
        AboutApp.id: (context) => const AboutApp(),
        AboutUS.id: (context) => const AboutUS(),
        EditAccount.id: (context) => const EditAccount(),
      },
    );
  }
}
