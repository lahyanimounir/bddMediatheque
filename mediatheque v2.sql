-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : Dim 30 mai 2021 à 20:01
-- Version du serveur :  8.0.21
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mediatheque`
--

-- --------------------------------------------------------

--
-- Structure de la table `casultation`
--

DROP TABLE IF EXISTS `casultation`;
CREATE TABLE IF NOT EXISTS `casultation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_doc` int NOT NULL,
  `id_emprunt` int NOT NULL,
  `heur_consultation` datetime DEFAULT NULL,
  `heur_fin_consultaion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_emprunt` (`id_emprunt`),
  KEY `id_livre` (`id_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `doc`
--

DROP TABLE IF EXISTS `doc`;
CREATE TABLE IF NOT EXISTS `doc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nbPages` int NOT NULL,
  `titre` varchar(100) NOT NULL,
  `editeur` varchar(100) NOT NULL,
  `edition` int NOT NULL,
  `isbn` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `type_doc` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
CREATE TABLE IF NOT EXISTS `emprunt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_kindel` int NOT NULL,
  `user_id` int NOT NULL,
  `heur_emprunt` datetime DEFAULT NULL,
  `heur_retour` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id_livre` (`id_kindel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `kindel`
--

DROP TABLE IF EXISTS `kindel`;
CREATE TABLE IF NOT EXISTS `kindel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `modele` varchar(100) NOT NULL,
  `mac` varchar(100) NOT NULL,
  `pouces` float NOT NULL,
  `emprunte` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(100) NOT NULL,
  `login` varchar(100) NOT NULL,
  `cin` varchar(8) NOT NULL,
  `cne` varchar(20) DEFAULT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `matricule` varchar(20) DEFAULT NULL,
  `profile` varchar(20) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  `fillier` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CIN_UNIQUE` (`cin`),
  UNIQUE KEY `cne` (`cne`),
  UNIQUE KEY `matricule` (`matricule`),
  UNIQUE KEY `matricule_2` (`matricule`),
  UNIQUE KEY `cne_2` (`cne`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `password`, `login`, `cin`, `cne`, `nom`, `prenom`, `matricule`, `profile`, `role`, `fillier`) VALUES
(3, '123456', 'myClient', 'A875', '85751', 'nom', 'prenom', NULL, 'etudiant', 'role_etudiant', 'GL');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `casultation`
--
ALTER TABLE `casultation`
  ADD CONSTRAINT `casultation_fk` FOREIGN KEY (`id_emprunt`) REFERENCES `emprunt` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `casultation_fk1` FOREIGN KEY (`id_doc`) REFERENCES `doc` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `emprunt`
--
ALTER TABLE `emprunt`
  ADD CONSTRAINT `emprunt_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `emprunt_fk1` FOREIGN KEY (`id_kindel`) REFERENCES `kindel` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
