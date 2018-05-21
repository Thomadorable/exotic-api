-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Client :  localhost:8889
-- Généré le :  Ven 11 Mai 2018 à 07:55
-- Version du serveur :  5.5.42
-- Version de PHP :  7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données :  `exotic`
--

-- --------------------------------------------------------

--
-- Structure de la table `boutique`
--

CREATE TABLE `boutique` (
  `id_boutique` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `lieu` text NOT NULL,
  `id_proprietaire` int(11) NOT NULL,
  `lat` float NOT NULL,
  `lng` float NOT NULL,
  `nb_visites` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `boutique`
--

INSERT INTO `boutique` (`id_boutique`, `nom`, `lieu`, `id_proprietaire`, `lat`, `lng`, `nb_visites`) VALUES
(1, 'Donnelly-Schimmel', '33 Victoria Way', 59, 48.8512, 2.3262, 0),
(2, 'Hilll, Hudson and Muller', '959 Westridge Trail', 90, 48.8391, 2.4245, 0),
(3, 'Brown Inc', '36383 Bellgrove Plaza', 94, 48.8779, 2.2863, 0),
(4, 'Koelpin and Sons', '97 Duke Court', 53, 48.8183, 2.3516, 0),
(5, 'Kohler-Bechtelar', '866 Graceland Center', 12, 48.877, 2.3539, 0),
(6, 'Bins, Walter and Padberg', '6257 Mcguire Park', 87, 48.8789, 2.3781, 0),
(7, 'Price Group', '81 Sutherland Pass', 85, 48.8956, 2.3282, 0),
(8, 'Medhurst-Konopelski', '6 Northland Center', 1, 48.8722, 2.2872, 0),
(9, 'Kris, Bernhard and Bernhard', '3 Northport Terrace', 20, 48.8503, 2.2724, 0),
(10, 'Ziemann, Huels and Friesen', '5582 Michigan Alley', 83, 48.8168, 2.266, 0),
(11, 'Kub Inc', '17 Mitchell Center', 90, 48.8353, 2.4282, 0),
(12, 'Block LLC', '458 Oxford Drive', 3, 48.8786, 2.2809, 0),
(13, 'Smitham Group', '31 Doe Crossing Junction', 51, 48.8269, 2.4086, 0),
(14, 'Thompson-Monahan', '404 Marquette Circle', 88, 48.8537, 2.3418, 0),
(15, 'Hegmann LLC', '457 Novick Avenue', 20, 48.8759, 2.341, 0),
(16, 'Skiles, Quigley and Bins', '042 Mosinee Drive', 60, 48.8803, 2.4022, 0),
(17, 'Reichel-Homenick', '95232 Sutteridge Terrace', 63, 48.8845, 2.2913, 0),
(18, 'Konopelski and Sons', '7 Troy Avenue', 23, 48.8332, 2.308, 0),
(19, 'Stamm-Kessler', '3 La Follette Avenue', 76, 48.8348, 2.3708, 0),
(20, 'McCullough-Wisoky', '19368 Pearson Circle', 64, 48.8354, 2.4196, 0),
(21, 'Wyman Inc', '92 Golf Course Crossing', 17, 48.8627, 2.3341, 0),
(22, 'Runte, Boyer and Lakin', '6 Ilene Trail', 65, 48.8165, 2.3681, 1),
(23, 'Berge, Schamberger and Leuschke', '691 Washington Road', 73, 48.853, 2.3748, 0),
(24, 'Anderson, Blick and Kuphal', '2320 Sauthoff Terrace', 25, 48.8657, 2.299, 0),
(25, 'Shanahan Group', '3123 Haas Place', 1, 48.83, 2.4063, 0),
(26, 'Stark-Bahringer', '8137 Loftsgordon Crossing', 56, 48.8159, 2.3718, 0),
(27, 'Streich LLC', '81682 Orin Park', 82, 48.8449, 2.3259, 0),
(28, 'Cummings-Ward', '610 Green Trail', 87, 48.8615, 2.386, 0),
(29, 'Cremin and Sons', '8 Shoshone Pass', 59, 48.8192, 2.3849, 0),
(30, 'Satterfield LLC', '8 Waxwing Hill', 91, 48.8686, 2.3204, 0),
(31, 'Feeney, Labadie and Bogisich', '8772 Bonner Way', 19, 48.821, 2.4243, 0),
(32, 'Ledner and Sons', '1122 Thackeray Junction', 83, 48.8317, 2.365, 1),
(33, 'Wuckert Group', '03560 New Castle Road', 9, 48.8992, 2.3437, 0),
(34, 'Zboncak, Fadel and Prosacco', '45 Little Fleur Junction', 42, 48.8563, 2.3812, 0),
(35, 'Williamson and Sons', '5 Bobwhite Hill', 13, 48.8195, 2.3584, 0),
(36, 'Reichel-Daniel', '987 Monument Drive', 16, 48.8471, 2.4028, 0),
(37, 'Runolfsdottir and Sons', '895 Farwell Alley', 72, 48.9094, 2.3067, 0),
(38, 'Terry-Upton', '931 Westend Parkway', 91, 48.8946, 2.4185, 0),
(39, 'Wintheiser-Wiegand', '1 Drewry Terrace', 6, 48.8586, 2.2949, 0),
(40, 'Grady, Reichel and Bergstrom', '71 Pawling Junction', 85, 48.8529, 2.2699, 0),
(41, 'Rath, Stanton and Braun', '53753 Brown Way', 93, 48.8575, 2.3725, 0),
(42, 'Rau, Paucek and Satterfield', '43195 Carpenter Road', 73, 48.8345, 2.3252, 0),
(43, 'Skiles, Hettinger and Torp', '374 Anzinger Hill', 11, 48.8267, 2.3568, 0),
(44, 'Kreiger-Jenkins', '03 Doe Crossing Center', 83, 48.8655, 2.4247, 0),
(45, 'Kuhic-Schmeler', '9 Mosinee Crossing', 25, 48.8437, 2.4125, 0),
(46, 'Kohler and Sons', '0 Di Loreto Circle', 9, 48.897, 2.2751, 0),
(47, 'Barton Group', '01 Swallow Trail', 67, 48.8647, 2.397, 0),
(48, 'Gutmann Inc', '2085 Kenwood Way', 1, 48.8203, 2.4025, 0),
(49, 'Pfeffer and Sons', '642 Roth Road', 7, 48.8444, 2.3418, 0),
(50, 'Auer, Bailey and Satterfield', '0 Kennedy Lane', 56, 48.8647, 2.3889, 0),
(51, 'Feeney-Bradtke', '13909 Killdeer Road', 72, 48.9086, 2.3731, 0),
(52, 'Spencer-O''Keefe', '2142 Clemons Terrace', 5, 48.8355, 2.4285, 0),
(53, 'Ledner and Sons', '65 Rieder Crossing', 86, 48.8767, 2.2794, 0),
(54, 'Lakin-Bradtke', '64124 Victoria Alley', 57, 48.8647, 2.3275, 0),
(55, 'Emmerich-Littel', '27458 Oakridge Drive', 26, 48.8737, 2.377, 1),
(56, 'Adams-Price', '1368 Milwaukee Crossing', 78, 48.8491, 2.4267, 0),
(57, 'McCullough-Cronin', '39394 Myrtle Parkway', 30, 48.8433, 2.3435, 0),
(58, 'Hermann Group', '01129 Declaration Crossing', 9, 48.8324, 2.428, 0),
(59, 'Paucek-Feest', '8 Arapahoe Hill', 41, 48.8332, 2.3076, 0),
(60, 'Abbott Group', '61 Superior Crossing', 53, 48.8269, 2.3047, 0),
(61, 'Cartwright-Sawayn', '96806 Northridge Road', 63, 48.8372, 2.3907, 0),
(62, 'Kautzer and Sons', '9193 Loomis Parkway', 48, 48.8809, 2.3709, 0),
(63, 'Watsica, Swift and Grant', '1329 Sutteridge Road', 31, 48.876, 2.333, 0),
(64, 'Glover-Rutherford', '886 Division Road', 28, 48.8481, 2.2911, 0),
(65, 'Hodkiewicz, Kris and Watsica', '6141 Toban Alley', 87, 48.8208, 2.3409, 0),
(66, 'Senger Group', '55291 Cardinal Hill', 11, 48.8417, 2.4241, 0),
(67, 'Brown, O''Kon and Witting', '1209 Mayfield Terrace', 22, 48.8698, 2.2874, 0),
(68, 'Willms-Larkin', '89 Paget Crossing', 85, 48.8679, 2.3731, 0),
(69, 'Barton, Crona and Johns', '59146 Pierstorff Alley', 57, 48.8413, 2.3027, 0),
(70, 'Jaskolski-Lynch', '0818 Manitowish Junction', 26, 48.8187, 2.4265, 0),
(71, 'Lehner, Carroll and Nienow', '7 Rue de Caumartin, 75009 Paris', 2, 48.909, 2.3476, 120),
(72, 'Beatty Inc', '496 Rockefeller Point', 58, 48.8235, 2.2988, 0),
(73, 'Hodkiewicz Inc', '35 Hayes Street', 52, 48.8591, 2.3096, 0),
(74, 'Cummings, Lesch and Marquardt', '2 Jenifer Avenue', 11, 48.8153, 2.2834, 0),
(75, 'Powlowski LLC', '21 Lake View Park', 17, 48.8791, 2.3951, 0),
(76, 'Beahan-Koch', '12 Blaine Hill', 58, 48.8148, 2.3111, 0),
(77, 'Klein-Volkman', '7031 Kings Circle', 24, 48.8343, 2.2762, 0),
(78, 'Purdy Inc', '8600 Weeping Birch Plaza', 53, 48.8143, 2.4241, 0),
(79, 'Halvorson, Bruen and Kling', '55 Nova Center', 49, 48.8437, 2.389, 0),
(80, 'Cronin, Howe and Zemlak', '9830 Wayridge Street', 92, 48.8507, 2.3193, 0),
(81, 'Mohr-Kris', '343 Chive Place', 61, 48.8893, 2.3835, 0),
(82, 'Stroman-Spinka', '28236 Laurel Plaza', 52, 48.8299, 2.3661, 0),
(83, 'Ledner, Towne and Jerde', '5238 Mallard Drive', 89, 48.8694, 2.28, 0),
(84, 'Carroll-Douglas', '0908 Maple Wood Park', 43, 48.8301, 2.3775, 0),
(85, 'Romaguera, Tillman and Zemlak', '97924 Farmco Alley', 51, 48.8231, 2.2686, 0),
(86, 'Bartoletti, Kreiger and Leannon', '7562 Memorial Hill', 83, 48.8458, 2.3541, 0),
(87, 'Johnson Group', '45 Shelley Parkway', 11, 48.9061, 2.359, 0),
(88, 'Leannon Inc', '74 Browning Crossing', 70, 48.8127, 2.3232, 0),
(89, 'Graham-Renner', '54 Russell Terrace', 79, 48.8613, 2.3853, 0),
(90, 'Emmerich-McKenzie', '2 Red Cloud Park', 41, 48.8469, 2.4124, 0),
(91, 'Reynolds-Langosh', '4375 Sachs Junction', 99, 48.8969, 2.3517, 0),
(92, 'Harris-Keebler', '4669 Basil Trail', 60, 48.851, 2.4243, 0),
(93, 'Hilll-Moen', '7 Blackbird Center', 43, 48.9037, 2.2818, 0),
(94, 'Ryan, Reichert and Schinner', '6 Schlimgen Center', 17, 48.8384, 2.366, 0),
(95, 'Schuppe, Ebert and Metz', '13745 Schlimgen Plaza', 62, 48.8144, 2.2726, 0),
(96, 'Pouros-Rosenbaum', '02 Granby Point', 57, 48.8698, 2.3642, 0),
(97, 'Goldner, Stehr and Langosh', '4 Carberry Point', 68, 48.8306, 2.3298, 0),
(98, 'Kuhic-Volkman', '73 Calypso Place', 54, 48.9071, 2.2848, 0),
(99, 'Fisher, McGlynn and Cremin', '4 Division Pass', 45, 48.81, 2.3827, 0),
(100, 'Wintheiser LLC', '4197 Moose Road', 97, 48.8632, 2.3739, 0);

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id_categorie` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`id_categorie`, `nom`) VALUES
(1, 'Boisson'),
(2, 'Fruit'),
(3, 'Légume');

-- --------------------------------------------------------

--
-- Structure de la table `categorisation`
--

CREATE TABLE `categorisation` (
  `id_categorisation` int(11) NOT NULL,
  `id_categorie` int(11) NOT NULL,
  `id_produit` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `categorisation`
--

INSERT INTO `categorisation` (`id_categorisation`, `id_categorie`, `id_produit`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 2, 4),
(4, 3, 5),
(5, 3, 6),
(6, 3, 7),
(7, 1, 8),
(8, 1, 9),
(9, 2, 10),
(10, 2, 11),
(11, 1, 12),
(12, 1, 13),
(13, 3, 14),
(14, 3, 15),
(15, 2, 16),
(16, 2, 17),
(17, 1, 18),
(18, 3, 19),
(19, 1, 20),
(20, 1, 21),
(21, 2, 22),
(22, 3, 23),
(23, 2, 24),
(24, 2, 25),
(25, 2, 26),
(26, 1, 27),
(27, 1, 28),
(28, 1, 29),
(29, 1, 30),
(30, 1, 31),
(31, 2, 32),
(32, 3, 33),
(33, 3, 34),
(34, 2, 35),
(35, 2, 36),
(36, 2, 37),
(37, 1, 38),
(38, 2, 39),
(39, 2, 40),
(40, 2, 41),
(41, 2, 42),
(42, 3, 43),
(43, 2, 44),
(44, 3, 45),
(45, 3, 46),
(46, 1, 47),
(47, 1, 48),
(48, 2, 49),
(49, 1, 50),
(50, 1, 51),
(51, 2, 52),
(52, 3, 53),
(53, 1, 54),
(54, 2, 55),
(55, 1, 56),
(56, 3, 57),
(57, 1, 58),
(58, 1, 59),
(59, 1, 60),
(60, 3, 61),
(61, 2, 62),
(62, 1, 63),
(63, 3, 64),
(64, 1, 65),
(65, 1, 66),
(66, 3, 67),
(67, 2, 68),
(68, 1, 69),
(69, 1, 70),
(70, 3, 71),
(71, 1, 72),
(72, 1, 73),
(73, 3, 74),
(74, 2, 75),
(75, 1, 76),
(76, 3, 77),
(77, 3, 78),
(78, 2, 79),
(79, 3, 80),
(80, 2, 81),
(81, 3, 82),
(82, 2, 83),
(83, 3, 84),
(84, 3, 85),
(85, 3, 86),
(86, 1, 87),
(87, 3, 88),
(88, 2, 89),
(89, 2, 90),
(90, 2, 91),
(91, 3, 92),
(92, 1, 93),
(93, 1, 94),
(94, 3, 95),
(95, 1, 96),
(96, 3, 97),
(97, 2, 98),
(98, 1, 99),
(99, 3, 100),
(100, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `localisation`
--

CREATE TABLE `localisation` (
  `id_localisation` int(11) NOT NULL,
  `id_produit` int(11) NOT NULL,
  `id_boutique` int(11) NOT NULL,
  `prix` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `localisation`
--

INSERT INTO `localisation` (`id_localisation`, `id_produit`, `id_boutique`, `prix`, `stock`) VALUES
(1, 2, 55, '52€', 0),
(2, 2, 71, '2€', 20),
(3, 3, 18, '457', 0),
(4, 4, 82, '204', 0),
(5, 5, 89, '901', 0),
(6, 6, 87, '290', 0),
(7, 7, 100, '683', 0),
(8, 8, 46, '830', 0),
(9, 9, 78, '304', 0),
(10, 10, 59, '857', 0),
(11, 11, 95, '463', 0),
(12, 12, 68, '322', 0),
(13, 13, 63, '23', 0),
(14, 14, 46, '595', 0),
(15, 15, 68, '130', 0),
(16, 16, 72, '231', 0),
(17, 17, 38, '198', 0),
(18, 18, 90, '45', 0),
(19, 19, 68, '380', 0),
(20, 20, 81, '145', 0),
(21, 21, 50, '467', 0),
(22, 22, 25, '507', 0),
(23, 23, 89, '728', 0),
(24, 24, 55, '684', 0),
(25, 25, 100, '408', 0),
(26, 26, 1, '876', 0),
(27, 27, 27, '1', 0),
(28, 28, 12, '865', 0),
(29, 29, 92, '296', 0),
(30, 30, 74, '513', 0),
(31, 31, 17, '847', 0),
(32, 32, 58, '968', 0),
(33, 33, 36, '15', 0),
(34, 34, 32, '414', 0),
(35, 35, 36, '37', 0),
(36, 36, 14, '882', 0),
(37, 37, 85, '661', 0),
(38, 38, 12, '412', 0),
(39, 39, 97, '695', 0),
(40, 40, 16, '344', 0),
(41, 41, 23, '940', 0),
(42, 42, 73, '308', 0),
(43, 43, 1, '58', 0),
(44, 44, 40, '645', 0),
(45, 45, 46, '418', 0),
(46, 46, 34, '936', 0),
(47, 47, 56, '8', 0),
(48, 48, 5, '606', 0),
(49, 49, 39, '754', 0),
(50, 50, 1, '182', 0),
(51, 51, 69, '647', 0),
(52, 52, 98, '985', 0),
(53, 53, 1, '328', 0),
(54, 54, 12, '361', 0),
(55, 55, 49, '148', 0),
(56, 56, 16, '260', 0),
(57, 57, 66, '700', 0),
(58, 58, 63, '323', 0),
(59, 59, 35, '806', 0),
(60, 60, 73, '676', 0),
(61, 61, 9, '105', 0),
(62, 62, 24, '323', 0),
(63, 63, 43, '78', 0),
(64, 64, 61, '322', 0),
(65, 65, 72, '291', 0),
(66, 66, 62, '954', 0),
(67, 67, 62, '672', 0),
(68, 68, 17, '941', 0),
(69, 69, 63, '232', 0),
(70, 70, 14, '982', 0),
(71, 71, 40, '943', 0),
(72, 72, 67, '361', 0),
(73, 73, 65, '851', 0),
(74, 74, 25, '304', 0),
(75, 75, 55, '810', 0),
(76, 76, 63, '514', 0),
(77, 77, 51, '26', 0),
(78, 78, 86, '915', 0),
(79, 79, 84, '752', 0),
(80, 80, 47, '926', 0),
(81, 81, 66, '990', 0),
(82, 82, 61, '390', 0),
(83, 83, 61, '82', 0),
(84, 84, 31, '207', 0),
(85, 85, 97, '307', 0),
(86, 86, 46, '229', 0),
(87, 87, 2, '675', 0),
(88, 88, 5, '686', 0),
(89, 89, 26, '51', 0),
(90, 90, 48, '986', 0),
(91, 91, 6, '444', 0),
(92, 92, 70, '432', 0),
(93, 93, 96, '252', 0),
(94, 94, 8, '308', 0),
(95, 95, 21, '864', 0),
(96, 96, 33, '346', 0),
(97, 97, 62, '503', 0),
(98, 98, 54, '661', 0),
(99, 99, 28, '225', 0),
(100, 100, 20, '448', 0),
(101, 2, 51, '1.50€', 20),
(102, 2, 33, '3€', 1),
(103, 2, 77, '5€', 20),
(104, 14, 71, '595', 0),
(105, 30, 71, '513', 0),
(106, 15, 71, '130', 0),
(107, 7, 71, '683', 0),
(108, 8, 71, '683', 0),
(109, 9, 71, '683', 0);

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

CREATE TABLE `marque` (
  `id_marque` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `marque`
--

INSERT INTO `marque` (`id_marque`, `nom`) VALUES
(0, 'Pas de marque'),
(1, 'Coca'),
(2, 'Danone');

-- --------------------------------------------------------

--
-- Structure de la table `photo`
--

CREATE TABLE `photo` (
  `id_photo` int(11) NOT NULL,
  `url` text NOT NULL,
  `id_produit` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `photo`
--

INSERT INTO `photo` (`id_photo`, `url`, `id_produit`) VALUES
(1, 'https://res.cloudinary.com/twenty20/private_images/t_low-fit/v1514089792/photosp/fe3db5e7-d273-4c2d-9110-f415f9ccd1f7/fe3db5e7-d273-4c2d-9110-f415f9ccd1f7.jpg', 2),
(2, 'https://res.cloudinary.com/twenty20/private_images/t_low-fit/v1442842541/photosp/fd34f6b4-ca9f-4b01-b001-6ecb9455be92/fd34f6b4-ca9f-4b01-b001-6ecb9455be92.jpg', 2),
(3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaGwlmJiV4aPTA7U--Xu_MOsVUp0R0Y1mxJb02zawRHQKiydOU', 2);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id_produit` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `echelle_prix` varchar(255) NOT NULL,
  `code_barre` varchar(255) NOT NULL,
  `id_theme` int(11) NOT NULL,
  `id_marque` int(11) NOT NULL,
  `nb_visites` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `produit`
--

INSERT INTO `produit` (`id_produit`, `nom`, `description`, `echelle_prix`, `code_barre`, `id_theme`, `id_marque`, `nb_visites`) VALUES
(1, 'Pasta - Orzo, Dry', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '€8,11', '8474989205', 1, 0, 20),
(2, 'Mangue asiatique', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.\n\nDonec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 'Entre 2 et 5€', '123456789', 1, 0, 238),
(3, 'Neckerchief Blck', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.\r\n\r\nVestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '€3,96', '5275610009', 3, 0, 1),
(4, 'Island Oasis - Banana Daiquiri', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '€22,09', '8502808761', 4, 0, 7),
(5, 'Beets - Candy Cane, Organic', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.\r\n\r\nMorbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '€11,34', '5630882198', 5, 0, 2),
(6, 'Orange Roughy 6/8 Oz', 'Fusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '€6,88', '3938444177', 6, 0, 19),
(7, 'Flour - Masa De Harina Mexican', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.\r\n\r\nMaecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '€25,42', '2809068615', 35, 0, 2),
(8, 'Nantucket Apple Juice', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.\n\nDonec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '€26,40', '9818078829', 35, 0, 2),
(9, 'Soup - Campbells - Chicken Noodle', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.\r\n\r\nQuisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '€11,09', '1659335310', 35, 0, 0),
(10, 'Waffle Stix', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.\r\n\r\nNullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '€14,04', '7652393272', 10, 0, 0),
(11, 'Placemat - Scallop, White', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.\r\n\r\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '€18,37', '6566343253', 11, 0, 2),
(12, 'Pea - Snow', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.\r\n\r\nMauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\r\n\r\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '€18,23', '2021890376', 12, 0, 0),
(13, 'Cheese - Swiss', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '€24,40', '4357953650', 13, 0, 0),
(14, 'Chef Hat 20cm', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.\r\n\r\nInteger ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.\r\n\r\nNam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '€12,74', '8494207342', 14, 0, 0),
(15, 'Wine - Gato Negro Cabernet', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '€28,67', '7636192845', 1, 0, 0),
(16, 'Lemonade - Natural, 591 Ml', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '€14,68', '9876664646', 16, 0, 0),
(17, 'Salmon Steak - Cohoe 8 Oz', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\r\n\r\nFusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '€22,04', '0133955036', 17, 0, 0),
(18, 'Salt - Table', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '€18,61', '1241989079', 18, 0, 0),
(19, 'Wine - Port Late Bottled Vintage', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.\r\n\r\nSed ante. Vivamus tortor. Duis mattis egestas metus.\r\n\r\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '€18,80', '0630513562', 19, 0, 0),
(20, 'Cabbage - Green', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '€22,95', '6188323738', 20, 0, 1),
(21, 'Bread - Pumpernickel', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.\r\n\r\nPhasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '€8,33', '1397134100', 21, 0, 0),
(22, 'Melon - Watermelon Yellow', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.\r\n\r\nVestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.\r\n\r\nDuis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '€3,15', '2832389597', 22, 0, 2),
(23, 'Sobe - Liz Blizz', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\r\n\r\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '€13,24', '1604411589', 23, 0, 0),
(24, 'Beans - Butter Lrg Lima', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '€12,61', '4093614180', 24, 0, 0),
(25, 'Soup - Knorr, Ministrone', 'In congue. Etiam justo. Etiam pretium iaculis justo.\r\n\r\nIn hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.\r\n\r\nNulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '€14,18', '7000925973', 25, 0, 0),
(26, 'Curry Powder Madras', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.\r\n\r\nPhasellus in felis. Donec semper sapien a libero. Nam dui.\r\n\r\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '€17,68', '9379910851', 26, 0, 0),
(27, 'Wine - Two Oceans Cabernet', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '€12,26', '0200102133', 27, 0, 0),
(28, 'Pizza Pizza Dough', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\r\n\r\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.\r\n\r\nInteger tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '€4,17', '0784826765', 28, 0, 1),
(29, 'Soup - Base Broth Chix', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '€29,48', '6048894341', 29, 0, 2),
(30, 'Appetizer - Spring Roll, Veg', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '€11,55', '6940275649', 30, 0, 0),
(31, 'Ham - Smoked, Bone - In', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '€25,54', '3986226338', 31, 0, 0),
(32, 'Buttons', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '€22,13', '8602927541', 32, 0, 0),
(33, 'Lighter - Bbq', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\r\n\r\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '€21,54', '6368089636', 33, 0, 0),
(34, 'Rice - Basmati', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.\r\n\r\nDuis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.\r\n\r\nIn sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '€27,45', '4605088482', 34, 0, 0),
(35, 'Icecream Cone - Areo Chocolate', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '€8,63', '5592146930', 35, 0, 0),
(36, 'Smoked Tongue', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.\r\n\r\nQuisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '€25,47', '0720093023', 36, 0, 1),
(37, 'Seedlings - Mix, Organic', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.\r\n\r\nVestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '€26,32', '7566251651', 37, 0, 0),
(38, 'Wine - Marlbourough Sauv Blanc', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.\r\n\r\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '€26,12', '4661318358', 38, 0, 0),
(39, 'Pepsi, 355 Ml', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '€18,54', '8676389535', 39, 0, 0),
(40, 'Container - Clear 32 Oz', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '€3,33', '1062612906', 40, 0, 0),
(41, 'Lettuce - Treviso', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '€21,02', '8701393367', 41, 0, 0),
(42, 'Foam Cup 6 Oz', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\r\n\r\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '€5,54', '8891500224', 42, 0, 0),
(43, 'Beans - Kidney White', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '€1,95', '1960021524', 43, 0, 0),
(44, 'Juice - Orange, 341 Ml', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.\r\n\r\nMauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '€27,76', '2485818657', 44, 0, 2),
(45, 'Cheese - Cheddar, Medium', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.\r\n\r\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '€12,38', '2825119644', 45, 0, 0),
(46, 'Soup - Campbells - Tomato', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '€13,73', '6420598206', 46, 0, 0),
(47, 'Lotus Rootlets - Canned', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.\r\n\r\nMaecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '€2,19', '5303607216', 47, 0, 0),
(48, 'Crab - Claws, 26 - 30', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '€4,97', '6677893766', 48, 0, 0),
(49, 'Lemonade - Strawberry, 591 Ml', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.\r\n\r\nVestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.\r\n\r\nDuis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '€27,93', '5105749944', 49, 0, 0),
(50, 'Beer - Paulaner Hefeweisse', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '€23,57', '9970066609', 50, 0, 1),
(51, 'Soup - Campbells Chili', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\r\n\r\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\r\n\r\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '€20,16', '5094884301', 51, 0, 1),
(52, 'Cheese - Cheddar, Medium', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.\r\n\r\nIn hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '€11,34', '4160407358', 52, 0, 0),
(53, 'Cookies - Oreo, 4 Pack', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\r\n\r\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '€12,37', '5729483848', 53, 0, 0),
(54, 'Ecolab - Power Fusion', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '€7,93', '0228821479', 54, 0, 0),
(55, 'Wine - Pinot Grigio Collavini', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.\r\n\r\nDonec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.\r\n\r\nDuis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '€20,23', '6137217620', 55, 0, 0),
(56, 'Pepper - Paprika, Spanish', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '€3,83', '2769085298', 56, 0, 0),
(57, 'Fish - Bones', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '€13,26', '9136315125', 57, 0, 0),
(58, 'Sprouts - China Rose', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\r\n\r\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', '€9,88', '2244693228', 58, 0, 0),
(59, 'Wine - Duboeuf Beaujolais', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\r\n\r\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '€12,97', '3037587253', 59, 0, 1),
(60, 'Sea Bass - Fillets', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '€0,42', '5180434238', 60, 0, 0),
(61, 'Pepper - Roasted Red', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\r\n\r\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '€1,78', '9288951946', 61, 0, 0),
(62, 'Apples - Spartan', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\r\n\r\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\r\n\r\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '€27,31', '1291243666', 62, 0, 1),
(63, 'Thyme - Dried', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', '€2,95', '9803685147', 63, 0, 0),
(64, 'Venison - Striploin', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\r\n\r\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '€14,23', '5888149470', 64, 0, 1),
(65, 'Squash - Sunburst', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.\r\n\r\nMorbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\r\n\r\nFusce consequat. Nulla nisl. Nunc nisl.', '€3,22', '4131504499', 65, 0, 0),
(66, 'Coffee - Flavoured', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '€10,10', '2611039402', 66, 0, 0),
(67, 'Tomato Paste', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\r\n\r\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\r\n\r\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '€25,05', '5804691384', 67, 0, 0),
(68, 'Pastrami', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '€1,40', '1209812002', 68, 0, 0),
(69, 'Mushroom - Lg - Cello', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '€4,34', '0819725706', 69, 0, 0),
(70, 'Savory', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '€11,16', '3423839740', 70, 0, 1),
(71, 'Dawn Professionl Pot And Pan', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\r\n\r\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\r\n\r\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '€23,57', '4851483392', 71, 0, 0),
(72, 'Raisin - Golden', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '€12,95', '4475129974', 72, 0, 1),
(73, 'Beef - Kobe Striploin', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.\r\n\r\nSed ante. Vivamus tortor. Duis mattis egestas metus.\r\n\r\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '€13,44', '4856750542', 73, 0, 0),
(74, 'Chicken - Base', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.\r\n\r\nNulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.\r\n\r\nCras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', '€25,80', '3349949878', 74, 0, 1),
(75, 'Plasticknivesblack', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '€10,33', '6738730268', 75, 0, 0),
(76, 'Egg - Salad Premix', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '€15,47', '3952470406', 76, 0, 0),
(77, 'Sole - Dover, Whole, Fresh', 'Fusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '€12,39', '5452289526', 77, 0, 1),
(78, 'Cake - Sheet Strawberry', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', '€15,13', '3715012129', 78, 0, 1),
(79, 'Pasta - Tortellini, Fresh', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.\r\n\r\nSuspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', '€17,42', '3320243225', 79, 0, 0),
(80, 'Bread - Rye', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\r\n\r\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '€15,72', '8587681575', 80, 0, 0),
(81, 'Wheat - Soft Kernal Of Wheat', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '€6,14', '6418769287', 81, 0, 0),
(82, 'Pants Custom Dry Clean', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.\r\n\r\nMorbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '€0,78', '9242413976', 82, 0, 0),
(83, 'Chervil - Fresh', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.\r\n\r\nPhasellus in felis. Donec semper sapien a libero. Nam dui.', '€12,80', '7111616448', 83, 0, 1),
(84, 'Cheese - Cambozola', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '€27,14', '2935838238', 84, 0, 1),
(85, 'Tomatoes - Orange', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '€26,00', '6644944671', 85, 0, 1),
(86, 'Cake - Pancake', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '€3,65', '9376962109', 86, 0, 0),
(87, 'Crab - Soft Shell', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\r\n\r\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '€10,14', '0603810837', 87, 0, 0),
(88, 'Wine - Champagne Brut Veuve', 'Fusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '€19,73', '9245172430', 88, 0, 0),
(89, 'Pepper - Chilli Seeds Mild', 'Fusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '€28,04', '4116717029', 89, 0, 0),
(90, 'Creme De Menthe Green', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.\r\n\r\nDuis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.\r\n\r\nIn sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '€9,21', '1434821498', 90, 0, 0),
(91, 'Bread Ww Cluster', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\r\n\r\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '€19,23', '7934310374', 91, 0, 0),
(92, 'Wine - Chenin Blanc K.w.v.', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\r\n\r\nProin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\r\n\r\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '€20,43', '4902112590', 92, 0, 1),
(93, 'Tea Leaves - Oolong', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\r\n\r\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '€14,97', '4275414438', 93, 0, 0),
(94, 'Beans - Turtle, Black, Dry', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\r\n\r\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '€20,35', '6791826312', 94, 0, 0),
(95, 'Pants Custom Dry Clean', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.\r\n\r\nDuis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.\r\n\r\nMauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '€0,64', '6903726691', 95, 0, 1),
(96, 'Duck - Fat', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\r\n\r\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\r\n\r\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '€12,93', '5518586760', 96, 0, 0),
(97, 'Raspberries - Frozen', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\r\n\r\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.\r\n\r\nSed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '€22,76', '6281109430', 97, 0, 1),
(98, 'Bar Nature Valley', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.\r\n\r\nDuis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.\r\n\r\nMauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '€5,32', '8386046120', 98, 0, 0),
(99, 'Rambutan', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\r\n\r\nFusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '€3,32', '6145599332', 99, 0, 0),
(100, 'Soup - Knorr, Veg / Beef', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '€26,70', '5546916281', 100, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `proprietaire`
--

CREATE TABLE `proprietaire` (
  `id_proprietaire` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `mdp` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `proprietaire`
--

INSERT INTO `proprietaire` (`id_proprietaire`, `nom`, `mail`, `mdp`) VALUES
(1, 'Rachel Choisis', 'rachel.choisis@gmail.com', '5d41402abc4b2a76b9719d911017c592'),
(2, 'Thomas Deroua', 'thomas.deroua@hotmail.com', '5d41402abc4b2a76b9719d911017c592'),
(3, 'Issie Tincey', 'itincey2@businessweek.com', 'o3ZYDzX'),
(4, 'Tanny Le Jean', 'tle3@imdb.com', 'TK3k2Yx07Fa'),
(5, 'Lanna Gergolet', 'lgergolet4@sohu.com', 'vuk5n1PY8u'),
(6, 'Shamus McShea', 'smcshea5@yelp.com', 'IsiRowtZP'),
(7, 'Merilyn Ternott', 'mternott6@narod.ru', 'Rtaq9qr9'),
(8, 'Emalia Frostdyke', 'efrostdyke7@state.gov', 'NaVHNi7kz23h'),
(9, 'Maryellen Pevreal', 'mpevreal8@trellian.com', 'QV1PAL'),
(10, 'Corrine Buffham', 'cbuffham9@twitter.com', 'xcjqKq34Qif'),
(11, 'Papagena Mechic', 'pmechica@google.com.br', 'EZL3ZbiLyNUB'),
(12, 'Osborn Gianinotti', 'ogianinottib@nasa.gov', '1DNOfH3knX'),
(13, 'Pietro Yanne', 'pyannec@cdc.gov', '49Zi5WHwLX'),
(14, 'Kristofor MacBey', 'kmacbeyd@diigo.com', 'hER1apz'),
(15, 'Kelvin Wimmers', 'kwimmerse@gnu.org', '8iHjEYChmI'),
(16, 'Luce Dudney', 'ldudneyf@google.co.uk', '1Opm0QhmbQm'),
(17, 'Helli Lucy', 'hlucyg@yahoo.co.jp', 'aG0L9YOamE8'),
(18, 'Lura Spafford', 'lspaffordh@nsw.gov.au', 'jQiKpLooSw'),
(19, 'Tammie Crowdy', 'tcrowdyi@photobucket.com', '8BUIOvf'),
(20, 'Corty Bryant', 'cbryantj@addtoany.com', 'jd0qDcFK'),
(21, 'Amabel Scane', 'ascanek@tripadvisor.com', 'km0dYM2lYrM8'),
(22, 'Mikol Newby', 'mnewbyl@aboutads.info', 'hdXiqy'),
(23, 'Sheeree Learmont', 'slearmontm@wp.com', 'dIftOI'),
(24, 'Levin Rowlatt', 'lrowlattn@alexa.com', 'habOWqrLypD'),
(25, 'Mercie Bisatt', 'mbisatto@opera.com', 'nJeKhQoK2o'),
(26, 'Saunderson Geard', 'sgeardp@joomla.org', 'Oj4lFdEQq1M'),
(27, 'Hilliary Claris', 'hclarisq@nba.com', 'Y49IAN0H4SUR'),
(28, 'Noel Feldhorn', 'nfeldhornr@goo.ne.jp', 'W2C3Oi'),
(29, 'Madelin Verriour', 'mverriours@mashable.com', 'RniWGQDOEE5'),
(30, 'Hercule Saladine', 'hsaladinet@gov.uk', 'AZjFYRTmmHV'),
(31, 'Veriee Benard', 'vbenardu@paypal.com', 'ILNSp8'),
(32, 'Berthe Buzza', 'bbuzzav@rakuten.co.jp', 'fIjJxdfn'),
(33, 'Olympe Thexton', 'othextonw@photobucket.com', 'jNGkn4'),
(34, 'Sibel Seebert', 'sseebertx@elegantthemes.com', 'bcp0o3NhZpKO'),
(35, 'Ferne Burde', 'fburdey@nature.com', 'DNGpniLlE9hz'),
(36, 'Virgina Sextie', 'vsextiez@nytimes.com', 'R9ZhfRbz8oS'),
(37, 'Em Castagne', 'ecastagne10@imageshack.us', '8tiu3ZS'),
(38, 'Hillery Cobby', 'hcobby11@addthis.com', 'csvo45u'),
(39, 'Nikolas Doles', 'ndoles12@time.com', 'lGXb6YETjhGL'),
(40, 'Jessi Caldow', 'jcaldow13@accuweather.com', 'SsSHFw96'),
(41, 'Arvin Gent', 'agent14@diigo.com', 'nrf61Z'),
(42, 'Liva Starbeck', 'lstarbeck15@soup.io', 'Po3U7fmU'),
(43, 'Brannon Iskower', 'biskower16@prweb.com', 'sSaUNsYXH7S'),
(44, 'Shanie Jirus', 'sjirus17@histats.com', 'VEf06U'),
(45, 'Callean Seson', 'cseson18@sourceforge.net', '4TKwzaHy3'),
(46, 'Donella Godrich', 'dgodrich19@hugedomains.com', 'Zhc3pJ5R0qkj'),
(47, 'Boy Yedy', 'byedy1a@mlb.com', 'detmlS0E5imv'),
(48, 'Riki Frodsham', 'rfrodsham1b@php.net', 'J6w065TzkO1F'),
(49, 'Kennedy Perdue', 'kperdue1c@twitter.com', '6fM2OTf'),
(50, 'Ellis Piesing', 'epiesing1d@clickbank.net', 'rTfp1u2lGonK'),
(51, 'Beatrix Mackelworth', 'bmackelworth1e@spotify.com', '4WeMye'),
(52, 'Jodee Ram', 'jram1f@unblog.fr', 'Pqk3abyvF6Cb'),
(53, 'Shandee Gatcliff', 'sgatcliff1g@blinklist.com', 'RDGx1d'),
(54, 'Ag Stanlick', 'astanlick1h@go.com', 'I7JfnZg2WfaC'),
(55, 'Rand Albarez', 'ralbarez1i@google.pl', 'ufZfioEr'),
(56, 'Arlin Broadstock', 'abroadstock1j@list-manage.com', 'SWKXviEt'),
(57, 'Meier Ciobotaro', 'mciobotaro1k@yellowpages.com', '5xG4TqqIGcC'),
(58, 'Drugi Kleeman', 'dkleeman1l@furl.net', 'JkWOV0'),
(59, 'Elspeth Terbeek', 'eterbeek1m@google.pl', 'NpWfGJ'),
(60, 'Allan Meers', 'ameers1n@time.com', 'MLlK4tvp'),
(61, 'Kellsie Arkow', 'karkow1o@sina.com.cn', 'U7bDL43KB'),
(62, 'Cairistiona Fairfoul', 'cfairfoul1p@tripadvisor.com', '8N6BRE3'),
(63, 'Geralda Snelle', 'gsnelle1q@businesswire.com', 'vY3hjMk'),
(64, 'Lief Harmond', 'lharmond1r@e-recht24.de', 'zu4Dbb'),
(65, 'Jarvis Weyman', 'jweyman1s@tripod.com', 'y1o44CudSk1'),
(66, 'Vanni Blare', 'vblare1t@free.fr', '98xUW8AL'),
(67, 'Nicky Bosden', 'nbosden1u@skyrock.com', 'jp4rlXyRuD'),
(68, 'Antonietta Walsh', 'awalsh1v@omniture.com', 'WrszBx50W'),
(69, 'Robbie O''Scollain', 'roscollain1w@sfgate.com', 'PngOUxMKFa'),
(70, 'Aurlie Shurman', 'ashurman1x@parallels.com', 'lbcLrJVVfB2'),
(71, 'Consalve Jephcote', 'cjephcote1y@pcworld.com', 'Id8Av00d'),
(72, 'Cami Stocker', 'cstocker1z@usa.gov', '1TEn1crkqA'),
(73, 'Brockie Anwell', 'banwell20@geocities.jp', 'zn0iiAKFeKU'),
(74, 'Amil Yonnie', 'ayonnie21@odnoklassniki.ru', 'g0H2wsOC1k'),
(75, 'Rosanne McCaughey', 'rmccaughey22@fotki.com', '7WmpK6'),
(76, 'Ruy Stanluck', 'rstanluck23@ibm.com', '0trp8uFbgS'),
(77, 'Legra Mulhall', 'lmulhall24@reference.com', 'mGjUzgd'),
(78, 'Zelig Weatherell', 'zweatherell25@multiply.com', 'WxoK7wdMkm'),
(79, 'Marylinda Lehr', 'mlehr26@omniture.com', '8bFvSrHMju'),
(80, 'Selina Stockey', 'sstockey27@gnu.org', 'InudDhzfR7me'),
(81, 'Wynne Brastead', 'wbrastead28@godaddy.com', 'xEajtxrCATx'),
(82, 'Maia Cicerone', 'mcicerone29@msn.com', 'EdrqSoUPL'),
(83, 'Carin Elleray', 'celleray2a@berkeley.edu', 'CCkNgcl9'),
(84, 'Chadd Feek', 'cfeek2b@wikimedia.org', 'Ifb5I0IOxV'),
(85, 'Burty Brownsworth', 'bbrownsworth2c@shareasale.com', 'mLwaO7uH7L'),
(86, 'Brander Jonathon', 'bjonathon2d@google.com.br', 'DphskAwxx'),
(87, 'Vaughn Santon', 'vsanton2e@123-reg.co.uk', 'IWAXIgE5tYgq'),
(88, 'Dode Dowzell', 'ddowzell2f@blogspot.com', 'AHTD53aSFLCj'),
(89, 'Laina Hatton', 'lhatton2g@psu.edu', 'BuCupbGV'),
(90, 'Josi Gisby', 'jgisby2h@phpbb.com', 'iR1zBJu'),
(91, 'Kath Mayor', 'kmayor2i@engadget.com', 't5tXyoxUZ'),
(92, 'Sula Acome', 'sacome2j@ameblo.jp', 'l5Vck1NR'),
(93, 'Gwyn Sanham', 'gsanham2k@globo.com', 'XxLShZLv3Jmj'),
(94, 'Hilarius Fosdick', 'hfosdick2l@ow.ly', 'XUh4gjq8uSfk'),
(95, 'Mischa L'' Anglois', 'ml2m@opera.com', 'Wds64kMjG8g'),
(96, 'Cariotta Gantz', 'cgantz2n@biglobe.ne.jp', 'ayPdUC9tt'),
(97, 'Leland Stitson', 'lstitson2o@paypal.com', 'iS1Os5L'),
(98, 'Tabina Connelly', 'tconnelly2p@ebay.com', 'o6aX3v'),
(99, 'Kara-lynn Stonelake', 'kstonelake2q@reuters.com', 'Z1zL35fIx'),
(100, 'Cortie Tremaine', 'ctremaine2r@mtv.com', '9l2Fvxe');

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE `theme` (
  `id_theme` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `theme`
--

INSERT INTO `theme` (`id_theme`, `nom`) VALUES
(1, 'Asiatique'),
(2, 'Indien'),
(3, 'Britanique'),
(4, 'Créole'),
(5, 'Libanais'),
(6, 'Mongolia'),
(7, 'Albania'),
(8, 'Yemen'),
(9, 'Poland'),
(10, 'Cameroon'),
(11, 'Syria'),
(12, 'Luxembourg'),
(13, 'Albania'),
(14, 'Uruguay'),
(15, 'China'),
(16, 'Portugal'),
(17, 'China'),
(18, 'Argentina'),
(19, 'Armenia'),
(20, 'Philippines'),
(21, 'United States'),
(22, 'Brazil'),
(23, 'Portugal'),
(24, 'China'),
(25, 'Indonesia'),
(26, 'Croatia'),
(27, 'France'),
(28, 'Peru'),
(29, 'Japan'),
(30, 'Netherlands'),
(31, 'China'),
(32, 'United States'),
(33, 'Philippines'),
(34, 'Iran'),
(35, 'South Africa'),
(36, 'China'),
(37, 'China'),
(38, 'China'),
(39, 'Burkina Faso'),
(40, 'China'),
(41, 'Philippines'),
(42, 'China'),
(43, 'Poland'),
(44, 'Ukraine'),
(45, 'Tunisia'),
(46, 'Ukraine'),
(47, 'China'),
(48, 'Russia'),
(49, 'Thailand'),
(50, 'Sweden'),
(51, 'Brazil'),
(52, 'Colombia'),
(53, 'Russia'),
(54, 'Croatia'),
(55, 'Mali'),
(56, 'Indonesia'),
(57, 'Portugal'),
(58, 'Indonesia'),
(59, 'Tunisia'),
(60, 'Zambia'),
(61, 'China'),
(62, 'Portugal'),
(63, 'Egypt'),
(64, 'China'),
(65, 'Indonesia'),
(66, 'Egypt'),
(67, 'Canada'),
(68, 'Portugal'),
(69, 'France'),
(70, 'Micronesia'),
(71, 'United States'),
(72, 'France'),
(73, 'Brazil'),
(74, 'China'),
(75, 'Russia'),
(76, 'Tonga'),
(77, 'Canada'),
(78, 'Indonesia'),
(79, 'Nigeria'),
(80, 'Sweden'),
(81, 'Vietnam'),
(82, 'Philippines'),
(83, 'Belarus'),
(84, 'United States'),
(85, 'Bosnia and Herzegovina'),
(86, 'Thailand'),
(87, 'Indonesia'),
(88, 'United Arab Emirates'),
(89, 'Mongolia'),
(90, 'China'),
(91, 'Nigeria'),
(92, 'Indonesia'),
(93, 'Japan'),
(94, 'Indonesia'),
(95, 'China'),
(96, 'Greece'),
(97, 'Kazakhstan'),
(98, 'Mexico'),
(99, 'Sri Lanka'),
(100, 'China');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `boutique`
--
ALTER TABLE `boutique`
  ADD PRIMARY KEY (`id_boutique`),
  ADD KEY `id_proprietaire` (`id_proprietaire`),
  ADD KEY `id_proprietaire_2` (`id_proprietaire`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id_categorie`);

--
-- Index pour la table `categorisation`
--
ALTER TABLE `categorisation`
  ADD PRIMARY KEY (`id_categorisation`),
  ADD KEY `id_categorie` (`id_categorie`),
  ADD KEY `id_produit` (`id_produit`);

--
-- Index pour la table `localisation`
--
ALTER TABLE `localisation`
  ADD PRIMARY KEY (`id_localisation`),
  ADD KEY `id_produit` (`id_produit`),
  ADD KEY `id_boutique` (`id_boutique`);

--
-- Index pour la table `marque`
--
ALTER TABLE `marque`
  ADD PRIMARY KEY (`id_marque`);

--
-- Index pour la table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`id_photo`),
  ADD KEY `id_produit` (`id_produit`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id_produit`),
  ADD KEY `id_theme` (`id_theme`),
  ADD KEY `id_marque` (`id_marque`);

--
-- Index pour la table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD PRIMARY KEY (`id_proprietaire`);

--
-- Index pour la table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`id_theme`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `boutique`
--
ALTER TABLE `boutique`
  MODIFY `id_boutique` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id_categorie` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `categorisation`
--
ALTER TABLE `categorisation`
  MODIFY `id_categorisation` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT pour la table `localisation`
--
ALTER TABLE `localisation`
  MODIFY `id_localisation` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=110;
--
-- AUTO_INCREMENT pour la table `marque`
--
ALTER TABLE `marque`
  MODIFY `id_marque` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `photo`
--
ALTER TABLE `photo`
  MODIFY `id_photo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id_produit` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT pour la table `proprietaire`
--
ALTER TABLE `proprietaire`
  MODIFY `id_proprietaire` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT pour la table `theme`
--
ALTER TABLE `theme`
  MODIFY `id_theme` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=101;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `boutique`
--
ALTER TABLE `boutique`
  ADD CONSTRAINT `boutique_ibfk_1` FOREIGN KEY (`id_proprietaire`) REFERENCES `proprietaire` (`id_proprietaire`);

--
-- Contraintes pour la table `categorisation`
--
ALTER TABLE `categorisation`
  ADD CONSTRAINT `categorisation_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`),
  ADD CONSTRAINT `categorisation_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`);

--
-- Contraintes pour la table `localisation`
--
ALTER TABLE `localisation`
  ADD CONSTRAINT `localisation_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`),
  ADD CONSTRAINT `localisation_ibfk_2` FOREIGN KEY (`id_boutique`) REFERENCES `boutique` (`id_boutique`);

--
-- Contraintes pour la table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `produit_ibfk_1` FOREIGN KEY (`id_theme`) REFERENCES `theme` (`id_theme`),
  ADD CONSTRAINT `produit_ibfk_2` FOREIGN KEY (`id_marque`) REFERENCES `marque` (`id_marque`);
