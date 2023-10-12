class Etudiant {
  String Id;
  String Nom;
  String Matricule;
  String EcoleMatricule;
  String Prenom;
  String Salle;
  String Sexe;

  Etudiant({
    required this.Id,
    required this.Nom,
    required this.Prenom,
    required this.EcoleMatricule,
    required this.Matricule,
    required this.Salle,
    required this.Sexe,
  });

  static fromJson(Map json) {
    return Etudiant(
      Id: json["etudiantId"],
      Nom: json["nom"],
      Prenom: json["prenom"],
      Matricule: json["matricule"],
      EcoleMatricule: json["ecoleMatricule"],
      Salle: json["classe"],
      Sexe: json["sexe"],
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM Etudiant WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM Etudiant
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO Etudiant(Id, Nom, Prenom, Salle, EcoleMatricule, Matricule, Sexe) VALUES(?, ?, ?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Etudiant(
      Id Text PRIMARY KEY, Nom TEXT, Prenom TEXT, Salle TEXT, EcoleMatricule TEXT, Matricule TEXT
      , Sexe TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Etudiant SET Nom = ?, Prenom = ?, Salle = ?, EcoleMatricule = ?, Matricule = ?, Sexe = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Etudiant Etudiant) {
    return {
      "Id": Etudiant.Id,
      "Nom": Etudiant.Nom,
      "Prenom": Etudiant.Prenom,
      "Matricule": Etudiant.Matricule,
      "EcoleMatricule": Etudiant.EcoleMatricule,
      "Salle": Etudiant.Salle,
      "Sexe": Etudiant.Sexe,
    };
  }

  static List<Object> toSQLData(Etudiant Etudiant) {
    return [
      Etudiant.Nom,
      Etudiant.Prenom.toString(),
      Etudiant.Salle.toString(),
      Etudiant.EcoleMatricule,
      Etudiant.Matricule,
      Etudiant.Sexe,
      Etudiant.Id,
    ];
  }
}
