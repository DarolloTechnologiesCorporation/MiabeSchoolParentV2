class Etudiant {
  String Id;
  String Nom;
  String Prenom;
  String Salle;

  Etudiant({
    required this.Id,
    required this.Nom,
    required this.Prenom,
    required this.Salle,
  });

  static fromJson(Map json) {
    return Etudiant(
        Id: json["Id"],
        Nom: json["Nom"],
        Prenom: json["Prenom"],
        Salle: json["Salle"]);
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
    INSERT INTO Etudiant(Id, Nom, Prenom, Salle) VALUES(?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Etudiant(
      Id Text PRIMARY KEY, Nom TEXT, Prenom TEXT, Salle TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Etudiant SET Nom = ?, Prenom = ?, Salle = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Etudiant Etudiant) {
    return {
      "Id": Etudiant.Id,
      "Nom": Etudiant.Nom,
      "Prenom": Etudiant.Prenom,
      "Salle": Etudiant.Salle,
    };
  }

  static List<Object> toSQLData(Etudiant Etudiant) {
    return [
      Etudiant.Id,
      Etudiant.Nom,
      Etudiant.Prenom.toString(),
      Etudiant.Salle.toString(),
    ];
  }
}
