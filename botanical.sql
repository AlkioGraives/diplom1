-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: botanical_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,'taxonomy','INSERT',3,'Betulaceae / Betula / pendula','2025-05-26 23:42:33'),(2,'plants','INSERT',3,'Берёза повислая / Betula pendula / Лиственное дерево, распространённое в Европе и Азии.','2025-05-26 23:42:33'),(3,'taxonomy','INSERT',4,'Pinaceae / Pinus / sylvestris','2025-05-26 23:42:33'),(4,'plants','INSERT',4,'Сосна обыкновенная / Pinus sylvestris / Хвойное дерево, характерное для хвойных лесов Европы и Азии.','2025-05-26 23:42:33'),(5,'taxonomy','INSERT',5,'Asteraceae / Taraxacum / officinale','2025-05-26 23:42:33'),(6,'plants','INSERT',5,'Одуванчик лекарственный / Taraxacum officinale / Многолетнее растение с жёлтыми цветками и глубоким корнем.','2025-05-26 23:42:33'),(7,'plants','DELETE',3,'Берёза повислая / Betula pendula','2025-05-28 16:17:21'),(8,'taxonomy','INSERT',6,'Malvaceae / Tilia / cordata','2025-05-28 16:23:53'),(9,'plants','INSERT',6,'Липа сердцевидная / Tilia cordata / Дерево с сердцевидными листьями и душистыми цветами.','2025-05-28 16:23:53'),(10,'plants','UPDATE',5,'Новое описание: Дерево с сердцевидными листьями и душистыми цветами.','2025-05-28 16:24:24'),(11,'taxonomy','INSERT',7,'Pinaceae / Pinus / sibirica','2025-05-28 17:16:53'),(12,'plants','INSERT',7,'Сосна кедровая сибирская / Pinus sibirica / Массивное хвойное дерево, дающее съедобные орехи, произрастает в тайге Сибири.','2025-05-28 17:16:53');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plants`
--

DROP TABLE IF EXISTS `plants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_ru` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_lat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `taxonomy_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taxonomy_id` (`taxonomy_id`),
  CONSTRAINT `plants_ibfk_1` FOREIGN KEY (`taxonomy_id`) REFERENCES `taxonomy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plants`
--

LOCK TABLES `plants` WRITE;
/*!40000 ALTER TABLE `plants` DISABLE KEYS */;
INSERT INTO `plants` VALUES (1,'Берёза пушистая','Betula pubescens','Листопадное дерево с белой корой и мягкими листьями, предпочитает влажные почвы и холодный климат.',8),(2,'Сосна кедровая сибирская','Pinus sibirica','Массивное хвойное дерево, дающее съедобные орехи, произрастает в тайге Сибири.',9),(3,'Ель сибирская','Picea obovata','Вечнозелёное дерево с короткими шишками, устойчивое к низким температурам.',10),(4,'Тополь дрожащий','Populus tremuloides','Листопадное дерево с трепещущими листьями, быстро растёт и образует рощи.',11),(5,'Клён гиннала','Acer ginnala','Небольшое декоративное дерево с ярко-красной осенней листвой.',12),(6,'Ольха серая','Alnus incana','Дерево с сероватой корой, укрепляет почву благодаря азотфиксирующим бактериям.',13),(7,'Ива белая','Salix alba','Дерево с узкими серебристыми листьями, используется в ландшафтном дизайне.',14),(8,'Черёмуха виргинская','Prunus virginiana','Кустарник с тёмными ягодами, применяется в кулинарии и народной медицине.',15),(9,'Сирень венгерская','Syringa josikaea','Декоративный кустарник с ароматными фиолетовыми цветами.',16),(10,'Рябина промежуточная','Sorbus intermedia','Дерево с оранжевыми ягодами, хорошо переносит городские условия.',17),(11,'Шиповник иглистый','Rosa acicularis','Куст с розовыми цветами и мелкими плодами, богатыми витамином C.',18),(12,'Калина гордовина','Viburnum lantana','Кустарник с плотными соцветиями и бархатистыми листьями.',19),(13,'Боярышник однопестичный','Crataegus monogyna','Компактное дерево с белыми цветами и красными ягодами, ценится за лечебные свойства.',20),(14,'Лещина обыкновенная','Corylus avellana','Кустарник с вкусными орехами, часто используется в агролесоводстве.',21),(15,'Гортензия метельчатая','Hydrangea paniculata','Кустарник с крупными белыми соцветиями, которые розовеют к осени.',22),(16,'Жимолость каприфоль','Lonicera caprifolium','Вьющийся кустарник с душистыми цветами, используется как декоративное растение.',23),(17,'Можжевельник казацкий','Juniperus sabina','Стелющийся кустарник с игольчатыми листьями, устойчив к засухе.',24),(18,'Пихта сибирская','Abies sibirica','Хвойное дерево с мягкой хвоей и приятным ароматом, используется в медицине.',25),(19,'Тис ягодный','Taxus baccata','Вечнозелёный кустарник с красными ягодами, ядовит во всех частях, кроме мякоти плодов.',26),(20,'Гинкго двулопастный','Ginkgo biloba','Реликтовое дерево с веерообразными листьями, применяется в медицине.',27),(21,'Лаванда узколистная','Lavandula angustifolia','Многолетний кустарник с ароматными сиреневыми цветами, применяется в ароматерапии.',28),(22,'Мальва мускусная','Malva moschata','Травянистое растение с розовыми цветами, популярное в декоративном озеленении.',29),(23,'Подсолнух однолетний','Helianthus annuus','Крупное растение с жёлтым соцветием и съедобными семенами.',30),(24,'Тысячелистник обыкновенный','Achillea millefolium','Многолетнее растение с мелкими белыми цветами, применяется в народной медицине.',31),(25,'Лютик едкий','Ranunculus acris','Ядовитое растение с ярко-жёлтыми цветками, распространено на лугах.',32),(26,'Мак снотворный','Papaver somniferum','Однолетнее растение с крупными цветами, используется в фармацевтике.',33),(27,'Лён обыкновенный','Linum usitatissimum','Сельскохозяйственная культура, из волокон которой делают ткани, а семена используют в питании.',34),(28,'Мята перечная','Mentha × piperita','Ароматное травянистое растение, применяемое в чае, кулинарии и медицине.',35),(29,'Ромашка аптечная','Matricaria chamomilla','Травянистое растение с белыми лепестками и жёлтым центром, используется в фитотерапии.',36),(30,'Крапива двудомная','Urtica dioica','Жгучее растение с целебными свойствами, богато витаминами и минералами.',37),(31,'Зверобой продырявленный','Hypericum perforatum','Желтоцветковое растение с антисептическими и антидепрессивными свойствами.',38),(32,'Фиалка трёхцветная','Viola tricolor','Небольшое растение с яркими фиолетово-жёлтыми цветами, популярно в медицине и садоводстве.',39),(33,'Ландыш майский','Convallaria majalis','Ядовитое растение с ароматными белыми колокольчатыми цветками.',40),(34,'Хмель обыкновенный','Humulus lupulus','Вьющаяся лиана, используемая при производстве пива и в народной медицине.',41),(35,'Арника горная','Arnica montana','Цветущее растение с оранжево-жёлтыми соцветиями, обладает противовоспалительными свойствами.',42),(36,'Череда трёхраздельная','Bidens tripartita','Влаголюбивое растение с лечебными свойствами, особенно ценится в детской дерматологии.',43),(37,'Репешок обыкновенный','Agrimonia eupatoria','Травянистое растение с жёлтыми цветками, применяемое при желудочных расстройствах.',44),(38,'Мать-и-мачеха обыкновенная','Tussilago farfara','Весеннее растение с жёлтыми соцветиями, одно из первых, появляющихся после таяния снега.',45),(39,'Пастушья сумка','Capsella bursa-pastoris','Растение с характерными треугольными семенными коробочками, часто встречается в садах.',46),(40,'Щавель конский','Rumex confertus','Крупное растение с высокими цветоносами, используется как кормовое и лекарственное.',47),(41,'Алоэ древовидное','Aloe arborescens','Суккулентное растение с мясистыми листьями, обладает ранозаживляющими свойствами.',48),(42,'Берёза повислая','Betula pendula','Лиственное дерево с белой корой, листья используются в мочегонных сборах.',49),(43,'Барбарис обыкновенный','Berberis vulgaris','Колючий кустарник с кислой ягодой, используемой в кулинарии и медицине.',50),(44,'Герань луговая','Geranium pratense','Цветущее травянистое растение с фиолетовыми цветками, обладает противовоспалительными свойствами.',51),(45,'Ель обыкновенная','Picea abies','Хвойное дерево, смола и хвоя которого применяются в медицине.',52),(46,'Сосна обыкновенная','Pinus sylvestris','Распространённое хвойное дерево, эфирные масла которого ценятся за антисептические свойства.',53),(47,'Одуванчик лекарственный','Taraxacum officinale','Травянистое растение с жёлтыми цветками и молочным соком, применяется как желчегонное средство.',54),(48,'Таволга вязолистная','Filipendula ulmaria','Влаголюбивое растение с медовыми цветками, обладает жаропонижающим действием.',55),(49,'Астра альпийская','Aster alpinus','Невысокое многолетнее растение с сиреневыми цветками, выращивается как декоративное.',56),(50,'Дельфиниум высокий','Delphinium elatum','Крупное садовое растение с яркими синими цветами, ядовито.',57),(51,'Календула лекарственная','Calendula officinalis','Популярное лекарственное растение с ярко-оранжевыми соцветиями.',58),(52,'Мелисса лекарственная','Melissa officinalis','Ароматное растение с лимонным запахом, используется как успокоительное средство.',59),(53,'Чабрец обыкновенный','Thymus vulgaris','Пряное и лекарственное растение с сильным антисептическим эффектом.',60),(54,'Брусника обыкновенная','Vaccinium vitis-idaea','Низкорослый кустарник с кисло-сладкими ягодами, используется в пищу и медицине.',61),(55,'Черника обыкновенная','Vaccinium myrtillus','Лесное растение с тёмно-синими ягодами, укрепляющее зрение.',62),(56,'Калина обыкновенная','Viburnum opulus','Кустарник с красными ягодами, обладающими жаропонижающим действием.',63),(57,'Рябина обыкновенная','Sorbus aucuparia','Дерево с оранжево-красными плодами, богатое витаминами.',64),(58,'Лопух большой','Arctium lappa','Крупное растение с липкими соцветиями, корень используется как лекарственное средство.',65),(59,'Пижма обыкновенная','Tanacetum vulgare','Ядовитое растение с пряным запахом, используется против паразитов.',66),(60,'Валериана лекарственная','Valeriana officinalis','Корневища этого растения содержат успокоительные соединения, применяемые в фармацевтике.',67);
/*!40000 ALTER TABLE `plants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy`
--

DROP TABLE IF EXISTS `taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxonomy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `family` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genus` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `species` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy`
--

LOCK TABLES `taxonomy` WRITE;
/*!40000 ALTER TABLE `taxonomy` DISABLE KEYS */;
INSERT INTO `taxonomy` VALUES (1,'Betulaceae','Betula','Pendula'),(2,'Хвощовые','Хвощ','Хвощ полевой'),(3,'Betulaceae','Betula','pendula'),(4,'Pinaceae','Pinus','sylvestris'),(5,'Asteraceae','Taraxacum','officinale'),(6,'Malvaceae','Tilia','cordata'),(7,'Pinaceae','Pinus','sibirica'),(8,'Betula','pubescens','Betulaceae'),(9,'Pinus','sibirica','Pinaceae'),(10,'Picea','obovata','Pinaceae'),(11,'Populus','tremuloides','Salicaceae'),(12,'Acer','ginnala','Sapindaceae'),(13,'Alnus','incana','Betulaceae'),(14,'Salix','alba','Salicaceae'),(15,'Prunus','virginiana','Rosaceae'),(16,'Syringa','josikaea','Oleaceae'),(17,'Sorbus','intermedia','Rosaceae'),(18,'Rosa','acicularis','Rosaceae'),(19,'Viburnum','lantana','Adoxaceae'),(20,'Crataegus','monogyna','Rosaceae'),(21,'Corylus','avellana','Betulaceae'),(22,'Hydrangea','paniculata','Hydrangeaceae'),(23,'Lonicera','caprifolium','Caprifoliaceae'),(24,'Juniperus','sabina','Cupressaceae'),(25,'Abies','sibirica','Pinaceae'),(26,'Taxus','baccata','Taxaceae'),(27,'Ginkgo','biloba','Ginkgoaceae'),(28,'Lavandula','angustifolia','Lamiaceae'),(29,'Malva','moschata','Malvaceae'),(30,'Helianthus','annuus','Asteraceae'),(31,'Achillea','millefolium','Asteraceae'),(32,'Ranunculus','acris','Ranunculaceae'),(33,'Papaver','somniferum','Papaveraceae'),(34,'Linum','usitatissimum','Linaceae'),(35,'Mentha','× piperita','Lamiaceae'),(36,'Matricaria','chamomilla','Asteraceae'),(37,'Urtica','dioica','Urticaceae'),(38,'Hypericum','perforatum','Hypericaceae'),(39,'Viola','tricolor','Violaceae'),(40,'Convallaria','majalis','Asparagaceae'),(41,'Humulus','lupulus','Cannabaceae'),(42,'Arnica','montana','Asteraceae'),(43,'Bidens','tripartita','Asteraceae'),(44,'Agrimonia','eupatoria','Rosaceae'),(45,'Tussilago','farfara','Asteraceae'),(46,'Capsella','bursa-pastoris','Brassicaceae'),(47,'Rumex','confertus','Polygonaceae'),(48,'Aloe','arborescens','Asphodelaceae'),(49,'Betula','pendula','Betulaceae'),(50,'Berberis','vulgaris','Berberidaceae'),(51,'Geranium','pratense','Geraniaceae'),(52,'Picea','abies','Pinaceae'),(53,'Pinus','sylvestris','Pinaceae'),(54,'Taraxacum','officinale','Asteraceae'),(55,'Filipendula','ulmaria','Rosaceae'),(56,'Aster','alpinus','Asteraceae'),(57,'Delphinium','elatum','Ranunculaceae'),(58,'Calendula','officinalis','Asteraceae'),(59,'Melissa','officinalis','Lamiaceae'),(60,'Thymus','vulgaris','Lamiaceae'),(61,'Vaccinium','vitis-idaea','Ericaceae'),(62,'Vaccinium','myrtillus','Ericaceae'),(63,'Viburnum','opulus','Adoxaceae'),(64,'Sorbus','aucuparia','Rosaceae'),(65,'Arctium','lappa','Asteraceae'),(66,'Tanacetum','vulgare','Asteraceae'),(67,'Valeriana','officinalis','Caprifoliaceae');
/*!40000 ALTER TABLE `taxonomy` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 18:20:30
