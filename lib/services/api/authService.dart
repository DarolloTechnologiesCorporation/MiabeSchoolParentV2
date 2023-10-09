import 'dart:convert';

import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/model/authModel.dart';
import 'package:http/http.dart' as http;

import 'preference_service.dart';

class AuthService {
  Future<bool> login(LoginDTO login) async {
    var client = http.Client();
    String link = "${Constant.API_LINK}/parents/account/login";
    var response = await client.post(Uri.parse(link),
        body: {"Pseudo": login.Pseudo, "Password": login.Password});

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      Constant.TOKEN = temp["Token"];
      PreferenceService.UpdatePseudoKey(login.Pseudo);
      PreferenceService.SetParendId(temp["Id"]);
      PreferenceService.UpdatePasswordKey(login.Password);
      var matricules = temp["Matricules"] as List<String>;
      PreferenceService.UpdateEcoleIdsKey(matricules);
      return true;
    }
    return false;
  }

  Future<bool> register(RegisterDTO registerDTO) async {
    var client = http.Client();
    String link = "${Constant.API_LINK}/parents/account/register";
    var response = await client.post(Uri.parse(link), body: {
      "Pseudo": registerDTO.Pseudo,
      "Password": registerDTO.Password,
      "Nom": registerDTO.Nom,
      "Prenom": registerDTO.Prenom,
      "Contact": registerDTO.Contact,
    });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> addEleve(ParentAddEleveDTO eleveDTO) async {
    var client = http.Client();
    var parenId = await PreferenceService.GetParendId();
    String link = "${Constant.API_LINK}/parents/account/add-eleve";
    var response = await client.post(Uri.parse(link), body: {
      "EleveCode": eleveDTO.EleveCode,
      "EcoleCode": eleveDTO.EcoleCode,
      "EleveNom": eleveDTO.EleveNom,
      "ElevePrenom": eleveDTO.ElevePrenom,
      "ParentId": parenId,
      "EleveNaissance": eleveDTO.EleveNaissance,
    });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
