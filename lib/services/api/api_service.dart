import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_prokit/model/etudiant_note.dart';
import 'package:type_plus/type_plus.dart';

import '../../helpers/constant.dart';

class ApiService {
  Future<List<T>?> getApiRequest<T>(T Function(Map json) fromJson) async {
    var client = http.Client();
    var name = T.name;
    if (name.substring(name.length) != "s") {
      name = "${name}s";
    }
    String link = "${Constant.API_LINK}/parents/data/${name}";
    var response = await client.get(Uri.parse(link), headers: {
      'Authorization': 'Bearer ${Constant.TOKEN}',
    });

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      var data = <T>[];
      for (var element in temp) {
        data.add(fromJson(element));
      }
      return data;
    }
    return null;
  }

  Future<List<T>?> getApiRequestWithData<T>(
      T Function(Map json) fromJson, String data) async {
    var client = http.Client();
    var name = T.name;
    if (name.substring(name.length) != "s") {
      name = "${name}s";
    }
    String link = "${Constant.API_LINK}/parents/data/${name}/$data";
    var response = await client.get(Uri.parse(link), headers: {
      'Authorization': 'Bearer ${Constant.TOKEN}',
    });

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      var data = <T>[];
      for (var element in temp) {
        data.add(fromJson(element));
      }
      return data;
    }
    return null;
  }

  Future<EtudiantNote?> getEtudiantNote(
      String etudiantId, String periodeId) async {
    var client = http.Client();

    String link =
        "${Constant.API_LINK}/parents/data/Compositions/$etudiantId/$periodeId";
    var response = await client.get(Uri.parse(link), headers: {
      'Authorization': 'Bearer ${Constant.TOKEN}',
    });

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      return EtudiantNote.fromJson(temp);
    }
    return null;
  }
}
