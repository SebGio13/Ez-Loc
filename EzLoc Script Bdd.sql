CREATE TABLE Utilisateur(
   idUtilisateur INT AUTO_INCREMENT,
   nom VARCHAR(100) NOT NULL,
   prenom VARCHAR(100) NOT NULL,
   pseudo VARCHAR(100) NOT NULL,
   Telephone CHAR(10) NOT NULL,
   mail VARCHAR(100) NOT NULL,
   motDePasse VARCHAR(8000) NOT NULL,
   PRIMARY KEY(idUtilisateur),
   UNIQUE(mail),
   UNIQUE(pseudo)
);

CREATE TABLE TypeSalle(
   idType INT AUTO_INCREMENT,
   libelType VARCHAR(100) NOT NULL,
   PRIMARY KEY(idType)
);

CREATE TABLE Genre(
   idGenre INT AUTO_INCREMENT,
   libelGenre VARCHAR(100),
   PRIMARY KEY(idGenre)
);

CREATE TABLE Competition(
   idCompetition INT AUTO_INCREMENT,
   nom VARCHAR(100) NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idCompetition),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE Salle(
   idSalle INT AUTO_INCREMENT,
   nom VARCHAR(100) NOT NULL,
   adresse VARCHAR(100) NOT NULL,
   codePostal CHAR(5) NOT NULL,
   ville VARCHAR(100) NOT NULL,
   capacite INT NOT NULL,
   prixLocation DECIMAL(15,2) NOT NULL,
   idType INT NOT NULL,
   PRIMARY KEY(idSalle),
   FOREIGN KEY(idType) REFERENCES TypeSalle(idType)
);

CREATE TABLE Jeu(
   idJeu INT AUTO_INCREMENT,
   nomJeu VARCHAR(100),
   editeur VARCHAR(100) NOT NULL,
   idGenre INT NOT NULL,
   PRIMARY KEY(idJeu),
   FOREIGN KEY(idGenre) REFERENCES Genre(idGenre)
);

CREATE TABLE Accueillir(
   idCompetition INT,
   idSalle INT,
   dateDebut DATE,
   dateFin DATE NOT NULL,
   PRIMARY KEY(idCompetition, idSalle, dateDebut),
   FOREIGN KEY(idCompetition) REFERENCES Competition(idCompetition),
   FOREIGN KEY(idSalle) REFERENCES Salle(idSalle)
);

CREATE TABLE Participer(
   idCompetition INT,
   idUtilisateur INT,
   PRIMARY KEY(idCompetition, idUtilisateur),
   FOREIGN KEY(idCompetition) REFERENCES Competition(idCompetition),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE Jouer(
   idCompetition INT,
   idJeu INT,
   PRIMARY KEY(idCompetition, idJeu),
   FOREIGN KEY(idCompetition) REFERENCES Competition(idCompetition),
   FOREIGN KEY(idJeu) REFERENCES Jeu(idJeu)
);

-- ####################################################################

INSERT INTO TypeSalle (libelType) VALUES
   ('Salle des fêtes'),
   ('Gymnase'),
   ('Local'),
   ('Stade');

INSERT INTO Genre (libelGenre) VALUES
   ('FPS'),
   ('RTS'),
   ('Versus fighting'),
   ('MOBA'),
   ('TCG');

INSERT INTO Jeu (nomJeu, editeur, idGenre) VALUES
   ('Overwatch', 'Blizzard', 1),
   ('Valorant', 'Riot Games', 1),
   ('Age of Empire', 'Ensemble Studio', 2),
   ('Starcraft 2', 'Blizzard', 2),
   ('Super Smash Bros Ultimate', 'Nintendo', 3),
   ('Street Fighter 6', 'Capcom', 3),
   ('League of Legends', 'Riot Games', 4),
   ('Pokemon Unite', 'Nintendo', 4),
   ('Yu-Gi-Oh', 'Konami', 5),
   ('Magic the Gathering', 'Wizards of the Coast', 5);

INSERT INTO Salle (nom, adresse, codePostal, ville, capacite, prixLocation, idType) VALUES
   ('Salle Jean Moulin', '12 rue de la République', '75011', 'Paris', 200, 850.00, 1),
   ('Salle des fêtes Belleville', '22 rue Belleville', '75019', 'Paris', 150, 600.00, 1),
   ('Gymnase Léo Lagrange', '5 avenue du Sport', '69003', 'Lyon', 500, 1200.00, 2),
   ('Gymnase Coubertin', '14 rue Olympique', '13008', 'Marseille', 450, 1100.00, 2);
   ('Local eSport Arena', '8 boulevard Victor Hugo', '33000', 'Bordeaux', 80, 400.00, 3),
   ('Stade Couvert Atlantis', '1 place des Jeux', '44000', 'Nantes', 1500, 3500.00, 4),