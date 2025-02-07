-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: animes
-- ------------------------------------------------------
-- Server version       8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comentario` varchar(510) NOT NULL,
  `feed` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `conta` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feed_idx` (`feed`),
  CONSTRAINT `fk_comentarios_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,
'teste',
1,
'Brendo Gomes',
'brendogomes@gmail.com',
'2024-12-28 21:12:05');
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `avatar` varchar(455) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `estudio` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `estudio` VALUES (1,"Ufotable","https://res.cloudinary.com/teepublic/image/private/s--zAjzgUlc--/c_crop,x_10,y_10/c_fit,w_830/c_crop,g_north_west,h_1038,w_1038,x_-104,y_-448/l_upload:v1565806151:production:blanks:vdbwo35fw6qtflw9kezw/fl_layer_apply,g_north_west,x_-215,y_-559/b_rgb:000000/c_limit,f_jpg,h_630,q_90,w_630/v1692830825/production/designs/49649782_0.jpg"),
            (2,"MAPPA","https://ih1.redbubble.net/image.2316168809.1704/ur,pin_large_front,square,1000x1000.u2.jpg"),
            (3,"Studio Bones","https://pbs.twimg.com/media/FTh-4UyXsAIpV_8.jpg"),
            (4,"Kyoto Animation","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzdnE7e_KxTI9nR62ZUH0oSfI_t2I_bJ5UYQ&s"),
            (5,"Toei Animation","https://www.nicepng.com/png/detail/315-3153350_toei-animation-toei-animation-logo-png.png"),
            (6,"Studio Pierrot","https://i.pinimg.com/originals/33/15/38/331538b84919881127b9f606f23e471c.png"),
            (7,"Madhouse","https://iconape.com/wp-content/png_logo_vector/madhouse-studio-logo.png"),
            (8,"White Fox","https://hyphen.cc/works/1010_whitefox_logo.gif"),
            (9,"Sunrise","https://img.freepik.com/vetores-premium/resumo-sun-logo-vintage-sun-icon-com-raios-isolados-no-fundo-branco-utilizavel-para-logotipos-de-negocios-e-natureza-elemento-de-modelo-de-design-de-logotipo-de-vetor-plana_393879-336.jpg"),
            (10,"Production I.G","https://ih1.redbubble.net/image.5213991815.5502/ur,pin_small_front,wide_portrait,750x1000.jpg"),
            (11,"Studio Ghibli","https://e7.pngegg.com/pngimages/426/435/png-clipart-ghibli-museum-catbus-studio-ghibli-my-neighbor-totoro-chihiro-ghibli-museum-catbus-thumbnail.png"),
            (12,"Silver Link","https://static.wixstatic.com/media/d3fb2b_8d32b0e6d0714e6fb1b32eb4749814ca~mv2.png/v1/fill/w_560,h_388,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/Silver%20Link%20Logo.png"),
            (13,"A-1 Pictures","https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/A-1_Pictures_Logo.svg/512px-A-1_Pictures_Logo.svg.png"),
            (14,"Xebec","https://logovectorseek.com/wp-content/uploads/2020/08/xebec-adsorption-inc-logo-vector.png"),
            (15,"Studio Deen","https://iconape.com/wp-content/png_logo_vector/studio-deen-logo.png"),
            (16,"P.A. Works","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1S4MWN9v3c0nT4kphdNpvFAsGnpTWPbFoPw&s");
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feeds`
--

DROP TABLE IF EXISTS `feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `anime` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feeds_animes_idx` (`anime`),
  CONSTRAINT `fk_feeds_animes` FOREIGN KEY (`anime`) REFERENCES `animes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feeds`
--

LOCK TABLES `feeds` WRITE;
/*!40000 ALTER TABLE `feeds` DISABLE KEYS */;
INSERT INTO `feeds` VALUES (1,'2024-12-22 21:21:11',1),
(2,'2024-12-22 21:21:11',2),
(3,'2024-04-22 21:21:11',3),
(4,'2024-04-22 21:21:11',4),
(5,'2024-04-22 21:21:11',5),
(6,'2024-04-22 21:21:11',6),
(7,'2024-04-22 21:21:11',7);
/*!40000 ALTER TABLE `feeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed` int NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_feeds_idx` (`feed`),
  CONSTRAINT `fk_likes_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (8,1,'brendogomes@gmail.com');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `animes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `sinopse` varchar(610) NOT NULL,
  `nota` decimal(3,1) NOT NULL,
  `url` varchar(1020) NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `estudio` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animes_estudio_idx` (`estudio`),
  CONSTRAINT `fk_animes_estudio` FOREIGN KEY (`estudio`) REFERENCES `estudio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `animes` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `animes` VALUES
(1,'Demon Slayer: Kimetsu no Yaiba', 'Tanjiro Kamado embarca em uma jornada para salvar sua irmã Nezuko e derrotar os demônios.', 9.8, 'https://www.crunchyroll.com/demon-slayer-kimetsu-no-yaiba', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg5f56fe0b6b40c3.75541837.jpg%3FlastEdited%3D1599536658%3Fo%3Dfeed&w=250&h=300&f=webp',1),
(2,'Jujutsu Kaisen', 'Yuji Itadori se junta a uma escola de feiticeiros para combater maldições perigosas.', 9.5, 'https://www.crunchyroll.com/jujutsu-kaisen', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fdev-beta.quizur.com%2Fstorage%2Fv1%2Fobject%2Fpublic%2Fimagens%2F%2F20085070%2F527d4851-96ef-4d21-9bd9-3a0ae4898e3d.png%3Fo%3Dfeed&w=250&h=300&f=webp',2),
(3,'My Hero Academia', 'Izuku Midoriya, um jovem sem poderes, luta para se tornar o maior herói do mundo.', 9.2, 'https://www.crunchyroll.com/my-hero-academia', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg632df9d169d248.83347137.png%3FlastEdited%3D1663957473%3Fo%3Dfeed&w=250&h=300&f=webp',3),
(4,'Violet Evergarden', 'Violet, uma jovem ex-soldado, descobre o significado de emoções humanas.', 9.3, 'https://www.netflix.com/title/80182123', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg5cefe734028534.58965719.jpg%3FlastEdited%3D1559226197%3Fo%3Dfeed&w=250&h=300&f=webp',4),
(5,'One Piece', 'Luffy e sua tripulação buscam o tesouro lendário para se tornarem os maiores piratas.', 9.7, 'https://www.crunchyroll.com/one-piece', 'https://sm.ign.com/t/ign_br/tv/o/one-piece-/one-piece-2_1xby.300.jpg',5),
(6,'Naruto', 'Naruto Uzumaki sonha em se tornar Hokage e proteger sua vila.', 9.0, 'https://www.crunchyroll.com/naruto', 'https://www.presentespara.com.br/wp-content/uploads/2024/02/naruto-300x200.webp',6),
(7,'Hunter x Hunter', 'Gon Freecss explora o mundo como um caçador em busca de seu pai desaparecido.', 9.6, 'https://www.crunchyroll.com/hunter-x-hunter', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg630907f35d8429.91690414.jpg%3FlastEdited%3D1661536257%3Fo%3Dfeed&w=250&h=300&f=webp',7),
(8,'Re:Zero', 'Subaru Natsuki é transportado para um mundo paralelo e descobre um ciclo de mortes e renascimentos.', 9.1, 'https://www.crunchyroll.com/re-zero', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg600b43e8653c92.22869302.jpg%3FlastEdited%3D1611351039%3Fo%3Dfeed&w=250&h=300&f=webp',8),
(9,'Cowboy Bebop', 'Caçadores de recompensa viajam pelo espaço enfrentando perigos e desafios emocionais.', 9.4, 'https://www.crunchyroll.com/cowboy-bebop', 'https://animegoo.wordpress.com/wp-content/uploads/2010/06/a7a52-1201765524-cowboy_bebop_49.jpg?w=300',9),
(10,'Haikyuu!!', 'Shoyo Hinata se esforça para se tornar um dos melhores jogadores de vôlei do Japão.', 9.0, 'https://www.crunchyroll.com/haikyuu', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg60b2dc42ded784.39796013.jpg%3FlastEdited%3D1622334536%3Fo%3Dfeed&w=250&h=300&f=webp',10),
(11,'Spirited Away', 'Chihiro entra em um mundo espiritual e luta para resgatar seus pais transformados em porcos.', 9.0, 'https://www.crunchyroll.com/spirited-away', 'https://images5.fanpop.com/image/photos/30900000/No-Face-no-face-of-spirited-away-30995284-300-200.jpg',11),
(12,'Ghost in the Shell', 'Motoko Kusanagi, uma ciborgue com uma consciência humana, investiga crimes cibernéticos.', 6.5, 'https://www.crunchyroll.com/ghost-in-the-shell', 'https://www.einerd.com.br/wp-content/uploads/2017/04/Ghost-277x190.jpg',10),
(13,'Fullmetal Alchemist: Brotherhood', 'Dois irmãos tentam recuperar seus corpos após um experimento alquímico falho.', 9.9, 'https://www.crunchyroll.com/fullmetal-alchemist-brotherhood', 'https://specialdaysmax.wordpress.com/wp-content/uploads/2011/03/20930-fullmetal-alchemist-brotherhood1.jpg?w=300',3),
(14,'Re:Zero II temporada', 'Subaru Natsuki é transportado para um mundo paralelo e reviverá sua morte até mudar o futuro.', 8.8, 'https://www.crunchyroll.com/re-zero', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg600b43e8653c92.22869302.jpg%3FlastEdited%3D1611351039%3Fo%3Dfeed&w=250&h=300&f=webp',12),
(15,'The Promised Neverland', 'Um grupo de crianças descobre os segredos sombrios por trás do orfanato em que vivem.', 8.5, 'https://www.crunchyroll.com/the-promised-neverland', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg6071b8a4016e43.07710244.jpg%3FlastEdited%3D1618065576%3Fo%3Dfeed&w=250&h=300&f=webp',13),
(16,'Yuri on Ice', 'Um patinador japonês busca redenção e vitórias com a ajuda de seu treinador, Yuri Katsuki.', 7.3, 'https://www.crunchyroll.com/yuri-on-ice', 'https://rukminim1.flixcart.com/image/300/300/xif0q/poster/s/l/k/medium-pwfkt12250-anime-yuri-on-ice-viktor-nikiforov-yuri-matte-original-imagg6hyzndggtgz.jpeg',14),
(17,'Love Hina', 'Keitaro Urashima tenta entrar na universidade de Tóquio e gerenciar um dormitório cheio de garotas.', 8.2, 'https://www.crunchyroll.com/love-hina', 'https://static.wikia.nocookie.net/lovehina/images/b/b7/HinataResidents1.jpg/revision/latest/scale-to-width-down/300?cb=20110429134501',15),
(18,'Fruits Basket', 'Toru Honda descobre os segredos da família Soma, cujos membros se transformam em animais do zodíaco chinês.', 6.4, 'https://www.crunchyroll.com/fruits-basket', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg643dc5878081c1.82918645.jpg%3FlastEdited%3D1681769867%3Fo%3Dfeed&w=250&h=300&f=webp',3),
(19,'Angel Beats!', 'Após morrer, um grupo de jovens tenta encontrar a paz enquanto enfrentam desafios em uma escola sobrenatural.', 8.9, 'https://www.crunchyroll.com/angel-beats', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fstatic.quizur.com%2Fi%2Fb%2F574b5467a78b09.3975851913322191-138516956561315-2742448555925565955-n.jpg%3Fo%3Dfeed&w=250&h=300&f=webp',8),
(20,'Noragami', 'Yato, um deus menor, busca fama e seguidores enquanto ajuda a resolver os problemas dos humanos.', 9.7, 'https://www.crunchyroll.com/noragami', 'https://pt.quizur.com/_image?href=https%3A%2F%2Fstatic.quizur.com%2Fi%2Fb%2F58e9b3ba6e20d7.6316032958e9b3ba5bc9b0.10101485.jpg%3Fo%3Dfeed&w=250&h=300&f=webp',16);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-16 21:48:40
