import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/address.dart';
import 'package:store/models/user.dart';

@lazySingleton
class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }


  static const String UserKey = 'user';
  static const String UserAddressesKey = 'addresses';
  static const String defaultAddressKey = 'defaultAddressId';

  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  set user(User userToSave) {
    saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
  }

  dynamic _getFromDisk(String key) {
    var value  = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void saveStringToDisk(String key, String content){
    print('(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    _preferences.setString(key, content);
  }



  List get userAddresses {
    var userAddressesJson = _getFromDisk(UserAddressesKey);
    if (userAddressesJson == null) {
      return null;
    }

    return json.decode(userAddressesJson).toList();
  }

  set userAddresses(addressList) {
    saveStringToDisk(UserAddressesKey, json.encode(addressList));
  }

  String get defaultAddressId {
    var defaultAddressJson = _getFromDisk(defaultAddressKey);
    if (defaultAddressJson == null) {
      return null;
    }

    return json.decode(defaultAddressJson);
  }

  set defaultAddressId(id) {
    saveStringToDisk(defaultAddressKey, json.encode(id));
  }

  get deviceToken {
    var deviceToken = _getFromDisk(Constants.DEVICE_TOKEN);
    if (deviceToken == null) {
      return null;
    }

    return deviceToken;
  }

}


