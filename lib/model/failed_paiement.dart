class FailedPaiementModel {
  String Id;

  FailedPaiementModel({required this.Id});

  static fromSQL(Map json) {
    return FailedPaiementModel(
      Id: json["EtudiantId"].toString(),
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM FailedPaiementModel WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM FailedPaiementModel
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO FailedPaiementModel(Id, Nom, Prenom, Salle, EcoleMatricule, Matricule, Sexe) VALUES(?, ?, ?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table FailedPaiementModel(
      Id Text PRIMARY KEY, Nom TEXT, Prenom TEXT, Salle TEXT, EcoleMatricule TEXT, Matricule TEXT
      , Sexe TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE FailedPaiementModel SET Nom = ?, Prenom = ?, Salle = ?, EcoleMatricule = ?, Matricule = ?, Sexe = ? WHERE id = ?
""";
  }

  static List<Object> toSQLData(FailedPaiementModel failedPaiementModel) {
    return [
      failedPaiementModel.Id,
    ];
  }

  static List<Object> toUpdateSQLData(FailedPaiementModel failedPaiementModel) {
    return [
      failedPaiementModel.Id,
    ];
  }
}
