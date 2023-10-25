import 'package:quiz_prokit/model/authModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Constant {
  static String API_LINK = "https://d6wjbjz0-7252.uks1.devtunnels.ms";
  static String API_DB = "app.db";
  static String TOKEN = "";

  static String EcoleIdsKey = "EcoleIdsKey";
  static String EleveIdsKey = "EleveIdsKey";

  static String PseudoKey = "PseudoKey";
  static String PasswordKey = "PasswordKey";

  static String ParentIdKey = "ParendIdKey";
  static String ParentNameKey = "ParendNameKey";
  static String ParentPseudoKey = "ParentPseudoKey";
  static String ParentPasswordKey = "ParentPasswordKey";
  static String ParentNomKey = "ParentPseudoKey";
  static String ParentPrenomKey = "ParentPrenomKey";
  static String ParentContactKey = "ParentContactKey";

  static String PaiementInitKey = "PaiementInitKey";
  static String PaiementDateInitKey = "PaiementDateInitKey";
  static String PaiementVerificationKey = "PaiementVerification";

  static String NotificationKey = "NotificationKey";
  static String ConnexionKey = "ConnexionKey";

  static int PaiementHandlingDelay = 2;
  static int PaiementHandlingVerificationDelay = 1;
  static int PaiementHandlingVerificationIntervale = 1;

  static Future<void> getApiLink() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(
        "https://drive.google.com/uc?export=download&id=1bItMfwKI_Di-n5Q1bLXfMYU3pEfPVION"));
    var temp = json.decode(response.body);
    API_LINK = temp["APILINK"];
  }

  static RegisterDTO registerModel =
      RegisterDTO(Nom: "", Prenom: "", Contact: "", Pseudo: "", Password: "");
}
