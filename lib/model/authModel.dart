class LoginDTO {
  String Pseudo;
  String Password;

  LoginDTO({required this.Pseudo, required this.Password});
}

class RegisterDTO {
  String Nom;
  String Prenom;
  String Contact;
  String Pseudo;
  String Password;

  RegisterDTO(
      {required this.Nom,
      required this.Prenom,
      required this.Contact,
      required this.Pseudo,
      required this.Password});
}

class ParentAddEleveDTO {
  String EleveCode;
  String EcoleCode;
  String EleveNom;
  String ElevePrenom;
  DateTime EleveNaissance;

  ParentAddEleveDTO(
      {required this.EcoleCode,
      required this.EleveCode,
      required this.EleveNom,
      required this.ElevePrenom,
      required this.EleveNaissance});
}
