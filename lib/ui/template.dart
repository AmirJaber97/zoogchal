import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zoog/app/localization.dart';
import 'package:zoog/app/locator.dart';
import 'package:zoog/app/logger.dart';
import 'package:zoog/caches/preferences.dart';
import 'package:zoog/constants/app_colors.dart';
import 'package:zoog/constants/app_strings.dart';
import 'package:zoog/constants/app_themes.dart';
import 'package:zoog/enums/notifier_state.dart';
import 'package:zoog/providers/lang_provider.dart';
import 'package:zoog/providers/theme_provider.dart';
import 'package:zoog/ui/home/home.dart';
import 'package:zoog/ui/setup/routes.dart';
import 'package:provider/provider.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  var logger = getLogger("Template");

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      logger.i("Connection Status has Changed $result");
      if (result == ConnectivityResult.none) {
        setState(() {
          Get.snackbar("No internet", "Please check your internet connection",
              backgroundColor: kBlackColor, colorText: kWhiteColor);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Preferences preferences = locator<Preferences>();
    var _appLanguage = Provider.of<LanguageProvider>(context);
    Locale _locale;

    return Consumer<ThemeProvider>(builder: (_, themeProviderRef, __) {
      return Consumer<LanguageProvider>(builder: (_, langProviderRef, __) {
        _locale = langProviderRef.appLocale;
        return langProviderRef.state == NotifierState.Loading ||
            langProviderRef.state == NotifierState.Initial
            ? Container(
          color: Colors.grey,
        )
            : GetMaterialApp(
          locale: _locale,
          debugShowCheckedModeBanner: false,
          supportedLocales: [
            Locale('ru', 'RU'),
            Locale('en', 'US'),
            Locale('uk', 'UK')
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (_locale == null) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  _appLanguage.updateLanguage(
                      supportedLocale.toString().substring(0, 2));
                  return supportedLocale;
                } else {
                  _appLanguage.updateLanguage('en');
                }
              }
            }
            return _locale;
          },
          title: AppStrings.appName,
          onGenerateRoute: Routes.generateRoute,
          theme: AppThemes.themeData(themeProviderRef.darkTheme, context),
          home: Scaffold(
            body: preferences.isFirstLaunch() ? HomeView() : HomeView(),
          ),
        );
      });
    });
  }
}