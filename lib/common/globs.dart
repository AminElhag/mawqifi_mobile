import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mawqifi/main.dart';

class Globs {
  static const appName = "Mawqifi";

  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  static void showHUD({String status = "loading ..."}) {
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  static void udSet(dynamic data, String key) {
    var jsonString = json.encode(data);
    preferences?.setString(key, jsonString);
  }

  static void udStringSet(String data, String key) {
    preferences?.setString(key, data);
  }

  static void udBoolSet(bool data, String key) {
    preferences?.setBool(key, data);
  }

  static void udIntSet(int data, String key) {
    preferences?.setInt(key, data);
  }

  static void udDoubleSet(double data, String key) {
    preferences?.setDouble(key, data);
  }

  static dynamic udValue(String key) {
    return json.decode(preferences?.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return preferences?.get(key) as String? ?? "";
  }

  static bool udValueBool(String key) {
    return preferences?.getBool(key) ?? false;
  }

  static bool udValueTureBool(String key) {
    return preferences?.getBool(key) ?? true;
  }

  static int udValueInt(String key) {
    return preferences?.getInt(key) ?? 0;
  }

  static double udValueDouble(String key) {
    return preferences?.getDouble(key) ?? 0.0;
  }

  static void udRemoveKey(String key) {
    preferences?.remove(key);
  }

  static Future<bool>? udClearAllKey() {
    return preferences?.clear();
  }

  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      return "";
    }
  }
}

class SVKey {
  static const mainUrl = "http://192.168.128.44:9215";
  static const baseUrl = "$mainUrl/api/";
  static const nodeUrl = mainUrl;
  static const authBaseUrl = "${baseUrl}auth/";

  static const svLogin = "${baseUrl}login";
  static const svMobileLogin = "${authBaseUrl}mobile";
  static const svOtp = "${authBaseUrl}otp/verification";

  static const svCreateProfile = "${baseUrl}profile";
  static const svVehicle = "${svCreateProfile}/vehicle";

  static const svGetNearbyParking = "${baseUrl}parking";
  static const svGetParkingDetails = "${svGetNearbyParking}/details";

  static const svBooking = "${baseUrl}booking";
}

class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";

  static const authToken = "auth_token";
}

class Message {
  static const success = "success";
  static const fail = "fail";
}

class PreferenceKey {
  static const userLogin = "USER_LOGIN";
  static const genderTypeId = "GENDER_TYPE_ID";
  static const phoneNumber = "PHONE_NUMBER";
  static const fullName = "FULL_NAME";
  static const homeAddress = "HOME_ADDRESS";
  static const userId = "USER_ID";
  static const token = "token";
}
