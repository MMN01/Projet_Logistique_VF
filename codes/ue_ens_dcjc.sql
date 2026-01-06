-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 07 déc. 2025 à 16:21
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `logistics`
--

-- --------------------------------------------------------

--
-- Structure de la table `assigned_trucks`
--

CREATE TABLE `assigned_trucks` (
  `FK_LOCATIONS` int(11) NOT NULL,
  `REF_L` int(11) NOT NULL,
  `REF_H` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `locations_names`
--

CREATE TABLE `locations_names` (
  `PK_LOCATIONS` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `COUNTRY` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ports_availability`
--

CREATE TABLE `ports_availability` (
  `FK_LOCATIONS` int(11) NOT NULL,
  `AVAILABILITY_T0` float NOT NULL,
  `AVAILABILITY_T+4` float DEFAULT NULL,
  `AVAILABILITY_T+8` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tracabilite`
--

CREATE TABLE `tracabilite` (
  `numero_serie` varchar(255) DEFAULT NULL,
  `VIN_TRUCK` int(11) DEFAULT NULL,
  `TYPE_MVT` varchar(255) DEFAULT NULL,
  `LOC_DEP_NAME` varchar(255) DEFAULT NULL,
  `LOC_DEP_COUNTRY` varchar(255) DEFAULT NULL,
  `LOC_ARR_NAME` varchar(255) DEFAULT NULL,
  `LOC_ARR_COUNTRY` varchar(255) DEFAULT NULL,
  `TYPE_DEP` varchar(50) DEFAULT NULL,
  `TYPE_ARR` varchar(50) DEFAULT NULL,
  `QTE_MP` float DEFAULT NULL,
  `QTE_MP_FRAIS` float DEFAULT NULL,
  `QTE_PF` float DEFAULT NULL,
  `QTE_PF_FRAIS` float DEFAULT NULL,
  `QTE_EPAL` int(11) DEFAULT NULL,
  `QTE_EPALh` int(11) DEFAULT NULL,
  `QTE_ISO` int(11) DEFAULT NULL,
  `H_DEP` datetime DEFAULT NULL,
  `H_ACCEPTE` datetime DEFAULT NULL,
  `SPEC` varchar(255) DEFAULT NULL,
  `TRUCK_CONSUMPTION` float DEFAULT NULL,
  `TRUCK_PTAC` varchar(10) DEFAULT NULL,
  `COUT_TRAJET` float DEFAULT NULL,
  `DIST_TRAJET` float DEFAULT NULL,
  `DUREE_TRAJET` float DEFAULT NULL,
  `DEPART_EUROTRANSFRET` tinyint(1) DEFAULT NULL,
  `TAUX_REMPLISSAGE` float DEFAULT NULL,
  `VALIDE_TRANSP` tinyint(1) DEFAULT NULL,
  `PRIX` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `travel_time_matrix`
--

CREATE TABLE `travel_time_matrix` (
  `FK_LOCATIONS` int(11) NOT NULL,
  `0` float DEFAULT NULL,
  `1` float DEFAULT NULL,
  `2` float DEFAULT NULL,
  `3` float DEFAULT NULL,
  `4` float DEFAULT NULL,
  `5` float DEFAULT NULL,
  `6` float DEFAULT NULL,
  `7` float DEFAULT NULL,
  `8` float DEFAULT NULL,
  `9` float DEFAULT NULL,
  `10` float DEFAULT NULL,
  `11` float DEFAULT NULL,
  `12` float DEFAULT NULL,
  `13` float DEFAULT NULL,
  `14` float DEFAULT NULL,
  `15` float DEFAULT NULL,
  `16` float DEFAULT NULL,
  `17` float DEFAULT NULL,
  `18` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `travel_time_matrix`
--

INSERT INTO `travel_time_matrix` (`FK_LOCATIONS`, `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`, `13`, `14`, `15`, `16`, `17`, `18`) VALUES
(3, NULL, NULL, NULL, 0.92, 51.32, 19.49, 34.85, 30.3, 39.25, 31.65, 44.31, 32.03, 26.82, 40.43, 43.65, 63.24, 51.04, 25.55, 18.99),
(1, NULL, 1.1, 2.53, 39.03, 14.97, 29.12, 3.86, 19.77, 8.48, 12.03, 14.32, 15.19, 12.66, 9.26, 1.52, 30.22, 29.09, 15.83, 17.32),
(14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.7, 33.04, 24.4, 17.29, 17.34),
(16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.7, 27.85, 24.94),
(18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.3),
(7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1.2, 20.02, 9.62, 29.16, 8.36, 10.2, 15.19, 19.97, 25.57, 17.72, 12.91, 9.48),
(13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2.1, 6.51, 24.7, 18.3, 14.56, 18.26),
(17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.5, 5.81),
(6, NULL, NULL, NULL, NULL, NULL, NULL, 0.71, 17.16, 7.69, 9.5, 12.66, 13.29, 8.4, 8.65, 3.17, 33.33, 23.11, 11.39, 14.69),
(11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1.6, 12.79, 10.79, 14.6, 19.28, 10.47, 20.88, 17.21),
(9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.8, 16.32, 4.58, 11.35, 6.33, 11.56, 19.62, 11.52, 15.19, 13.29),
(5, NULL, NULL, NULL, NULL, NULL, 0.89, 29.66, 27.8, 34.18, 27.85, 41.09, 31.69, 23.87, 36.65, 31.32, 48.26, 41.19, 16.07, 17.38),
(2, NULL, NULL, 1.45, 38.23, 11.86, 28.7, 3.96, 16.46, 7.2, 10.64, 10.76, 13.29, 11.52, 6.63, 2.15, 27.71, 21.52, 13.93, 20.07),
(12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.7, 10.13, 10.24, 32.91, 24.01, 5.39, 8.11),
(15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.2, 8.88, 41.91, 35.17),
(0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.36, 9.6, 11.43, 11.39, 12.03, 3.66, 6.96, 23.34, 20.06, 17.22, 24.13),
(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.48, 20.26, 19.75, 11.39, 11.52, 36.11, 33.56, 27.68, 29.35),
(4, NULL, NULL, NULL, NULL, 0.5, 40.18, 14, 23.63, 7.58, 11.39, 16.67, 14.56, 17.72, 8.1, 15.01, 22.79, 21.37, 22.79, 28.5);

-- --------------------------------------------------------

--
-- Structure de la table `trucks`
--

CREATE TABLE `trucks` (
  `PK_TRUCK` bigint(20) UNSIGNED NOT NULL,
  `REFERENCE` int(11) NOT NULL,
  `IMMAT` varchar(15) NOT NULL,
  `DATE_MEC` date DEFAULT NULL,
  `VIN` varchar(32) DEFAULT NULL,
  `CH` int(11) DEFAULT NULL,
  `ENERGIE` varchar(20) DEFAULT NULL,
  `PTAC` varchar(10) DEFAULT NULL,
  `REMORQUE_REFRIGEREE` tinyint(1) DEFAULT NULL,
  `COULEUR` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `trucks`
--

INSERT INTO `trucks` (`PK_TRUCK`, `REFERENCE`, `IMMAT`, `DATE_MEC`, `VIN`, `CH`, `ENERGIE`, `PTAC`, `REMORQUE_REFRIGEREE`, `COULEUR`) VALUES
(2, 746019, '0Q-458-A5', '0000-00-00', 'WK387YWXDAWN', 35, 'GPL', '32t', 0, 'Gris'),
(3, 711059, '0U-431-X5', '0000-00-00', 'OUJ9IPS80YKZ', 34, 'GPL', '19t', 0, 'Blanc'),
(4, 524551, '63-75-73', '0000-00-00', '5LD0E1YBNLOU', 36, 'Diesel', '26t', 0, 'Gris'),
(5, 478785, 'G5-712-LO', '0000-00-00', 'HZQLD6UVCH7C', 17, 'Diesel', '26t', 0, 'Vert'),
(6, 533525, 'ZS-824-1R', '0000-00-00', 'JKJYPFG682XY', 19, 'Essence', '12t', 0, 'Blanc'),
(7, 366488, '87-509-J1', '0000-00-00', '24MAU7ZA53QH', 34, 'Diesel', '12t', 0, 'Blanc'),
(8, 270054, 'YC-934-5K', '0000-00-00', 'X2DH5RP969D3', 17, 'Diesel', '32t', 0, 'Blanc'),
(9, 852754, '0N-723-7X', '0000-00-00', 'ZY0GE7DAEWJB', 28, 'Hydrogène', '12t', 0, 'Blanc'),
(10, 605218, 'DD-166-X6', '0000-00-00', 'PV9DDA6206SC', 25, 'Essence', '19t', 0, 'Rouge'),
(11, 492321, 'JG-777-CQ', '0000-00-00', 'XWTGXVX51T6V', 22, 'Diesel', '44t', 0, 'Bleu'),
(12, 614077, 'QM-650-VH', '0000-00-00', 'I1EAZCN8G9NR', 17, 'GPL', '12t', 0, 'Noir'),
(13, 642598, 'O5-864-AT', '0000-00-00', '933RDNNM7NKD', 15, 'GPL', '12t', 0, 'Noir'),
(14, 847534, 'X5-796-K4', '0000-00-00', 'WMIP9GKURAC6', 33, 'Electrique', '26t', 0, 'Gris'),
(15, 579331, '77-429-B4', '0000-00-00', 'G7A60OJWF3GV', 32, 'Diesel', '12t', 0, 'Blanc'),
(16, 847747, '5G-450-1A', '0000-00-00', 'RCBT228EOEBT', 19, 'GPL', '19t', 0, 'Gris'),
(17, 810265, '7Z-125-N5', '0000-00-00', 'MTOLWW3EZZ7K', 24, 'Electrique', '26t', 0, 'Noir'),
(18, 271753, 'OU-524-PV', '0000-00-00', 'Y4NXSR2IGTAV', 37, 'Essence', '12t', 0, 'Gris'),
(19, 245118, '8C-530-OG', '0000-00-00', 'ORJOOHDOCX4M', 25, 'GPL', '12t', 0, 'Blanc'),
(20, 666415, 'GC-448-LS', '0000-00-00', 'UJQ68SVIDV8T', 29, 'Hydrogène', '32t', 0, 'Gris'),
(21, 558847, 'T5-430-59', '0000-00-00', 'KTI8691W9ZVQ', 38, 'Diesel', '12t', 0, 'Blanc'),
(22, 800485, 'DG-305-6S', '0000-00-00', '33ET41TCZSLH', 35, 'Electrique', '12t', 0, 'Gris'),
(23, 756703, 'CI-885-1O', '0000-00-00', 'F3V9KI0W8KWY', 35, 'Electrique', '12t', 0, 'Noir'),
(24, 531712, '4S-609-3T', '0000-00-00', '8W5FN6IP0XFB', 39, 'Diesel', '12t', 0, 'Noir'),
(25, 300770, 'Q4-483-KI', '0000-00-00', '1K7BVLJV14SY', 38, 'Diesel', '19t', 0, 'Bleu'),
(26, 821513, 'AE-988-VM', '0000-00-00', '28YEC8J004JB', 39, 'Diesel', '12t', 0, 'Noir'),
(27, 453571, 'AV-805-RC', '0000-00-00', '18JWK45EAJ8I', 40, 'GPL', '19t', 0, 'Noir'),
(28, 379691, '1T-979-8B', '0000-00-00', 'FI8BQMMK53G2', 16, 'GPL', '12t', 0, 'Noir'),
(29, 344967, 'LP-998-A5', '0000-00-00', '4ZXH5T2KSVZ7', 35, 'Essence', '12t', 0, 'Gris'),
(30, 727649, 'OO-577-LI', '0000-00-00', 'V9RZWZ376Z32', 19, 'Diesel', '26t', 0, 'Blanc'),
(31, 643437, 'I1-908-PR', '0000-00-00', 'TVWIEKVEX6GC', 36, 'GPL', '19t', 0, 'Bleu'),
(32, 691946, 'JK-676-IE', '0000-00-00', '5RI93TZX6J4J', 31, 'Essence', '', 0, 'Bleu'),
(33, 680887, 'AQ-928-EY', '0000-00-00', 'ICUL61DNBG2F', 37, 'Diesel', '19t', 0, 'Gris'),
(34, 761507, 'NQ-809-X5', '0000-00-00', 'GT416BPKSAC8', 38, 'Diesel', '12t', 0, 'Gris'),
(35, 596536, 'WF-735-G2', '0000-00-00', 'E7SMRFHBFT5L', 21, 'Electrique', '26t', 0, 'Rouge'),
(36, 576582, '8U-371-AO', '0000-00-00', 'U5XGW2ASZ3FG', 24, 'Essence', '12t', 0, 'Gris'),
(37, 545825, 'YS-87-5T', '0000-00-00', 'E3I7HH5K1BJD', 34, 'GPL', '12t', 0, 'Gris'),
(38, 281617, 'UU-81-ZT', '0000-00-00', '2QY6BU11RWVS', 39, 'GPL', '26t', 0, 'Rouge'),
(39, 252277, 'XZ-750-DU', '0000-00-00', 'ZCVBRC6C5AYU', 28, 'Diesel', '19t', 0, 'Bleu'),
(40, 628729, 'QW-110-K4', '0000-00-00', 'HFY12ID68VDP', 40, 'Diesel', '32t', 0, 'Gris'),
(41, 272774, 'DG-915-VS', '0000-00-00', 'NXNK5J51ABJ8', 24, 'Diesel', '12t', 0, 'Blanc'),
(42, 448281, '57-664-BU', '0000-00-00', 'TOY33LBF0UUZ', 22, 'Essence', '44t', 0, 'Noir'),
(43, 831880, 'SR-582-ZK', '0000-00-00', 'XTCAXWSHQ0KL', 37, 'Hydrogène', '26t', 0, 'Blanc'),
(44, 768450, 'VE-250-GU', '0000-00-00', 'Z4VO1C3N5DE1', 33, 'Diesel', '12t', 0, 'Noir'),
(45, 443029, 'NG-916-DW', '0000-00-00', 'CYHMAZB2P0XX', 32, 'Diesel', '19t', 0, ''),
(46, 851266, 'FT-646-VE', '0000-00-00', 'VKPG1BTXWT2J', 25, 'Diesel', '26t', 0, 'Noir'),
(47, 827100, 'PB-193-NI', '0000-00-00', '4OKGBDIAN7CD', 18, 'Diesel', '19t', 0, 'Blanc'),
(48, 378152, 'QJ-249-59', '0000-00-00', '7LRZDYFXBLM0', 18, 'GPL', '12t', 0, 'Blanc'),
(49, 806885, 'BG-83-OU', '0000-00-00', 'A3KF7KQPX2AR', 20, 'Essence', '12t', 0, 'Noir'),
(50, 697864, 'Z4-960-1K', '0000-00-00', 'HLRAOPTQ54RU', 18, 'Essence', '12t', 0, 'Blanc'),
(51, 632475, 'BN-524-V2', '0000-00-00', 'IJXBHHEC0QR0', 35, 'GPL', '26t', 0, 'Blanc'),
(52, 646166, 'CK-428-HP', '0000-00-00', 'Y8EX4LAAMJIH', 23, 'Essence', '12t', 0, 'Gris'),
(53, 765333, 'IL-850-RO', '0000-00-00', 'G6CVOAXVHSZ3', 19, 'GPL', '26t', 0, 'Blanc'),
(54, 671336, 'MH-539-V9', '0000-00-00', 'I42GSXENSRLZ', 30, 'Electrique', '32t', 0, 'Blanc'),
(55, 661044, 'JZ-869-SO', '0000-00-00', 'O2W4GISH68ZK', 16, 'Diesel', '12t', 0, 'Noir'),
(56, 714665, 'OZ-749-M1', '0000-00-00', '16FTR77JUF70', 19, 'Diesel', '12t', 0, 'Gris'),
(57, 549718, 'PB-214-7C', '0000-00-00', '9XWOY6ESXKVU', 19, 'Diesel', '19t', 0, 'Noir'),
(58, 454751, 'QA-259-10', '0000-00-00', 'F08LL399KGA6', 19, 'GPL', '12t', 0, 'Blanc'),
(59, 874170, 'CQ-665-OI', '0000-00-00', 'FT4P85JXTN40', 20, 'Diesel', '32t', 0, 'Noir'),
(60, 768496, 'W2-711-UM', '0000-00-00', 'P40SKHTRWJI3', 30, 'Diesel', '26t', 0, 'Blanc'),
(61, 684384, 'P6-319-BX', '0000-00-00', 'TLD0IMTO3V9L', 21, 'GPL', '26t', 0, 'Noir'),
(62, 353607, 'UH-270-6N', '0000-00-00', 'OQSEIF0UFQ13', 19, 'Diesel', '26t', 0, 'Bleu'),
(63, 251065, '54-253-LE', '0000-00-00', 'ZOZXUZ4YY3IA', 33, 'Diesel', '12t', 0, 'Gris'),
(64, 498455, '9O-905-1Q', '0000-00-00', '6T6UTSKE7COZ', 19, 'Diesel', '12t', 0, 'Rouge'),
(65, 260331, 'EI-520-HP', '0000-00-00', 'IHVBVYAJ694H', 32, 'Diesel', '19t', 0, 'Gris'),
(66, 712205, 'FR-868-RH', '0000-00-00', '25Q9B4P35KNM', 20, 'Essence', '26t', 0, 'Rouge'),
(67, 653081, '0T-508-OE', '0000-00-00', 'F21GQK2HH5U5', 23, 'Diesel', '19t', 0, 'Blanc'),
(68, 731422, 'PP-722-JG', '0000-00-00', 'PARTW8403YPY', 21, 'Diesel', '12t', 0, ''),
(69, 600054, 'Z7-635-9T', '0000-00-00', 'LLVQ6B0UZSRD', 29, 'GPL', '12t', 0, 'Bleu'),
(70, 446608, 'AH-862-3B', '0000-00-00', 'OQE1LCFNICKQ', 23, 'Diesel', '12t', 0, 'Blanc'),
(71, 516195, 'W0-184-VL', '0000-00-00', 'UYLGCY2P3N01', 23, 'Diesel', '19t', 0, 'Blanc'),
(72, 413155, '0F-523-R4', '0000-00-00', 'I4SINI274N91', 17, 'Diesel', '26t', 0, 'Gris'),
(73, 396333, '5P-993-UR', '0000-00-00', 'J9E0UPW4TBX6', 20, 'GPL', '12t', 0, 'Blanc'),
(74, 805081, '0L-881-N8', '0000-00-00', 'NNXXEJTZZAVD', 15, 'Electrique', '12t', 0, 'Gris'),
(75, 582036, 'NL-692-0B', '0000-00-00', 'ZSQCU1VRSTJK', 39, 'Diesel', '19t', 0, 'Blanc'),
(76, 724559, 'FU-186-J1', '0000-00-00', 'T0HT53C3G790', 24, 'GPL', '26t', 0, 'Gris'),
(77, 473725, '48-504-0E', '0000-00-00', 'M5Z14R8YLHMY', 19, 'Electrique', '26t', 0, 'Bleu'),
(78, 289269, 'MY-57-IP', '0000-00-00', 'YFVKG68MHHZQ', 17, 'Electrique', '19t', 0, 'Bleu'),
(79, 721680, '8N-876-OR', '0000-00-00', '5NQT3KLGSMYC', 34, 'Diesel', '12t', 0, 'Rouge'),
(80, 893201, 'UB-215-7J', '0000-00-00', 'S8CMYN7RM1YX', 33, 'Diesel', '12t', 0, 'Blanc'),
(81, 498306, 'SI-250-K1', '0000-00-00', '53T4DNL8SIMN', 20, 'Hydrogène', '12t', 0, 'Gris'),
(82, 510768, 'SL-422-RP', '0000-00-00', 'JWNCYSM6N1IX', 34, 'Diesel', '44t', 0, 'Gris'),
(83, 701798, 'TF-659-40', '0000-00-00', '9A6V59A6M8FK', 35, 'GPL', '19t', 0, 'Gris'),
(84, 713654, 'TC-403-EL', '0000-00-00', 'NY16A0JW36PP', 37, 'GPL', '12t', 0, 'Noir'),
(85, 341972, '65-289-1R', '0000-00-00', 'VSMPRCFD50F1', 37, 'Essence', '19t', 0, 'Blanc'),
(86, 638055, 'C3-413-1M', '0000-00-00', '880ZX7ILCDN7', 28, 'Essence', '12t', 0, 'Bleu'),
(87, 805072, '24-712-HA', '0000-00-00', 'LF4UNBQGGHN7', 22, 'Diesel', '12t', 0, 'Blanc'),
(88, 829271, 'IO-299-QT', '0000-00-00', 'JWDI97FWRN34', 31, 'Diesel', '12t', 0, 'Bleu'),
(89, 696076, 'G0-790-OC', '0000-00-00', 'T0G3OKUXUTXW', 16, 'Essence', '26t', 0, 'Bleu'),
(90, 424639, 'AG-471-LB', '0000-00-00', '93WMB291C2V7', 29, 'Hydrogène', '12t', 0, 'Blanc'),
(91, 582307, 'PN-630-DT', '0000-00-00', 'ABQIL6L17F9C', 35, 'Diesel', '12t', 0, 'Bleu'),
(92, 372618, 'W3-938-LK', '0000-00-00', 'Q9V87X9CIN2E', 17, 'Diesel', '26t', 0, 'Gris'),
(93, 783609, 'ER-531-OZ', '0000-00-00', 'Z5N68OU0ZRS7', 25, 'GPL', '44t', 0, 'Rouge'),
(94, 402616, '22-391-FN', '0000-00-00', '62EU0DY7L82Y', 38, 'Diesel', '26t', 0, 'Noir'),
(95, 865343, 'QN-657-LV', '0000-00-00', 'CONZBK10S3RY', 15, 'Diesel', '26t', 0, 'Blanc'),
(96, 351124, 'YK-299-QP', '0000-00-00', 'N6O23K8ZU75X', 17, 'Diesel', '19t', 0, 'Rouge'),
(97, 381383, 'SD-624-6U', '0000-00-00', 'XFEXJMI6B8KT', 34, 'Diesel', '12t', 0, 'Gris'),
(98, 609866, '97-107-PS', '0000-00-00', '5TRQRTA3A43V', 21, 'Essence', '12t', 0, 'Gris'),
(99, 735964, '17-720-PJ', '0000-00-00', '0P6ZIAN945TT', 25, 'Diesel', '19t', 0, 'Blanc'),
(100, 486808, '9P-801-T3', '0000-00-00', 'JXB7YQ01W4FC', 34, 'Essence', '12t', 0, 'Noir'),
(101, 817388, 'YE-85-FY', '0000-00-00', '66WYCLVMAYJV', 23, 'Hydrogène', '26t', 0, 'Bleu'),
(102, 515822, 'MJ-475-HI', '0000-00-00', '0US0HO48RXTB', 32, 'Diesel', '12t', 0, 'Blanc'),
(103, 250585, 'S7-150-X8', '0000-00-00', 'PGOTAI8OJTIR', 17, 'Essence', '12t', 0, 'Noir'),
(104, 804684, '7L-258-0E', '0000-00-00', '39HQ7QADPDNG', 33, 'GPL', '12t', 0, 'Blanc'),
(105, 549365, 'N9-282-FB', '0000-00-00', 'F5QAUVSB2W3U', 23, 'Essence', '19t', 0, 'Blanc'),
(106, 733600, 'HM-425-2X', '0000-00-00', 'SB8MRUOVEA2M', 29, 'Diesel', '12t', 0, 'Gris'),
(107, 409304, 'KB-635-O2', '0000-00-00', 'Z3H1PPH3JE1Z', 31, 'GPL', '12t', 0, 'Blanc'),
(108, 817861, '4F-506-K8', '0000-00-00', 'DX8VQ4DX1F7K', 34, 'Diesel', '26t', 0, 'Blanc'),
(109, 335006, '8F-195-6S', '0000-00-00', 'MH5DGZK3TB5Q', 21, 'Diesel', '12t', 0, 'Blanc'),
(110, 364446, 'SU-78-7G', '0000-00-00', '1T5Q3O0MF2U6', 22, 'Diesel', '44t', 0, 'Gris'),
(111, 660376, 'SG-817-KU', '0000-00-00', 'LPRLNMKDA7MN', 33, 'Diesel', '32t', 0, 'Noir'),
(112, 261652, '88-152-3T', '0000-00-00', '3Q6ZGWLNSN3E', 29, 'Diesel', '12t', 0, 'Bleu'),
(113, 720299, 'KM-638-PV', '0000-00-00', 'RAXSDZS1XMVI', 26, 'Diesel', '26t', 0, 'Gris'),
(114, 398678, 'SF-818-PI', '0000-00-00', 'XCPDS5Z03ZE6', 20, 'Diesel', '44t', 0, 'Blanc'),
(115, 286062, 'S1-709-OO', '0000-00-00', 'BI0ZQSZ7BEGB', 33, 'Essence', '19t', 0, 'Gris'),
(116, 509819, '3N-990-SW', '0000-00-00', 'JN72BKL937MI', 17, 'Electrique', '19t', 0, 'Vert'),
(117, 334811, 'DF-752-UE', '0000-00-00', '3O3US1GLNJFB', 36, 'Diesel', '12t', 0, 'Bleu'),
(118, 554264, 'UQ-134-A1', '0000-00-00', 'A6OS9QS2L986', 36, 'Diesel', '12t', 0, 'Gris'),
(119, 526183, '3S-578-FH', '0000-00-00', 'KPJCJW26G36A', 17, 'Diesel', '19t', 0, 'Bleu'),
(120, 559117, '23-214-2E', '0000-00-00', 'T1VTZERIV9LM', 21, 'GPL', '12t', 0, 'Gris'),
(121, 611217, '97-800-W3', '0000-00-00', 'OFVJNQ641C3Q', 40, 'Essence', '26t', 0, 'Blanc'),
(122, 797009, 'XS-335-Z6', '0000-00-00', 'DIMMF25ZSW7S', 34, 'Diesel', '19t', 0, 'Blanc'),
(123, 753559, 'NM-403-U9', '0000-00-00', '77QTV3LCDOAR', 36, 'Essence', '26t', 0, 'Bleu'),
(124, 533077, 'SQ-437-A2', '0000-00-00', 'WXDI7Z52752L', 19, 'Diesel', '12t', 0, 'Blanc'),
(125, 356952, 'YN-685-WB', '0000-00-00', '82DZNKEHUYMB', 20, 'Diesel', '19t', 0, 'Gris'),
(126, 820334, '2E-703-DS', '0000-00-00', 'O1FA8QF4ID6N', 20, 'GPL', '12t', 0, 'Noir'),
(127, 589170, 'KK-978-0F', '0000-00-00', 'RUFN0Z2R8NHT', 22, 'Diesel', '19t', 0, 'Gris'),
(128, 690543, '5P-410-Q1', '0000-00-00', 'NIGWLQF9GU4H', 35, 'Diesel', '12t', 0, 'Noir'),
(129, 595621, 'C2-94-I0', '0000-00-00', 'Z97WITPM3EC0', 21, 'Hydrogène', '12t', 0, 'Bleu'),
(130, 859465, 'V9-245-TV', '0000-00-00', 'Q6J1TPKWJ7BD', 35, 'Diesel', '44t', 0, 'Gris'),
(131, 645100, 'D5-824-05', '0000-00-00', 'XN323OMP24HD', 25, 'Essence', '12t', 0, 'Gris'),
(132, 625100, '7T-447-Z9', '0000-00-00', 'SL9TZNHAIXM3', 16, 'Diesel', '19t', 0, 'Blanc'),
(133, 720850, 'QS-611-HY', '0000-00-00', '384II08IJ0QH', 19, 'Diesel', '12t', 0, 'Blanc'),
(134, 323257, 'A7-199-ML', '0000-00-00', '0FWM0FGEPBH9', 38, 'GPL', '12t', 0, 'Blanc'),
(135, 413673, 'H7-970-J5', '0000-00-00', 'S0SD5OY2QLEN', 23, 'Essence', '32t', 0, 'Gris'),
(136, 595448, '5F-450-1W', '0000-00-00', '183EO8Y1B47F', 31, 'Diesel', '19t', 0, 'Rouge'),
(137, 735554, 'G7-791-XI', '0000-00-00', 'YP3VP58PBC3G', 38, 'Diesel', '19t', 0, 'Blanc'),
(138, 666699, 'RQ-526-HA', '0000-00-00', 'RSY2C2ZY6MU8', 24, 'Diesel', '26t', 0, 'Bleu'),
(139, 682570, 'Q7-431-Q5', '0000-00-00', 'WU5DLW0ANO79', 28, 'Essence', '26t', 0, 'Blanc'),
(140, 482523, 'PZ-893-R3', '0000-00-00', 'E26Y8B6GBEUC', 40, 'Diesel', '12t', 0, 'Blanc'),
(141, 400138, '9Y-195-JF', '0000-00-00', 'FZHC4IJRO8UJ', 24, 'Essence', '32t', 0, 'Blanc'),
(142, 414725, 'FP-489-FK', '0000-00-00', 'OAA9EO8YZF5E', 16, 'GPL', '26t', 0, 'Gris'),
(143, 511232, '1S-994-5R', '0000-00-00', 'YKII5UWBSFLD', 26, 'Essence', '12t', 0, 'Blanc'),
(144, 518920, 'GI-366-0E', '0000-00-00', '8XD956WGYGYA', 19, 'GPL', '12t', 0, 'Gris'),
(145, 870504, 'IY-697-1T', '0000-00-00', 'GOTDCQSHI6HT', 39, 'Diesel', '26t', 0, 'Noir'),
(146, 770409, 'TV-85-Q1', '0000-00-00', 'P0B6PR3P6LEQ', 20, 'Diesel', '26t', 0, 'Blanc'),
(147, 712532, 'ZY-66-I0', '0000-00-00', 'RQOXVCT86ODR', 22, 'Diesel', '12t', 0, 'Rouge'),
(148, 505064, 'ZX-279-OE', '0000-00-00', 'KCSDL21ZO4EL', 22, 'Electrique', '19t', 0, 'Noir'),
(149, 819589, 'YJ-239-EE', '0000-00-00', 'S4GK6ZWPTJS0', 34, 'Diesel', '26t', 0, 'Blanc'),
(150, 540299, 'GW-342-45', '0000-00-00', '0B18LC5IKW4L', 24, 'Diesel', '12t', 0, 'Gris'),
(151, 827069, 'FY-561-G4', '0000-00-00', '6OD97OLHQK3X', 22, 'Diesel', '26t', 0, 'Blanc'),
(152, 757914, 'PV-162-BX', '0000-00-00', '2W40XWYI4QYV', 39, 'Diesel', '12t', 0, 'Gris'),
(153, 854670, 'EE-232-LN', '0000-00-00', '7C62UM95I8X3', 35, 'Diesel', '12t', 0, 'Blanc'),
(154, 750536, 'LO-216-GG', '0000-00-00', 'IYA60JFTJH9C', 22, 'GPL', '12t', 0, 'Noir'),
(155, 489119, 'C7-610-KU', '0000-00-00', '03Z9ICULR88Q', 24, 'Essence', '26t', 0, 'Rouge'),
(156, 470004, '2L-849-QP', '0000-00-00', 'UR737F3WZL7M', 39, 'Diesel', '19t', 0, 'Blanc'),
(157, 676757, 'GQ-264-V1', '0000-00-00', 'RFWU5H1BJJV2', 24, 'Electrique', '19t', 0, 'Gris'),
(158, 640907, 'BU-655-QX', '0000-00-00', 'STA4SA9GJ7MT', 40, '', '12t', 0, 'Noir'),
(159, 791591, '3T-930-GU', '0000-00-00', 'PSKLUF1KQZY5', 30, 'GPL', '32t', 0, 'Gris'),
(160, 419284, 'SG-406-CG', '0000-00-00', 'INJ6EA1IJ583', 19, 'Essence', '26t', 0, 'Gris'),
(161, 890115, '25-463-WI', '0000-00-00', '4R5HRMW23A2B', 34, 'Diesel', '12t', 0, 'Noir'),
(162, 519607, '79-468-T1', '0000-00-00', '09S1A53N1E04', 19, 'Diesel', '44t', 0, 'Gris'),
(163, 315387, 'F2-581-3D', '0000-00-00', 'JIXQ9HBUP2ZF', 37, 'Diesel', '26t', 0, 'Blanc'),
(164, 775144, '5B-791-M2', '0000-00-00', 'YGL7V0Y6JIKI', 23, 'Diesel', '26t', 0, 'Gris'),
(165, 783401, '4F-783-02', '0000-00-00', '6U151RRWG2VH', 20, 'Essence', '19t', 0, 'Blanc'),
(166, 864688, 'CC-616-0A', '0000-00-00', 'I858Y7YI578K', 30, 'Diesel', '32t', 0, 'Rouge'),
(167, 503797, 'ZN-343-J3', '0000-00-00', 'S3U1L6B26LZE', 18, 'Essence', '12t', 0, 'Gris'),
(168, 856492, 'TA-167-U1', '0000-00-00', 'JJWQ5NII2EK6', 22, 'GPL', '32t', 0, 'Blanc'),
(169, 533299, 'AL-756-R8', '0000-00-00', 'RUOGJOJJVO2S', 25, 'Essence', '26t', 0, 'Blanc'),
(170, 336867, 'E3-720-J9', '0000-00-00', 'RRM3055HPX2N', 30, 'Diesel', '19t', 0, 'Noir'),
(171, 567470, 'G3-232-UL', '0000-00-00', '33WRBJJMGIHN', 40, 'Diesel', '32t', 0, 'Gris'),
(172, 758122, 'YE-864-0N', '0000-00-00', '43FWBCM1GCHL', 37, 'Diesel', '32t', 0, 'Noir'),
(173, 653105, '0U-767-22', '0000-00-00', 'WA8EUU9E6QEK', 31, 'Diesel', '12t', 0, 'Bleu'),
(174, 753723, '1Y-243-AD', '0000-00-00', 'RYCLCHRSOG3U', 25, 'Diesel', '12t', 0, 'Blanc'),
(175, 373756, 'LG-148-UT', '0000-00-00', '8JD0R1N78WMO', 39, 'Diesel', '12t', 0, 'Blanc'),
(176, 835847, 'I8-267-4K', '0000-00-00', 'NWN7K6AN8YDI', 20, 'Diesel', '12t', 0, 'Gris'),
(177, 878249, '3B-563-DV', '0000-00-00', 'PG6FN1UYGKHW', 15, 'Diesel', '26t', 0, 'Gris'),
(178, 493018, 'Y5-714-DL', '0000-00-00', 'DR237A71U1FH', 16, 'Essence', '12t', 0, 'Blanc'),
(179, 831305, '3R-264-XE', '0000-00-00', 'PAXMTVWPO3NG', 19, 'Diesel', '26t', 0, 'Blanc'),
(180, 417148, 'VV-831-P5', '0000-00-00', 'CJAD1UFDGT56', 17, 'Diesel', '19t', 0, 'Gris'),
(181, 695347, 'IW-603-4F', '0000-00-00', 'XKCZ9EPYVLEV', 18, '', '12t', 0, 'Blanc'),
(182, 322151, 'C0-305-1I', '0000-00-00', 'UTB44UZUCR59', 17, 'Essence', '12t', 0, 'Blanc'),
(183, 292493, '8F-729-W2', '0000-00-00', 'S2PUDT1YG1GL', 17, 'Essence', '12t', 0, 'Blanc'),
(184, 751117, 'SI-703-A3', '0000-00-00', 'DH9HXZ00Q6OE', 17, 'Diesel', '12t', 0, 'Blanc'),
(185, 663321, 'IT-446-5W', '0000-00-00', 'M9C1OHD2IJUN', 23, 'Diesel', '19t', 0, 'Blanc'),
(186, 337815, 'OV-256-2P', '0000-00-00', 'RAR2OPPQT0C6', 24, 'Diesel', '19t', 0, 'Blanc'),
(187, 562457, '15-706-O4', '0000-00-00', '1DZMQO0IJ9QD', 39, 'Diesel', '12t', 0, 'Noir'),
(188, 615518, '05-170-08', '0000-00-00', 'RF4LAW7E08GO', 40, 'Essence', '19t', 0, 'Blanc'),
(189, 553949, 'KH-409-DM', '0000-00-00', '4XEPPK7QFDFC', 39, 'Diesel', '19t', 0, 'Gris'),
(190, 499103, 'HN-552-NK', '0000-00-00', 'E5TADEIQ9ED9', 36, 'Electrique', '12t', 0, 'Blanc'),
(191, 722905, '3Y-896-3H', '0000-00-00', 'MQ0ISW1JQYY6', 17, 'GPL', '19t', 0, 'Bleu'),
(192, 284132, '6J-419-HK', '0000-00-00', '7US1SLZJKADK', 24, 'Diesel', '12t', 0, 'Bleu'),
(193, 293514, '6Z-764-9O', '0000-00-00', 'XUBZ0U1J8LM3', 21, 'Diesel', '19t', 0, 'Gris'),
(194, 704262, 'F3-667-M2', '0000-00-00', 'S1EGRJ2CDL67', 21, 'Diesel', '12t', 0, 'Gris'),
(195, 407633, 'TN-100-GT', '0000-00-00', 'JJFW32RYEE3J', 25, 'Essence', '12t', 0, 'Blanc'),
(196, 553323, 'H9-846-FA', '0000-00-00', 'MFKWC3KQORNC', 36, 'Diesel', '12t', 0, 'Gris'),
(197, 265349, 'OY-737-GH', '0000-00-00', 'QU6886D20BZR', 21, 'Diesel', '32t', 0, 'Blanc'),
(198, 800191, 'QV-688-OG', '0000-00-00', 'PCA3ZSC7FB23', 34, 'Hydrogène', '19t', 0, 'Rouge'),
(199, 750043, '58-929-4Q', '0000-00-00', 'LF9ITM9HDED3', 29, 'Essence', '12t', 0, 'Noir'),
(200, 309642, '71-759-HD', '0000-00-00', '36EBTSJBP3N8', 15, 'Diesel', '26t', 0, 'Bleu'),
(201, 843553, 'ZW-240-T2', '0000-00-00', 'F49PCUKOWZ1X', 38, 'GPL', '19t', 0, 'Bleu'),
(202, 853984, 'FA-174-ZL', '0000-00-00', 'NXJS8NORHM79', 31, 'Diesel', '19t', 0, 'Rouge'),
(203, 385298, '98-373-89', '0000-00-00', 'PM0M0BOPY3OC', 16, 'Electrique', '12t', 0, 'Blanc'),
(204, 871097, 'XV-787-LA', '0000-00-00', 'HNPSJSH8MJSW', 33, 'Diesel', '12t', 0, 'Vert'),
(205, 405784, '2B-511-2P', '0000-00-00', 'VYC4DYZVVYNB', 15, 'Essence', '12t', 0, 'Blanc'),
(206, 584678, 'ST-99-HL', '0000-00-00', 'JW2E6WQACWT2', 27, 'Diesel', '26t', 0, 'Noir'),
(207, 635330, 'M7-146-25', '0000-00-00', 'IGHX8O38RSIY', 25, 'GPL', '19t', 0, 'Bleu'),
(208, 677977, 'D3-242-4Z', '0000-00-00', 'SL71290S0D6N', 22, 'Essence', '12t', 0, 'Rouge'),
(209, 777492, 'PN-598-D0', '0000-00-00', 'KLYZNC9U3ZYV', 22, 'Electrique', '32t', 0, 'Blanc'),
(210, 818544, 'PE-56-PI', '0000-00-00', '4WN880XB50BE', 18, 'Diesel', '19t', 0, 'Gris'),
(211, 587599, '84-235-ZM', '0000-00-00', 'BBL8I8GJ8NYP', 37, 'Diesel', '26t', 0, 'Bleu'),
(212, 767548, 'UW-320-LO', '0000-00-00', 'Y9S16DMCUPAH', 28, 'Diesel', '12t', 0, 'Noir'),
(213, 315151, 'I4-902-QY', '0000-00-00', 'FEF7MVXZHBUX', 35, 'Diesel', '26t', 0, 'Noir'),
(214, 820168, 'UU-386-YV', '0000-00-00', 'KEOGYIOIBSR1', 28, 'Hydrogène', '19t', 0, 'Noir'),
(215, 540352, 'JQ-263-NA', '0000-00-00', 'KK960XBH504S', 34, 'Essence', '19t', 0, 'Gris'),
(216, 558573, 'QD-982-C6', '0000-00-00', '7VS56FUHKASE', 36, 'GPL', '12t', 0, 'Bleu'),
(217, 790269, 'W9-271-V7', '0000-00-00', 'RKJ8MQYM0T2F', 33, 'Diesel', '26t', 0, ''),
(218, 545629, 'B0-834-E1', '0000-00-00', 'KL3Y8YJ5HXUY', 15, 'GPL', '26t', 0, 'Bleu'),
(219, 808316, 'HU-166-KV', '0000-00-00', '0EZ12IGXRY4R', 36, 'Essence', '', 0, 'Gris'),
(220, 668062, 'PY-970-PQ', '0000-00-00', '8W4855TY65BF', 25, 'Essence', '12t', 0, 'Noir'),
(221, 614729, 'BG-407-9B', '0000-00-00', 'DMMYTNNGMOTE', 33, 'Diesel', '26t', 0, 'Gris'),
(222, 383329, '0B-340-2M', '0000-00-00', 'X5N2SH27ESS1', 23, 'Essence', '12t', 0, 'Blanc'),
(223, 541405, 'Z3-574-CH', '0000-00-00', 'VCBYS4RJFKPM', 31, 'Hydrogène', '32t', 0, 'Bleu'),
(224, 738645, 'W8-285-47', '0000-00-00', 'O0UWNU1MSX1X', 28, 'Diesel', '44t', 0, 'Blanc'),
(225, 595771, 'CR-799-X9', '0000-00-00', '9GULFT7F5LBQ', 26, 'Electrique', '19t', 0, 'Blanc'),
(226, 590274, 'WU-422-E2', '0000-00-00', 'NLZEMPT4IC4T', 21, 'Diesel', '19t', 0, 'Gris'),
(227, 575342, 'BH-890-KX', '0000-00-00', 'QWALOJCYXUWP', 35, 'Hydrogène', '32t', 0, 'Noir'),
(228, 607556, 'VE-372-ZK', '0000-00-00', 'ZOQH714Q776J', 26, 'Diesel', '12t', 0, 'Rouge'),
(229, 844023, 'GH-140-R0', '0000-00-00', 'R4YVR0C0F7KG', 38, 'Diesel', '12t', 0, 'Gris'),
(230, 736166, 'CW-368-LU', '0000-00-00', '2R6TP62SCDTY', 29, 'Essence', '12t', 0, 'Vert'),
(231, 584022, 'VM-904-2U', '0000-00-00', 'ONQGF0VV9IIG', 16, 'Essence', '12t', 0, 'Blanc'),
(232, 615515, 'PG-391-Q6', '0000-00-00', '7HJVEUL93WR1', 31, 'Electrique', '32t', 0, 'Blanc'),
(233, 313680, 'MT-102-29', '0000-00-00', 'ZKO81EE802XB', 28, 'Diesel', '26t', 0, 'Blanc'),
(234, 523088, 'KX-599-DY', '0000-00-00', 'U52ZYIJGKSKT', 26, 'GPL', '19t', 0, 'Gris'),
(235, 384151, 'US-377-87', '0000-00-00', '9RFTY7CAYL6L', 26, 'Essence', '12t', 0, 'Bleu'),
(236, 279569, 'XU-845-YM', '0000-00-00', 'OR0CCNWNQJSB', 27, 'Diesel', '26t', 0, 'Blanc'),
(237, 265003, 'MA-955-2H', '0000-00-00', 'MO85K8EWE2GE', 25, 'Diesel', '32t', 0, 'Bleu'),
(238, 627979, 'DH-975-8I', '0000-00-00', 'L6AR35JKK1P5', 23, 'Essence', '26t', 0, 'Gris'),
(239, 538833, '6N-694-NB', '0000-00-00', '89YQVTLOGCAK', 33, 'Essence', '19t', 0, 'Bleu'),
(240, 381381, 'HV-450-H1', '0000-00-00', 'A0ATEBE7U4XZ', 18, 'Diesel', '12t', 0, 'Noir'),
(241, 606452, 'JM-694-DP', '0000-00-00', 'WF7SFFS4Z4R9', 28, 'GPL', '19t', 0, 'Bleu'),
(242, 589347, '5W-481-ZM', '0000-00-00', 'OY68POSYVWWK', 25, 'GPL', '26t', 0, 'Blanc'),
(243, 356931, 'CN-400-8H', '0000-00-00', 'I91YLLQRNRLN', 40, 'Diesel', '19t', 0, 'Blanc'),
(244, 890170, 'G1-94-B3', '0000-00-00', 'NT79BA6OLB6F', 32, 'Diesel', '19t', 0, 'Noir'),
(245, 444042, 'MI-216-U4', '0000-00-00', 'WFAH7H1H8G6L', 33, 'Diesel', '12t', 0, 'Blanc'),
(246, 893630, '0C-281-77', '0000-00-00', '3J8WF0B3XOB1', 24, 'Diesel', '32t', 0, 'Noir'),
(247, 886665, 'QJ-737-IR', '0000-00-00', 'DRXMN0TFZ49H', 36, 'Diesel', '26t', 0, 'Gris'),
(248, 391322, '39-823-N6', '0000-00-00', 'EYGLE16GGTI1', 37, 'Diesel', '19t', 0, 'Noir'),
(249, 841221, 'MP-998-4T', '0000-00-00', 'R26KYCKCF8SR', 23, 'Diesel', '19t', 0, 'Blanc'),
(250, 677233, 'BS-534-MP', '0000-00-00', 'ZRJRXJVSO078', 33, 'Electrique', '12t', 0, 'Blanc'),
(251, 294655, 'O1-987-PS', '0000-00-00', 'FBTAQF76M6BC', 29, 'Diesel', '12t', 0, 'Noir'),
(252, 599394, '2P-967-MI', '0000-00-00', 'IZ1H8ZIQZKNJ', 23, 'Diesel', '12t', 0, 'Gris'),
(253, 256654, 'GE-784-QU', '0000-00-00', 'FW554OG3SN9L', 20, 'Diesel', '12t', 0, 'Noir'),
(254, 853849, 'NT-931-SE', '0000-00-00', '0NLKL5ORL7AV', 18, 'Diesel', '12t', 0, 'Blanc'),
(255, 532315, 'V6-824-SC', '0000-00-00', 'Q3ZW3E0SQOOT', 37, 'Electrique', '12t', 0, 'Noir'),
(256, 802554, 'EX-455-P8', '0000-00-00', 'M5QLX3RHMD77', 23, 'Diesel', '19t', 0, 'Noir'),
(257, 410817, 'HT-435-P5', '0000-00-00', '5Y8I773WKLQJ', 19, 'Diesel', '12t', 0, 'Rouge'),
(258, 800141, 'LM-862-EG', '0000-00-00', 'AQI5F72EK3VJ', 32, 'Diesel', '19t', 0, 'Blanc'),
(259, 516660, 'TL-776-4Q', '0000-00-00', '9NSCPADKC61U', 22, 'Hydrogène', '19t', 0, 'Blanc'),
(260, 491216, 'IU-887-GV', '0000-00-00', 'VEHXGZY18RHC', 22, 'Diesel', '26t', 0, 'Noir'),
(261, 628317, '6X-933-XA', '0000-00-00', '88C41CIEYP2H', 38, 'Diesel', '19t', 0, 'Blanc'),
(262, 471198, 'LP-116-21', '0000-00-00', '861KGTID86F5', 32, 'Essence', '19t', 0, ''),
(263, 329177, 'QI-914-ZM', '0000-00-00', '32VTFHZJ0XF1', 30, 'Essence', '19t', 0, 'Noir'),
(264, 596217, '19-321-74', '0000-00-00', 'LLFEJ1WENR4C', 31, 'Diesel', '26t', 0, 'Gris'),
(265, 408702, '4T-737-RE', '0000-00-00', 'J9TAROZ4VDIO', 40, 'Diesel', '19t', 0, 'Rouge'),
(266, 723330, 'RK-332-IK', '0000-00-00', 'TB4C7VCQKAHH', 40, 'Diesel', '19t', 0, 'Blanc'),
(267, 384771, 'N6-476-U6', '0000-00-00', 'XVM36ABITAMO', 40, 'Essence', '19t', 0, 'Blanc'),
(268, 707103, 'TG-90-3R', '0000-00-00', 'VE3SXJROYE8K', 35, 'Diesel', '32t', 0, 'Blanc'),
(269, 373580, '3H-789-73', '0000-00-00', 'L49B71VKLXT8', 29, 'Diesel', '19t', 0, 'Bleu'),
(270, 655737, '2W-913-L2', '0000-00-00', '4VED61VAAQFZ', 40, 'Diesel', '19t', 0, 'Noir'),
(271, 590658, 'WW-211-BC', '0000-00-00', '0JBXQE7IL1OA', 37, 'Essence', '26t', 0, 'Blanc'),
(272, 287744, 'E9-235-UJ', '0000-00-00', 'HG5VM38LFJJQ', 40, 'Diesel', '44t', 0, 'Noir'),
(273, 775442, '3T-380-TN', '0000-00-00', '2TGUP84Q7DDW', 36, 'Diesel', '32t', 0, 'Gris'),
(274, 722029, '85-578-8Z', '0000-00-00', '397DRXU90RE5', 30, 'Diesel', '26t', 0, 'Blanc'),
(275, 595822, 'RW-397-I5', '0000-00-00', 'P12RQLUB3MGL', 38, 'Diesel', '19t', 0, 'Noir'),
(276, 263679, 'EC-181-4U', '0000-00-00', 'A1TCPTBCJU0P', 29, 'Diesel', '12t', 0, 'Gris'),
(277, 612492, 'R1-121-IM', '0000-00-00', 'E261KSGZF2ZH', 29, 'Diesel', '19t', 0, 'Noir'),
(278, 488518, 'X5-246-37', '0000-00-00', 'SXLTOU4KLM59', 38, 'Diesel', '26t', 0, 'Blanc'),
(279, 552015, 'WX-846-30', '0000-00-00', 'EXK6OZELVOLN', 31, 'Diesel', '19t', 0, 'Gris'),
(280, 831403, '1I-446-MZ', '0000-00-00', 'PM8ZJ00GVPEP', 28, 'Diesel', '44t', 0, 'Blanc'),
(281, 403467, 'BX-724-8O', '0000-00-00', '47QLIXV9V6QP', 16, 'GPL', '32t', 0, 'Gris'),
(282, 866369, 'JN-944-AR', '0000-00-00', 'A6H1M7NTCP8T', 26, 'GPL', '12t', 0, 'Bleu'),
(283, 767984, 'U9-470-1W', '0000-00-00', '67881VGM467R', 34, 'Diesel', '12t', 0, 'Gris'),
(284, 481856, '51-646-00', '0000-00-00', 'B3199MIFIB1E', 24, 'Diesel', '32t', 0, 'Bleu'),
(285, 457655, 'RD-664-X9', '0000-00-00', '99AA9PZZW1WM', 37, 'Diesel', '12t', 0, 'Rouge'),
(286, 569555, '7P-787-N0', '0000-00-00', 'O00JLMCIRUKJ', 18, 'Essence', '32t', 0, 'Noir'),
(287, 746599, 'BA-937-17', '0000-00-00', 'M6DQ7Z2IF8QU', 28, 'Diesel', '12t', 0, ''),
(288, 720197, 'BV-160-A9', '0000-00-00', 'K0O7EUP2JPKM', 37, 'Diesel', '19t', 0, 'Blanc'),
(289, 349452, 'T6-232-0E', '0000-00-00', 'QQDAYDDH0NU4', 32, 'Diesel', '26t', 0, 'Blanc'),
(290, 391573, 'YZ-506-QD', '0000-00-00', 'J0M6KQKNXZAQ', 36, 'Diesel', '19t', 0, 'Gris'),
(291, 490673, 'XD-522-33', '0000-00-00', '1YH93ZG22QPO', 34, 'Diesel', '12t', 0, 'Noir'),
(292, 799860, '4A-394-JA', '0000-00-00', 'TGVCTO6EL7CA', 26, 'Diesel', '19t', 0, 'Gris'),
(293, 685352, 'WE-561-9V', '0000-00-00', 'Z59YEGS6FG0O', 27, 'Diesel', '26t', 0, 'Blanc'),
(294, 598619, 'SH-285-LG', '0000-00-00', 'DL7NZG43YYJW', 35, 'Diesel', '19t', 0, 'Bleu'),
(295, 567391, 'PI-79-GF', '0000-00-00', 'A0DRPAUQSHXU', 16, 'Diesel', '26t', 0, 'Gris'),
(296, 712549, '90-481-CM', '0000-00-00', '1NES1EDI4W7N', 20, 'Diesel', '32t', 0, 'Bleu'),
(297, 432815, 'KI-561-08', '0000-00-00', 'AS1SZDO06TN5', 37, 'Diesel', '19t', 0, 'Blanc'),
(298, 476239, '0O-288-G6', '0000-00-00', 'VTH2SZJ5OJA7', 20, 'Essence', '12t', 0, 'Blanc'),
(299, 366214, 'PU-271-6J', '0000-00-00', 'YZBJ4CWF3E93', 21, 'Essence', '12t', 0, 'Blanc'),
(300, 815608, 'OX-388-E5', '0000-00-00', 'Q5FFH19TD2YU', 34, 'Essence', '12t', 0, 'Gris'),
(301, 654033, 'KL-284-OH', '0000-00-00', '36DA4RCUBLWD', 24, 'Diesel', '12t', 0, 'Gris'),
(302, 281770, 'NQ-798-5G', '0000-00-00', 'ZPR29P5MJ638', 21, 'Diesel', '26t', 0, 'Blanc'),
(303, 453146, '6C-761-V6', '0000-00-00', '5Y4R204AACJD', 33, 'Diesel', '12t', 0, 'Blanc'),
(304, 704426, '65-349-KY', '0000-00-00', 'DEIP039R6W2B', 30, 'Essence', '26t', 0, 'Gris'),
(305, 409767, 'M0-608-I7', '0000-00-00', 'R5SGSHGCKNFF', 17, 'Essence', '32t', 0, 'Gris'),
(306, 477165, 'QL-734-X7', '0000-00-00', '5YSAY38RKOJ8', 40, 'Diesel', '12t', 0, 'Bleu'),
(307, 816187, 'DO-639-G3', '0000-00-00', 'MIFI748CHABH', 38, 'Electrique', '12t', 0, 'Noir'),
(308, 725046, '17-131-KH', '0000-00-00', 'IX7QI6YZ9I5K', 27, 'Diesel', '12t', 0, 'Bleu'),
(309, 753413, 'NP-116-UB', '0000-00-00', '0H3FHX49AUAZ', 38, 'Diesel', '12t', 0, 'Gris'),
(310, 314261, 'YP-298-PK', '0000-00-00', 'SNRQQ78DYRGJ', 30, 'Hydrogène', '12t', 0, 'Blanc'),
(311, 309892, 'BA-978-8Q', '0000-00-00', 'REFTO5405VGA', 21, 'Diesel', '26t', 0, 'Gris'),
(312, 661210, 'F4-796-4R', '0000-00-00', 'JQPMPR3VHSNO', 34, 'Essence', '12t', 0, 'Gris'),
(313, 472085, 'AE-240-NN', '0000-00-00', 'NKHHR60LI5KP', 34, 'Essence', '19t', 0, 'Vert'),
(314, 734786, 'I4-441-JM', '0000-00-00', 'PZV1V9EB1ZQ9', 18, 'Diesel', '32t', 0, 'Blanc'),
(315, 262524, '5R-739-PM', '0000-00-00', 'B36TNXPICJ2Q', 20, 'Diesel', '12t', 0, 'Blanc'),
(316, 488554, 'P3-851-GK', '0000-00-00', 'BX26JI9ZWODY', 32, 'Essence', '19t', 0, 'Blanc'),
(317, 261812, 'JR-687-JQ', '0000-00-00', 'TTV8BBFP3X34', 34, 'Diesel', '12t', 0, 'Gris'),
(318, 301605, 'IX-789-0X', '0000-00-00', '3HAEEMFM886E', 33, 'Diesel', '12t', 0, 'Bleu'),
(319, 265019, 'RZ-554-5J', '0000-00-00', 'JXW9QNCFJKKI', 39, 'GPL', '26t', 0, 'Gris'),
(320, 848363, '18-786-PY', '0000-00-00', 'WUZLO4U8Y92G', 22, 'Essence', '12t', 0, 'Vert'),
(321, 311233, 'JT-502-BC', '0000-00-00', 'B9P5OONRUA54', 36, 'Diesel', '19t', 0, 'Gris'),
(322, 293903, 'K5-524-W5', '0000-00-00', '6UZ3FB7ZNRRO', 21, 'Diesel', '', 0, 'Blanc'),
(323, 725851, 'TN-791-1U', '0000-00-00', 'S81W79D4R3MG', 25, 'Diesel', '12t', 0, 'Blanc'),
(324, 599538, 'W4-795-DP', '0000-00-00', '0I6OS1QSFYVH', 28, 'GPL', '26t', 0, 'Blanc'),
(325, 599346, 'OB-921-3A', '0000-00-00', 'NWBCC6T9B1HR', 22, 'Diesel', '12t', 0, 'Bleu'),
(326, 834720, 'YU-536-Z5', '0000-00-00', 'LVYN2X57L18W', 22, 'Essence', '19t', 0, 'Noir'),
(327, 266980, 'TZ-919-MY', '0000-00-00', 'FGYI0FWYDA2U', 19, 'Essence', '26t', 0, 'Gris'),
(328, 805833, '7A-297-32', '0000-00-00', 'IDJLHOGQN6QC', 39, 'GPL', '26t', 0, 'Noir'),
(329, 618477, 'WC-898-00', '0000-00-00', 'GFA99B4ZUHMM', 17, 'Diesel', '12t', 0, 'Blanc'),
(330, 704659, 'TN-847-52', '0000-00-00', 'SJHZXES83J9Y', 23, 'Diesel', '19t', 0, 'Blanc'),
(331, 790478, 'S9-126-KM', '0000-00-00', 'VF8OEBSKDJBQ', 39, 'Essence', '26t', 0, 'Gris'),
(332, 423542, 'BU-817-6U', '0000-00-00', 'P9BB8DDSPB19', 18, 'Diesel', '19t', 0, 'Bleu'),
(333, 857590, 'RD-266-F8', '0000-00-00', 'MBS0WLQFLR6H', 24, 'Diesel', '32t', 0, 'Bleu'),
(334, 818405, '3P-119-N5', '0000-00-00', 'CROIVBE3ENH7', 15, 'Diesel', '19t', 0, 'Blanc'),
(335, 815938, 'W1-368-8A', '0000-00-00', 'P6W2997EG81N', 18, 'Electrique', '12t', 0, 'Bleu'),
(336, 768758, 'XJ-455-S2', '0000-00-00', '14FWHMPX90UY', 40, 'Electrique', '12t', 0, 'Blanc'),
(337, 377051, 'NF-210-OL', '0000-00-00', 'SL9P79GGHSHV', 39, 'Diesel', '12t', 0, 'Blanc'),
(338, 765486, 'FX-92-AY', '0000-00-00', 'JOWXE6EI4AM5', 32, 'Diesel', '26t', 0, 'Blanc'),
(339, 721379, 'KM-72-BX', '0000-00-00', '2S8QXQ7UP353', 32, 'Diesel', '12t', 0, 'Noir'),
(340, 425677, 'CC-134-MH', '0000-00-00', 'X9ZUT09VBMCE', 29, 'Diesel', '12t', 0, 'Gris'),
(341, 629440, 'G7-171-O2', '0000-00-00', 'X1SDXCYVECB3', 19, 'Diesel', '12t', 0, 'Blanc'),
(342, 706569, 'WV-419-L9', '0000-00-00', '9FTMBRCJ3HF6', 27, 'Essence', '12t', 0, 'Blanc'),
(343, 563320, 'NC-277-Y6', '0000-00-00', '1OFDEUT4DRDM', 23, 'Diesel', '19t', 0, 'Blanc'),
(344, 368991, 'EG-896-IU', '0000-00-00', 'MO3N3UEKAB81', 39, 'Electrique', '12t', 0, 'Bleu'),
(345, 363663, '19-795-33', '0000-00-00', '02FMR6G03S7F', 21, 'Diesel', '12t', 0, 'Gris'),
(346, 472318, '8B-846-9D', '0000-00-00', 'Y1N0IEODGCQC', 18, 'Diesel', '26t', 0, 'Blanc'),
(347, 561457, 'L8-564-YW', '0000-00-00', 'YIAVX9HSFI26', 26, 'Diesel', '32t', 0, 'Noir'),
(348, 385511, '7O-909-7T', '0000-00-00', 'QVB939YJ30RZ', 16, 'Diesel', '19t', 0, 'Gris'),
(349, 260877, 'DS-840-4J', '0000-00-00', 'FZB0BSQQ3JO3', 21, 'Essence', '12t', 0, 'Gris'),
(350, 573570, 'SX-659-8J', '0000-00-00', 'TGQRWLFGMNT0', 16, 'Essence', '12t', 0, 'Bleu'),
(351, 484307, 'YA-631-MX', '0000-00-00', 'MCHOBAB8F8QX', 15, 'Diesel', '12t', 0, 'Blanc'),
(352, 265474, '0G-505-OX', '0000-00-00', 'CE9JT3N86KYG', 15, 'GPL', '12t', 0, 'Noir'),
(353, 754906, 'US-827-PV', '0000-00-00', 'NN7Z7V7THIQ7', 30, 'Diesel', '26t', 0, 'Vert'),
(354, 335893, '98-306-UB', '0000-00-00', 'CUSW7GW7TVGH', 34, 'GPL', '12t', 0, 'Bleu'),
(355, 360167, 'ZR-650-NX', '0000-00-00', 'WF3IZBXBU8E6', 40, 'Diesel', '19t', 0, 'Blanc'),
(356, 719313, 'JX-173-6I', '0000-00-00', 'QIVLZR22UQL0', 33, 'Diesel', '12t', 0, 'Blanc'),
(357, 350731, 'D2-520-B7', '0000-00-00', 'S40SLAOR9SQE', 27, 'Essence', '12t', 0, 'Blanc'),
(358, 513513, '3A-341-PZ', '0000-00-00', 'GBJU6KZXMB2I', 22, 'Diesel', '32t', 0, 'Noir'),
(359, 723240, '7D-527-A4', '0000-00-00', '0FA4HM4R6DV0', 31, 'Diesel', '19t', 0, 'Noir'),
(360, 666734, 'MV-909-MP', '0000-00-00', 'JMCLUFBQQIXF', 21, '', '19t', 0, 'Gris'),
(361, 498009, '29-984-0I', '0000-00-00', '8WIID0EVZ6R7', 16, 'Diesel', '12t', 0, 'Blanc'),
(362, 664407, 'RD-831-1P', '0000-00-00', '9950JTA5X0ZB', 15, 'Diesel', '12t', 0, 'Noir'),
(363, 630195, 'JQ-551-P6', '0000-00-00', '1N89L4JRTEP2', 21, 'Diesel', '32t', 0, 'Vert'),
(364, 257049, 'O8-480-2S', '0000-00-00', 'HONQCXFB2WQR', 32, 'Diesel', '19t', 0, 'Noir'),
(365, 841172, 'AW-751-8Z', '0000-00-00', 'DKR3VH257ES3', 26, 'Diesel', '26t', 0, 'Blanc'),
(366, 342944, '43-875-J0', '0000-00-00', 'T11CRWL9EIP8', 23, 'Essence', '12t', 0, 'Blanc'),
(367, 627182, 'QZ-480-NM', '0000-00-00', 'N3OCDO5X0ZCO', 33, 'Diesel', '26t', 0, 'Gris'),
(368, 535182, '8T-147-VZ', '0000-00-00', 'AM16ISW2MDV1', 33, 'Diesel', '26t', 0, 'Gris'),
(369, 829716, 'QL-624-WC', '0000-00-00', 'W5M4JVIGLXE1', 35, 'GPL', '12t', 0, 'Blanc'),
(370, 423813, 'FG-939-Q6', '0000-00-00', '0APLX29OAY91', 19, 'Diesel', '19t', 0, 'Blanc'),
(371, 486033, '6X-541-2D', '0000-00-00', '4M6CNKT1I91G', 22, 'GPL', '12t', 0, 'Blanc'),
(372, 539927, '42-751-K0', '0000-00-00', 'A52OI8Z5KDKB', 35, 'Diesel', '12t', 0, 'Gris'),
(373, 778063, 'VK-955-KQ', '0000-00-00', 'SB59SU3WSZJ4', 19, 'Diesel', '19t', 0, 'Noir'),
(374, 882363, 'PB-198-C4', '0000-00-00', '5GCVHERV8GR9', 17, 'Diesel', '19t', 0, 'Bleu'),
(375, 805116, '9W-115-ES', '0000-00-00', 'DX7IODT3VN56', 38, 'Diesel', '19t', 0, 'Blanc'),
(376, 769918, 'Y1-655-EA', '0000-00-00', 'XSJI1BSIIOY2', 23, 'Diesel', '19t', 0, 'Noir'),
(377, 753599, 'QO-411-RP', '0000-00-00', '2P5LGXUVS28L', 34, 'Diesel', '32t', 0, 'Blanc'),
(378, 253338, 'DH-188-5W', '0000-00-00', 'YROLC06VPKJV', 34, 'Diesel', '32t', 0, 'Gris'),
(379, 470706, 'DK-280-BX', '0000-00-00', 'J4QUAL56ZG6I', 17, 'Essence', '19t', 0, 'Blanc'),
(380, 534481, '2E-614-JP', '0000-00-00', 'WYSOHD6J8S12', 22, 'Diesel', '32t', 0, 'Blanc'),
(381, 554956, 'DJ-847-X5', '0000-00-00', '60V10QJ2N0GV', 38, 'Diesel', '12t', 0, 'Blanc'),
(382, 866234, '98-758-9N', '0000-00-00', 'GAYMSM2ENDWV', 30, 'Essence', '12t', 0, 'Gris'),
(383, 725931, 'MX-277-WC', '0000-00-00', 'SB9SNJMD75O3', 26, 'Diesel', '32t', 0, 'Blanc'),
(384, 871828, 'AN-558-1X', '0000-00-00', 'P76CEXSTH60Z', 39, 'Essence', '12t', 0, 'Noir'),
(385, 603616, 'PO-870-7X', '0000-00-00', 'RV4ERRPLQYG1', 33, 'Diesel', '26t', 0, 'Bleu'),
(386, 700975, 'DL-691-VV', '0000-00-00', 'H7C1YDUW50MM', 20, 'Diesel', '19t', 0, 'Gris'),
(387, 573725, '29-637-93', '0000-00-00', 'HRQKBGSWQJYK', 29, 'Diesel', '19t', 0, 'Noir'),
(388, 404003, '7Y-912-SB', '0000-00-00', '3GXXDOZL67LH', 35, 'Essence', '44t', 0, 'Gris'),
(389, 448904, 'BL-48-MI', '0000-00-00', '75HP89GOS5L9', 28, 'Diesel', '12t', 0, 'Blanc'),
(390, 628225, '0E-560-WB', '0000-00-00', 'UPK9H2RPWG25', 18, 'Diesel', '12t', 0, 'Blanc'),
(391, 270393, 'Q1-989-6I', '0000-00-00', 'DT8UQCOLF5GL', 36, 'Diesel', '19t', 0, 'Gris'),
(392, 610767, 'J7-363-M5', '0000-00-00', 'IY2JGZ4O1HIV', 27, 'Essence', '12t', 0, 'Noir'),
(393, 556560, 'VK-364-QZ', '0000-00-00', 'GJGYT3UCIPS1', 40, 'Diesel', '26t', 0, 'Bleu'),
(394, 437093, 'TC-293-3H', '0000-00-00', 'TD2ZJ0DIXRB3', 31, 'Diesel', '12t', 0, 'Noir'),
(395, 714233, 'MQ-974-XI', '0000-00-00', 'ETYLI9R5E0J6', 40, 'GPL', '19t', 0, 'Gris'),
(396, 843811, 'X7-921-TK', '0000-00-00', '1WAJM74WG8MT', 24, 'Essence', '26t', 0, 'Vert'),
(397, 473787, 'JG-95-OI', '0000-00-00', 'MD909MX1IPK4', 25, 'Diesel', '12t', 0, 'Blanc'),
(398, 609309, 'VB-987-2X', '0000-00-00', 'WUNUHO31DGLV', 40, 'Diesel', '', 0, 'Bleu'),
(399, 816171, '5L-133-HD', '0000-00-00', 'JPNGFD5YG407', 26, 'Diesel', '19t', 0, 'Gris'),
(400, 840816, 'IU-911-2U', '0000-00-00', 'IXD0O75RQO14', 38, 'Essence', '12t', 0, 'Bleu'),
(401, 379039, '5N-387-UC', '0000-00-00', 'W5KC6CSKQ2DH', 32, 'GPL', '19t', 0, 'Blanc'),
(402, 505879, 'L9-937-T1', '0000-00-00', 'XIBYM1QH7FEZ', 25, 'Diesel', '12t', 0, 'Blanc'),
(403, 302926, '3F-49-VW', '0000-00-00', '92CPAZ1HHFS2', 23, 'Essence', '32t', 0, 'Blanc');

-- --------------------------------------------------------

--
-- Structure de la table `trucks_capacity`
--

CREATE TABLE `trucks_capacity` (
  `PTAC` varchar(3) NOT NULL,
  `EPAL` int(11) NOT NULL,
  `EPAL (half)` int(11) NOT NULL,
  `ISO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `trucks_consumption`
--

CREATE TABLE `trucks_consumption` (
  `PTAC` varchar(3) DEFAULT NULL,
  `DIESEL (L)` float DEFAULT NULL,
  `GASOLINE (L)` float DEFAULT NULL,
  `LPG (kg)` float DEFAULT NULL,
  `ELECTRIC (kWh)` float DEFAULT NULL,
  `HYDROGEN (kg)` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`PK_TRUCK`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `trucks`
--
ALTER TABLE `trucks`
  MODIFY `PK_TRUCK` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
