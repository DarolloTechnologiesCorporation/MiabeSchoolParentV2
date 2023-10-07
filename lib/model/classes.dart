import 'package:uuid/uuid.dart';

class Team {
  Team({
    required this.name,
    required this.points,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.against,
  });

  final String name;
  final int points;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int against;
}

List<Team> teamsData = [
  Team(
      name: 'Mathématique',
      points: 11,
      played: 5,
      won: 3,
      drawn: 2,
      lost: 0,
      against: 4),
  Team(
    name: 'SCience physique',
    points: 10,
    played: 4,
    won: 3,
    drawn: 1,
    lost: 0,
    against: 6,
  ),
  Team(
    name: 'Anglais',
    points: 10,
    played: 4,
    won: 3,
    drawn: 2,
    lost: 0,
    against: 2,
  ),
  Team(
    name: 'SVT',
    points: 9,
    played: 5,
    won: 2,
    drawn: 3,
    lost: 0,
    against: 1,
  ),
  Team(
    name: 'H-G',
    points: 9,
    played: 4,
    won: 3,
    drawn: 0,
    lost: 1,
    against: 4,
  ),
  Team(
    name: 'Français',
    points: 8,
    played: 5,
    won: 2,
    drawn: 2,
    lost: 1,
    against: 6,
  ),
];

// class AnneAcademique {
//   AnneAcademique(
//       {required this.Libelle,
//       required this.id,
//       required this.datedebut,
//       required this.datefin,
//       required this.etat});
//   Uuid id = Uuid();
//   final String Libelle;
//   final DateTime datedebut;
//   final DateTime datefin;
//   final String etat;
// }

// class Classe_matiere {
//   Classe_matiere({required this.id, required this.coef});
//   Uuid id = Uuid();
//   final double coef;
// }

// class ModelClasse {
//   ModelClasse(
//       {required this.Libelle,
//       required this.id,
//       required this.nomclasse,
//       required this.niveau});
//   Uuid id = Uuid();
//   final String Libelle;
//   final String nomclasse;
//   final String niveau;
// }

// class ModelEtudiant {
//   ModelEtudiant(
//       {required this.id,
//       required this.nom,
//       required this.prenom,
//       required this.classe});

//   Uuid id = Uuid();
//   final String nom;
//   final String prenom;
//   final String classe;
// }

// class evalution {
//   evalution({
//     required this.Etat,
//     required this.Note,
//     required this.DateAjout,
//     required this.DateModification,
//     required this.Date,
//     required this.id,
//   });
//   Uuid id = Uuid();
//   final int Etat;
//   final DateTime Date;
//   final double Note;
//   final DateTime DateAjout;
//   final DateTime DateModification;
// }

// class inscription {
//   inscription({required this.DateInscription});
//   final DateTime DateInscription;
// }

// class Matiere {
//   Matiere(
//       {required this.Libelle,
//       required this.etat,
//       required this.id,
//       required this.nom_matiere});
//   Uuid id = Uuid();
//   final String Libelle;
//   final String nom_matiere;
//   final String etat;
// }

// class parent {
//   parent(this.id, this.user_name, this.password);
//   Uuid id = Uuid();
//   final String user_name;
//   final String password;
// }

// class Trimestre {
//   Trimestre({required this.id, required this.nom});
//   int id;
//   final String nom;
// }

// class periodeExamen {
//   periodeExamen(
//       {required this.id,
//       required this.Datedebut,
//       required this.Datefin,
//       required this.Etat,
//       required this.Libelle});
//   Uuid id = Uuid();
//   final String Libelle;
//   final DateTime Datedebut;
//   final DateTime Datefin;
//   final String Etat;
// }
