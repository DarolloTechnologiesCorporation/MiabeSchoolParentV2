import 'dart:convert';

import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/model/authModel.dart';
import 'package:http/http.dart' as http;

import 'preference_service.dart';

class AuthService {
  Future<bool> login(LoginDTO login) async {
    var client = http.Client();
    String link = "${Constant.API_LINK}/parents/account/login";
    var response = await client.post(
      Uri.parse(link),
      body: jsonEncode(
        {"Pseudo": login.Pseudo, "Password": login.Password},
      ),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      Constant.TOKEN = temp["token"];
      PreferenceService.UpdatePseudoKey(login.Pseudo);
      PreferenceService.SetParendId(temp["id"]);
      PreferenceService.UpdatePasswordKey(login.Password);
      // var matricules = temp["matricules"] as List<String>;
      // PreferenceService.UpdateEcoleIdsKey(matricules);
      return true;
    }
    return false;
  }

  Future<bool> register(RegisterDTO registerDTO) async {
    String link = "${Constant.API_LINK}/parents/account/register";
    try {
      var response = await http.post(Uri.parse(link),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: jsonEncode({
            "Pseudo": registerDTO.Pseudo,
            "Password": registerDTO.Password,
            "Nom": registerDTO.Nom,
            "Prenom": registerDTO.Prenom,
            "Contact": registerDTO.Contact,
          }));

      if (response.statusCode == 200) {
        PreferenceService.SetParendParentName(
            "${registerDTO.Nom} ${registerDTO.Prenom}");
        PreferenceService.SetParendParentPseudo(registerDTO.Pseudo);
        setParentInfo(registerDTO);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> checkPseudoValidity(String pseudo) async {
    String link = "${Constant.API_LINK}/parents/account/pseudo-check/$pseudo";
    try {
      var response = await http.get(
        Uri.parse(link),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print(e);
    }
    return false;
  }

  setParentInfo(RegisterDTO registerDTO) {
    PreferenceService.SetParentParentNom(registerDTO.Nom);
    PreferenceService.SetParentParentPrenom(registerDTO.Prenom);
    PreferenceService.SetParentParentContact(registerDTO.Contact);
  }

  updateParentInfo(UpdateInfoDTO updateInfoDTO) {
    if (updateInfoDTO.Nom != null) {
      PreferenceService.SetParentParentNom(updateInfoDTO.Nom!);
    }
    if (updateInfoDTO.Prenom != null) {
      PreferenceService.SetParentParentPrenom(updateInfoDTO.Prenom!);
    }
    if (updateInfoDTO.Contact != null) {
      PreferenceService.SetParentParentContact(updateInfoDTO.Contact!);
    }
  }

  Future<bool> updateInfo(UpdateInfoDTO registerDTO) async {
    String link = "${Constant.API_LINK}/parents/account/update-info";
    var parenId = await PreferenceService.GetParendId();
    try {
      var response = await http.post(Uri.parse(link),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: jsonEncode({
            "Pseudo": registerDTO.Pseudo,
            "Password": registerDTO.Password,
            "Nom": registerDTO.Nom,
            "Id": parenId,
            "Prenom": registerDTO.Prenom,
            "Contact": registerDTO.Contact,
          }));

      if (response.statusCode == 200) {
        updateParentInfo(registerDTO);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> addEleve(ParentAddEleveDTO eleveDTO) async {
    var client = http.Client();
    var parenId = await PreferenceService.GetParendId();
    String link = "${Constant.API_LINK}/parents/account/add-eleve";
    var response = await client.post(
      Uri.parse(link),
      body: jsonEncode({
        "EleveCode": eleveDTO.EleveCode,
        "EleveNom": eleveDTO.EleveNom,
        "ElevePrenom": eleveDTO.ElevePrenom,
        "ParentId": parenId,
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer ${Constant.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
