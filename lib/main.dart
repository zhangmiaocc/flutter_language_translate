import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterapplanguage/utils/colors.dart';
import 'package:flutterapplanguage/utils/localization/flutter_translate.dart';
import 'package:flutterapplanguage/utils/shared_preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US', 'zh', 'ar'],
  );
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  LocalizationDelegate _localizationDelegate;

  @override
  void initState() {
    super.initState();
    _localizationDelegate = LocalizedApp.of(context).delegate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          _localizationDelegate
        ],
        supportedLocales: _localizationDelegate.supportedLocales,
        locale: _localizationDelegate.currentLocale,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('helloName')),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: YColors.color_FF5F6D,
              child: Text(
                "英语",
                style: TextStyle(
                  fontSize: 24,
                  color: YColors.color_FFFFFF,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                changeLocale(context, "en");
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString(SharedPreferencesConfig.currentLanguage, "en");
              },
            ),
            FlatButton(
              color: YColors.color_FFAFB6,
              child: Text(
                "中文",
                style: TextStyle(
                  fontSize: 24,
                  color: YColors.color_FFFFFF,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                changeLocale(context, "zh");
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString(SharedPreferencesConfig.currentLanguage, "zh");
              },
            ),
            FlatButton(
              color: YColors.color_FFCBCF,
              child: Text(
                "阿语",
                style: TextStyle(
                  fontSize: 24,
                  color: YColors.color_FFFFFF,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                changeLocale(context, "ar");
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString(SharedPreferencesConfig.currentLanguage, "ar");
              },
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: Text(
                translate('contentName'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
