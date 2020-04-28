import 'dart:async';

import 'package:flutter/services.dart';

class ApplangaFlutter {
  static const MethodChannel _channel =
      const MethodChannel('applanga_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> getString(String key, String defaultValue) async {
    final String version = await _channel.invokeMethod('getString', <String, dynamic>{
      'key': key,
      'defaultValue': defaultValue
    });
    return version;
  }

  static Future<bool> isDebuggerConnected() async {
    final bool b = await _channel.invokeMethod('isDebuggerConnected');
    return b;
  }

  static Future<void> showDraftModeDialog() async {
    await _channel.invokeMethod('showDraftModeDialog');
  }

  static void captureScreenshotWithTag(String tag, bool useOcr,List<String> stringIds){
    _channel.invokeMethod('takeScreenshotWithTag',<String, dynamic>{
      'tag': tag,
      'useOcr': useOcr,
      'stringIds': stringIds
    });
  }

  static Future<Map<String, Map<String,String>>> localizeMap(Map<String, Map<String,String>> map) async {
    Map<dynamic,dynamic> applangaMap = await _channel.invokeMethod("localizeMap", map);

    //we will return this
    Map<String, Map<String,String>> result =  Map<String, Map<String,String>>();

    applangaMap.forEach((locale,valueMap) {
      assert(locale.runtimeType == String);
      Map<String,String> entriesForLocaleMap = Map<String,String>();
      applangaMap[locale].forEach((key,value){
        assert(key.runtimeType == String);
        assert(value.runtimeType == String);

        entriesForLocaleMap.putIfAbsent(key, ()=>value);
      });
      result.putIfAbsent(locale, ()=>entriesForLocaleMap);
    });

    return result;
  }

  static Future<bool> update() async {
    return await _channel.invokeMethod('update');
  }
  static Future<void> setScreenShotMenuVisible(bool visable) async {
    if(visable)
    {
      return await _channel.invokeMethod('showScreenShotMenu');
    }
    else
      {
        return await _channel.invokeMethod('hideScreenShotMenu');

      }
  }
}
