# flutterapplanguage
# 安装，配置和使用

## 安装

将此添加到包的pubspec.yaml文件中：

```
dependencies:
  flutter_translate: <latest version>
```

从命令行（或从您的编辑器）安装软件包：

```
flutter pub get
```

## 组态

导入flutter_translate：

```
导入 'package：flutter_translate / flutter_translate.dart' ;
```

将*json*本地化文件放置在项目中您选择的文件夹中。

默认情况下，`flutter_translate`将`assets/i18n`在项目根目录下的目录中搜索本地化文件。

在中声明您的资产本地化目录 `pubspec.yaml`

```
flutter:
  assets:
    - assets/i18n
```

在主函数中，创建本地化委托并启动应用，然后将其与LocalizedApp包装在一起

```
void main() async
{
  var delegate = await LocalizationDelegate.create(
        fallbackLocale: 'en_US',
        supportedLocales: ['en_US', 'es', 'fa']);

  runApp(LocalizedApp(delegate, MyApp()));
}
```

如果本地化文件的资产目录与默认目录（`assets/i18n`）不同，则需要指定它：

```
var delegate = await LocalizationDelegate.create(
      ...
        basePath: 'assets/i18n/'
      ...
```

示例MyApp：

```dart
 class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Flutter Translate Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
        ),
      );
  }
}
```

<!--more-->

## 用法

翻译一个字符串：

```
translate('your.localization.key');
```

```
translate('your.localization.key', args: {'argName1': argValue1, 'argName2': argValue2});
```

进行多元翻译：

```
translatePlural('plural.demo', yourNumericValue);
```

JSON：

```json
"plural": {
    "demo": {
        "0": "Please start pushing the 'plus' button.",
        "1": "You have pushed the button one time.",
        "else": "You have pushed the button {{value}} times."
    }
}
```

更改语言：

```dart
@override
Widget build(BuildContext context) {
...
  ...
    changeLocale(context, 'en_US');
  ...
...
}
```

# 自动保存和还原所选的语言环境

Flutter Translate可以自动保存选定的语言环境，并在应用程序重新启动后将其还原。

这可以通过在委托创建期间传递ITranslatePreferences的实现来完成：

```
 var delegate = await LocalizationDelegate.create(
      ...
        preferences: TranslatePreferences()
      ...
```

使用[shared_preferences](https://pub.dev/packages/shared_preferences)包的示例实现：

```
import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslatePreferences implements ITranslatePreferences
{
    static const String _selectedLocaleKey = 'selected_locale';

    @override
    Future<Locale> getPreferredLocale() async
    {
        final preferences = await SharedPreferences.getInstance();

        if(!preferences.containsKey(_selectedLocaleKey)) return null;

        var locale = preferences.getString(_selectedLocaleKey);

        return localeFromString(locale);
    }

    @override
    Future savePreferredLocale(Locale locale) async
    {
        final preferences = await SharedPreferences.getInstance();

        await preferences.setString(_selectedLocaleKey, localeToString(locale));
    }
}
```

并且不要忘记在pubspec.yaml中引用shared_preferences包

```
dependencies:
  shared_preferences: <latest version>
```

#####  
