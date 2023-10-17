class EtudiantCompta {
  String EtudiantId;
  String EtudiantNom;
  String EtudiantPrenom;
  String EtudiantMatricule;
  String EtudiantTotalPaye;
  String EtudiantTotalImpaye;
  String EtudiantTotalRestant;

  EtudiantCompta({
    required this.EtudiantId,
    required this.EtudiantNom,
    required this.EtudiantPrenom,
    required this.EtudiantMatricule,
    required this.EtudiantTotalPaye,
    required this.EtudiantTotalImpaye,
    required this.EtudiantTotalRestant,
  });

  static fromJson(Map json) {
    return EtudiantCompta(
      EtudiantId: json["etudiantId"],
      EtudiantNom: json["etudiantNom"],
      EtudiantPrenom: json["etudiantPrenom"],
      EtudiantMatricule: json["etudiantMatricule"],
      EtudiantTotalPaye: json["etudiantTotalPaye"],
      EtudiantTotalImpaye: json["etudiantTotalImpaye"],
      EtudiantTotalRestant: json["etudiantTotalRestant"],
    );
  }

  static fromSQL(Map json) {
    return EtudiantCompta(
      EtudiantId: json["EtudiantId"],
      EtudiantNom: json["EtudiantNom"],
      EtudiantPrenom: json["EtudiantPrenom"],
      EtudiantMatricule: json["EtudiantMatricule"],
      EtudiantTotalPaye: json["EtudiantTotalPaye"],
      EtudiantTotalImpaye: json["EtudiantTotalImpaye"],
      EtudiantTotalRestant: json["EtudiantTotalRestant"],
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM EtudiantCompta WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM EtudiantCompta
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO EtudiantCompta(EtudiantId, EtudiantNom, EtudiantPrenom, EtudiantMatricule, EtudiantTotalImpaye, EtudiantTotalPaye, EtudiantTotalRestant) VALUES(?, ?, ?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table EtudiantCompta(
      EtudiantId Text PRIMARY KEY, EtudiantNom TEXT, EtudiantPrenom TEXT, EtudiantTotalImpaye TEXT, EtudiantTotalPaye TEXT, 
      EtudiantMatricule TEXT, EtudiantTotalRestant TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE EtudiantCompta SET EtudiantNom = ?, EtudiantPrenom = ?, EtudiantMatricule = ?, EtudiantTotalImpaye = ?, EtudiantTotalPaye = ?, EtudiantTotalRestant = ? WHERE EtudiantId = ?
""";
  }

  static Map<String, dynamic> toJson(EtudiantCompta Etudiant) {
    return {
      "EtudiantId": Etudiant.EtudiantId,
      "EtudiantNom": Etudiant.EtudiantNom,
      "EtudiantPrenom": Etudiant.EtudiantPrenom,
      "EtudiantMatricule": Etudiant.EtudiantMatricule,
      "EtudiantTotalImpaye": Etudiant.EtudiantTotalImpaye,
      "EtudiantTotalPaye": Etudiant.EtudiantTotalPaye,
      "EtudiantTotalRestant": Etudiant.EtudiantTotalRestant,
    };
  }

  static List<Object> toSQLData(EtudiantCompta Etudiant) {
    return [
      Etudiant.EtudiantId,
      Etudiant.EtudiantNom,
      Etudiant.EtudiantPrenom,
      Etudiant.EtudiantMatricule,
      Etudiant.EtudiantTotalImpaye,
      Etudiant.EtudiantTotalPaye,
      Etudiant.EtudiantTotalRestant,
    ];
  }

  static List<Object> toUpdateSQLData(EtudiantCompta Etudiant) {
    return [
      Etudiant.EtudiantNom,
      Etudiant.EtudiantPrenom,
      Etudiant.EtudiantMatricule,
      Etudiant.EtudiantTotalImpaye,
      Etudiant.EtudiantTotalPaye,
      Etudiant.EtudiantTotalRestant,
      Etudiant.EtudiantId,
    ];
  }
}
