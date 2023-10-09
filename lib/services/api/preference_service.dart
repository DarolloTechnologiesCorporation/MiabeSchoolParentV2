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

  static void UpdatePasswordKey(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.EcoleIdsKey, data);
  }

  static Future<String?> GetParendId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return (await preferences.getString(Constant.ParendIdKey));
  }

  static void SetParendId(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    await preferences.setString(Constant.ParendIdKey, data);
  }
}
