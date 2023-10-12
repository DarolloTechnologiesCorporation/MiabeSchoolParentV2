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

class UpdateInfoDTO {
  String? Nom;
  String? Prenom;
  String? Contact;
  String? Pseudo;
  String? Password;
  String? OldPassword;
  UpdateInfoDTO();
}

class ParentAddEleveDTO {
  String EleveCode;
  String EleveNom;
  String ElevePrenom;

  ParentAddEleveDTO({
    required this.EleveCode,
    required this.EleveNom,
    required this.ElevePrenom,
  });
}
