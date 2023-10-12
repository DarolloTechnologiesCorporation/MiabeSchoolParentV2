import 'package:quiz_prokit/model/authModel.dart';

class Constant {
  static String API_LINK = "https://b5d4xlzx-7252.eun1.devtunnels.ms";
  static String API_DB = "app.db";
  static String TOKEN = "";
  static String EcoleIdsKey = "EcoleIdsKey";
  static String EleveIdsKey = "EleveIdsKey";
  static String PseudoKey = "PseudoKey";
  static String PasswordKey = "PasswordKey";
  static String ParentIdKey = "ParendIdKey";
  static String ParentNameKey = "ParendNameKey";
  static String ParentPseudoKey = "ParentPseudoKey";
  static String ParentNomKey = "ParentPseudoKey";
  static String ParentPrenomKey = "ParentPseudoKey";
  static String ParentContactKey = "ParentPseudoKey";

  static String NotificationKey = "NotificationKey";
  static String ConnexionKey = "ConnexionKey";

  static RegisterDTO registerModel =
      RegisterDTO(Nom: "", Prenom: "", Contact: "", Pseudo: "", Password: "");
}
