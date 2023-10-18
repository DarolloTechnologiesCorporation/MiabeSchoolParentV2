import 'package:quiz_prokit/model/authModel.dart';

class Constant {
  static String API_LINK = "https://g12z26n1-7252.eun1.devtunnels.ms";
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

  static RegisterDTO registerModel =
      RegisterDTO(Nom: "", Prenom: "", Contact: "", Pseudo: "", Password: "");
}
