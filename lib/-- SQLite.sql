-- SQLite

          CREATE TABLE AnneAcademique (
            id UUID PRIMARY KEY,
            Libelle TEXT,
            datedebut DATETIME,
            datefin DATETIME,
            etat TEXT
          );
        
          CREATE TABLE Classe_matiere (
            id UUID PRIMARY KEY,
            coef REAL
          );
        
          CREATE TABLE ModelClasse (
            id UUID PRIMARY KEY,
            Libelle TEXT,
            nomclasse TEXT,
            niveau TEXT
          );
        
          CREATE TABLE ModelEtudiant (
            id UUID PRIMARY KEY,
            nom TEXT,
            prenom TEXT,
            classe TEXT
          );
        
          CREATE TABLE evalution (
            id UUID PRIMARY KEY,
            Etat DATETIME,
            Date DATETIME,
            Note REAL,
            DateAjout DATETIME,
            DateModification DATETIME
          );
    
        
          CREATE TABLE inscription (
            DateInscription DATETIME PRIMARY KEY
          );
        
          CREATE TABLE Matiere (
            id UUID PRIMARY KEY,
            Libelle TEXT,
            etat TEXT,
            nom_matiere TEXT
          );
        
          CREATE TABLE parent (
            id UUID PRIMARY KEY,
            user_name TEXT,
            password TEXT
          );
        
          CREATE TABLE periodeExamen (
            id UUID PRIMARY KEY,
            Libelle TEXT,
            Datedebut DATETIME,
            Datefin DATETIME,
            Etat TEXT
          );
        
