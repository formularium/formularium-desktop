import 'dart:convert';

import 'package:formularium_desktop/models/InstanceSettings.dart';
import 'package:formularium_desktop/models/InstanceStatus.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class PreferencesService {
  static PreferencesService _instance;
  static SharedPreferences _preferences;
  static Future<PreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = PreferencesService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) PreferencesService:_getFromDisk. key: $key value: $value');
    return value;
  }

  Future<void> saveStringToDisk(String key, String content) async {
    print(
        '(TRACE) PreferencesService:_saveStringToDisk. key: $key value: $content');
    await _preferences.setString(key, content);
  }

  static const String InstanceSettingsKey = 'instanceSettings';
  static const String InstanceStatusKey = 'instanceStatus';
  static const String oAuthCredentialsKey = 'authCredentials';

  InstanceSettings get instanceSettings {
    var instanceSettingsJson = _getFromDisk(InstanceSettingsKey);
    if (instanceSettingsJson == null) {
      return null;
    }
    return InstanceSettings.fromJson(json.decode(instanceSettingsJson));
  }

  set instanceSettings(InstanceSettings settingsToSave) {
    saveStringToDisk(InstanceSettingsKey, json.encode(settingsToSave.toJson()));
  }

  InstanceStatus get instanceStatus {
    var intstanceStatusJson = _getFromDisk(InstanceStatusKey);
    if (intstanceStatusJson == null) {
      return null;
    }
    return InstanceStatus.fromJson(json.decode(intstanceStatusJson));
  }

  set instanceStatus(InstanceStatus settingsToSave) {
    saveStringToDisk(InstanceStatusKey, json.encode(settingsToSave.toJson()));
  }

  Credentials get oAuthCredentials {
    var oAuthCredentials = _getFromDisk(oAuthCredentialsKey);

    if (oAuthCredentials == null) {
      return null;
    }
    return oauth2.Credentials.fromJson(json.decode(oAuthCredentials));
  }

  set oAuthCredentials(Credentials oAuthCredentialsToSave) {
    saveStringToDisk(
        oAuthCredentialsKey, json.encode(oAuthCredentialsToSave.toJson()));
  }

  oAuthCredentialsAsync(Credentials oAuthCredentialsToSave) async {
    await saveStringToDisk(
        oAuthCredentialsKey, json.encode(oAuthCredentialsToSave.toJson()));
  }
}
