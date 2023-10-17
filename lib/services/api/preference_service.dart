import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/constant.dart';

class PreferenceService {
  static void UpdateEcoleIdsKey(List<String> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    var list = data.join(',');
    await preferences.setString(Constant.EleveIdsKey, list);
  }

  static void UpdateEleveIdsKey(List<String> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var list = data.join(',');
    await preferences.setString(Constant.EleveIdsKey, list);
  }

  static void UpdatePseudoKey(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.PseudoKey, data);
  }

  static Future<String?> GetParendId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentIdKey));
  }

  static Future<String?> GetParendName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentNameKey));
  }

  static void SetParendId(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentNameKey, data);
  }

  static void SetParendParentName(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentNameKey, data);
  }

  static void SetParentParentNom(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentNomKey, data);
  }

  static void SetParentParentPrenom(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentPrenomKey, data);
  }

  static void SetParentParentContact(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentContactKey, data);
  }

  static Future<String?> GetParendPseudo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentPseudoKey));
  }

  static Future<String?> GetParendPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentPasswordKey));
  }

  static void SetParendParentPseudo(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentPseudoKey, data);
  }

  static void SetParendParentPassword(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParentPasswordKey, data);
  }

  static void SetNotificationPreference(bool data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setBool(Constant.NotificationKey, data);
  }

  static void SetConnexionPreference(bool data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setBool(Constant.ConnexionKey, data);
  }

  static Future<bool?> getNotificationPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getBool(Constant.NotificationKey));
  }

  static Future<bool?> getConnexionPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getBool(Constant.ConnexionKey));
  }

  static Future<String?> getParentNom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentNomKey));
  }

  static Future<String?> getParentPrenom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentPrenomKey));
  }

  static Future<String?> getParentContact() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParentContactKey));
  }
}
