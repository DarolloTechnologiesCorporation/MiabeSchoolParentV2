class EtudiantPaiement {
  String EtudiantId;
  String EtudiantNom;
  String EtudiantPrenom;
  String EtudiantMatricule;
  String EtudiantSexe;
  String Paiement;

  EtudiantPaiement({
    required this.EtudiantId,
    required this.EtudiantNom,
    required this.EtudiantPrenom,
    required this.EtudiantMatricule,
    required this.EtudiantSexe,
    required this.Paiement,
  });

  static fromJson(Map json) {
    return EtudiantPaiement(
      EtudiantId: json["etudiantId"],
      EtudiantNom: json["etudiantNom"],
      EtudiantPrenom: json["etudiantPrenom"],
      EtudiantMatricule: json["etudiantMatricule"],
      EtudiantSexe: json["etudiantSexe"],
      Paiement: json["paiement"],
    );
  }

  static fromSQL(Map json) {
    return EtudiantPaiement(
      EtudiantId: json["EtudiantId"],
      EtudiantNom: json["EtudiantNom"],
      EtudiantPrenom: json["EtudiantPrenom"],
      EtudiantMatricule: json["EtudiantMatricule"],
      EtudiantSexe: json["EtudiantSexe"],
      Paiement: json["Paiement"],
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM EtudiantPaiement WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM EtudiantPaiement
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO EtudiantPaiement(EtudiantId, EtudiantNom, EtudiantPrenom, Paiement, EtudiantSexe) VALUES(?, ?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table EtudiantPaiement(
      Id INTEGER PRIMARY KEY AUTOINCREMENT,
      EtudiantId Text, EtudiantNom TEXT, EtudiantPrenom TEXT, Paiement TEXT, EtudiantSexe TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE EtudiantPaiement SET EtudiantNom = ?, EtudiantMatricule = ?, Paiement = ?, EtudiantSexe = ? WHERE EtudiantId = ?
""";
  }

  static Map<String, dynamic> toJson(EtudiantPaiement Etudiant) {
    return {
      "EtudiantId": Etudiant.EtudiantId,
      "EtudiantNom": Etudiant.EtudiantNom,
      "EtudiantPrenom": Etudiant.EtudiantPrenom,
      "EtudiantMatricule": Etudiant.EtudiantMatricule,
      "Paiement": Etudiant.Paiement,
      "EtudiantSexe": Etudiant.EtudiantSexe,
    };
  }

  static List<Object> toSQLData(EtudiantPaiement Etudiant) {
    return [
      Etudiant.EtudiantId,
      Etudiant.EtudiantNom,
      Etudiant.EtudiantPrenom,
      Etudiant.EtudiantMatricule,
      Etudiant.Paiement,
      Etudiant.EtudiantSexe,
    ];
  }

  static List<Object> toUpdateSQLData(EtudiantPaiement Etudiant) {
    return [
      Etudiant.EtudiantNom,
      Etudiant.EtudiantPrenom,
      Etudiant.EtudiantMatricule,
      Etudiant.Paiement,
      Etudiant.EtudiantSexe,
      Etudiant.EtudiantId,
    ];
  }
}
