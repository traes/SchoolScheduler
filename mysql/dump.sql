-- MySQL dump 10.9
--
-- Host: localhost    Database: prp
-- ------------------------------------------------------
-- Server version	4.1.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `DataConstraintsClassroomsUnavailable`
--

DROP TABLE IF EXISTS `DataConstraintsClassroomsUnavailable`;
CREATE TABLE `DataConstraintsClassroomsUnavailable` (
  `Id` int(3) NOT NULL auto_increment,
  `ClassroomId` int(3) default NULL,
  `TimeslotId` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataConstraintsClassroomsUnavailable`
--


/*!40000 ALTER TABLE `DataConstraintsClassroomsUnavailable` DISABLE KEYS */;
LOCK TABLES `DataConstraintsClassroomsUnavailable` WRITE;
INSERT INTO `DataConstraintsClassroomsUnavailable` VALUES (2,1,2),(4,5,19);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataConstraintsClassroomsUnavailable` ENABLE KEYS */;

--
-- Table structure for table `DataConstraintsPenalties`
--

DROP TABLE IF EXISTS `DataConstraintsPenalties`;
CREATE TABLE `DataConstraintsPenalties` (
  `Id` int(3) NOT NULL auto_increment,
  `Constraint` varchar(64) default NULL,
  `Penalty` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataConstraintsPenalties`
--


/*!40000 ALTER TABLE `DataConstraintsPenalties` DISABLE KEYS */;
LOCK TABLES `DataConstraintsPenalties` WRITE;
INSERT INTO `DataConstraintsPenalties` VALUES (3,'capacity',-1),(4,'restricted-courses',-1000);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataConstraintsPenalties` ENABLE KEYS */;

--
-- Table structure for table `DataConstraintsRequiredClassrooms`
--

DROP TABLE IF EXISTS `DataConstraintsRequiredClassrooms`;
CREATE TABLE `DataConstraintsRequiredClassrooms` (
  `Id` int(3) NOT NULL auto_increment,
  `CourseId` int(3) default NULL,
  `ClassroomId` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataConstraintsRequiredClassrooms`
--


/*!40000 ALTER TABLE `DataConstraintsRequiredClassrooms` DISABLE KEYS */;
LOCK TABLES `DataConstraintsRequiredClassrooms` WRITE;
INSERT INTO `DataConstraintsRequiredClassrooms` VALUES (2,12,1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataConstraintsRequiredClassrooms` ENABLE KEYS */;

--
-- Table structure for table `DataConstraintsRestrictedCourses`
--

DROP TABLE IF EXISTS `DataConstraintsRestrictedCourses`;
CREATE TABLE `DataConstraintsRestrictedCourses` (
  `Id` int(3) NOT NULL auto_increment,
  `ClassroomId` int(3) default NULL,
  `CourseId` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataConstraintsRestrictedCourses`
--


/*!40000 ALTER TABLE `DataConstraintsRestrictedCourses` DISABLE KEYS */;
LOCK TABLES `DataConstraintsRestrictedCourses` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataConstraintsRestrictedCourses` ENABLE KEYS */;

--
-- Table structure for table `DataConstraintsRestrictedTimeslots`
--

DROP TABLE IF EXISTS `DataConstraintsRestrictedTimeslots`;
CREATE TABLE `DataConstraintsRestrictedTimeslots` (
  `Id` int(3) NOT NULL auto_increment,
  `DirectionId` int(3) default NULL,
  `TimeslotId` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataConstraintsRestrictedTimeslots`
--


/*!40000 ALTER TABLE `DataConstraintsRestrictedTimeslots` DISABLE KEYS */;
LOCK TABLES `DataConstraintsRestrictedTimeslots` WRITE;
INSERT INTO `DataConstraintsRestrictedTimeslots` VALUES (5,5,2);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataConstraintsRestrictedTimeslots` ENABLE KEYS */;

--
-- Table structure for table `DataConstraintsTeacherTimeslots`
--

DROP TABLE IF EXISTS `DataConstraintsTeacherTimeslots`;
CREATE TABLE `DataConstraintsTeacherTimeslots` (
  `Id` int(3) NOT NULL auto_increment,
  `TeacherId` int(3) default NULL,
  `TimeslotId` int(3) default NULL,
  `Score` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataConstraintsTeacherTimeslots`
--


/*!40000 ALTER TABLE `DataConstraintsTeacherTimeslots` DISABLE KEYS */;
LOCK TABLES `DataConstraintsTeacherTimeslots` WRITE;
INSERT INTO `DataConstraintsTeacherTimeslots` VALUES (1,1,2,1),(2,0,2,1),(3,0,2,1),(4,0,2,1),(5,0,2,1),(6,0,2,1),(7,0,2,1),(8,0,2,1),(11,9,2,1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataConstraintsTeacherTimeslots` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolClassrooms`
--

DROP TABLE IF EXISTS `DataSchoolClassrooms`;
CREATE TABLE `DataSchoolClassrooms` (
  `Id` int(3) NOT NULL auto_increment,
  `Name` varchar(64) default NULL,
  `Capacity` int(3) default NULL,
  `Location` varchar(64) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolClassrooms`
--


/*!40000 ALTER TABLE `DataSchoolClassrooms` DISABLE KEYS */;
LOCK TABLES `DataSchoolClassrooms` WRITE;
INSERT INTO `DataSchoolClassrooms` VALUES (1,'5905',40,'gebouw 5 verdieping 9'),(2,'5005',40,'gebouw 5 gelijkvloers'),(3,'5006',40,'gebouw 5 gelijkvloers'),(4,'5006',40,'gebouw 5 gelijkvloers'),(5,'5907',35,'gebouw 5 verdiep 9'),(6,'5908',35,'gebouw 5 verdiep 9');
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolClassrooms` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolCoursemeetings`
--

DROP TABLE IF EXISTS `DataSchoolCoursemeetings`;
CREATE TABLE `DataSchoolCoursemeetings` (
  `Id` int(3) NOT NULL auto_increment,
  `CourseId` int(3) default NULL,
  `TeacherId` int(3) default NULL,
  `DirectionId` int(3) default NULL,
  `ElectivegroupId` int(3) default NULL,
  `Compulsory` int(1) default NULL,
  `Persons` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolCoursemeetings`
--


/*!40000 ALTER TABLE `DataSchoolCoursemeetings` DISABLE KEYS */;
LOCK TABLES `DataSchoolCoursemeetings` WRITE;
INSERT INTO `DataSchoolCoursemeetings` VALUES (18,5,3,5,3,0,20),(23,12,3,5,3,0,1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolCoursemeetings` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolCourses`
--

DROP TABLE IF EXISTS `DataSchoolCourses`;
CREATE TABLE `DataSchoolCourses` (
  `Id` int(3) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolCourses`
--


/*!40000 ALTER TABLE `DataSchoolCourses` DISABLE KEYS */;
LOCK TABLES `DataSchoolCourses` WRITE;
INSERT INTO `DataSchoolCourses` VALUES (12,'Aardrijkskunde'),(6,'Burotica'),(7,'Informatica'),(8,'Frans'),(9,'Engels'),(10,'Biologie'),(11,'Kernfysica');
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolCourses` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolDirections`
--

DROP TABLE IF EXISTS `DataSchoolDirections`;
CREATE TABLE `DataSchoolDirections` (
  `Id` int(3) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolDirections`
--


/*!40000 ALTER TABLE `DataSchoolDirections` DISABLE KEYS */;
LOCK TABLES `DataSchoolDirections` WRITE;
INSERT INTO `DataSchoolDirections` VALUES (5,'tweede jaar algemene vakken'),(4,'eerste jaar algemene vakken'),(6,'eerste jaar bio-esthethiek en haartooi'),(7,'tweede jar bio-esthetiek en haartooi');
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolDirections` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolElectivegroups`
--

DROP TABLE IF EXISTS `DataSchoolElectivegroups`;
CREATE TABLE `DataSchoolElectivegroups` (
  `Id` int(3) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolElectivegroups`
--


/*!40000 ALTER TABLE `DataSchoolElectivegroups` DISABLE KEYS */;
LOCK TABLES `DataSchoolElectivegroups` WRITE;
INSERT INTO `DataSchoolElectivegroups` VALUES (3,'groep A'),(4,'groep B'),(5,'groep C'),(6,'groep D'),(7,'verplicht');
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolElectivegroups` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolTeachers`
--

DROP TABLE IF EXISTS `DataSchoolTeachers`;
CREATE TABLE `DataSchoolTeachers` (
  `Id` int(3) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolTeachers`
--


/*!40000 ALTER TABLE `DataSchoolTeachers` DISABLE KEYS */;
LOCK TABLES `DataSchoolTeachers` WRITE;
INSERT INTO `DataSchoolTeachers` VALUES (3,'L. De Backer'),(4,'F. Van Damme'),(5,'S. Claes'),(6,'C. Bogaerts'),(7,'P. Vanduffel'),(8,'T. Hannens'),(9,'A. Einstein');
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolTeachers` ENABLE KEYS */;

--
-- Table structure for table `DataSchoolTimeslots`
--

DROP TABLE IF EXISTS `DataSchoolTimeslots`;
CREATE TABLE `DataSchoolTimeslots` (
  `Id` int(3) NOT NULL auto_increment,
  `Day` varchar(64) default NULL,
  `Start` int(2) default NULL,
  `Stop` int(2) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolTimeslots`
--


/*!40000 ALTER TABLE `DataSchoolTimeslots` DISABLE KEYS */;
LOCK TABLES `DataSchoolTimeslots` WRITE;
INSERT INTO `DataSchoolTimeslots` VALUES (2,'maandag',8,10),(3,'maandag',10,12),(4,'maandag',12,14),(5,'maandag',14,16),(6,'maandag',16,18),(7,'maandag',18,20),(8,'dinsdag',8,10),(9,'dinsdag',10,12),(10,'dinsdag',12,14),(11,'dinsdag',14,16),(12,'dinsdag',16,18),(13,'dinsdag',18,20),(14,'woensdag',8,10),(15,'woensdag',10,12),(16,'woensdag',12,14),(17,'woensdag',14,16),(18,'woensdag',16,18),(19,'woensdag',18,20),(20,'donderdag',8,10),(21,'donderdag',10,12),(22,'donderdag',12,14),(23,'donderdag',14,16),(24,'donderdag',16,18),(25,'donderdag',18,20),(26,'vrijdag',8,10),(27,'vrijdag',10,12),(28,'vrijdag',12,14),(29,'vrijdag',14,16),(30,'vrijdag',16,18),(31,'vrijdag',18,20);
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolTimeslots` ENABLE KEYS */;

--
-- Table structure for table `SystemAccounts`
--

DROP TABLE IF EXISTS `SystemAccounts`;
CREATE TABLE `SystemAccounts` (
  `Id` int(5) NOT NULL auto_increment,
  `Username` varchar(64) default NULL,
  `Usertype` varchar(64) default NULL,
  `Password` varchar(64) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SystemAccounts`
--


/*!40000 ALTER TABLE `SystemAccounts` DISABLE KEYS */;
LOCK TABLES `SystemAccounts` WRITE;
INSERT INTO `SystemAccounts` VALUES (1,'De Backer','teacher','585b1ac3cf671553e11f61fa6f1d5302'),(2,'Van Damme','teacher','585b1ac3cf671553e11f61fa6f1d5302'),(3,'Claes','teacher','585b1ac3cf671553e11f61fa6f1d5302'),(4,'Bogaerts','teacher','585b1ac3cf671553e11f61fa6f1d5302'),(5,'Vanduffel','teacher','585b1ac3cf671553e11f61fa6f1d5302'),(6,'Hanssens','teacher','585b1ac3cf671553e11f61fa6f1d5302'),(7,'data','data-admin','585b1ac3cf671553e11f61fa6f1d5302'),(8,'Thomas','student','585b1ac3cf671553e11f61fa6f1d5302'),(9,'Alfred','student','585b1ac3cf671553e11f61fa6f1d5302'),(10,'A. Einstein','teacher','585b1ac3cf671553e11f61fa6f1d5302');
UNLOCK TABLES;
/*!40000 ALTER TABLE `SystemAccounts` ENABLE KEYS */;

--
-- Table structure for table `SystemNodes`
--

DROP TABLE IF EXISTS `SystemNodes`;
CREATE TABLE `SystemNodes` (
  `Id` int(3) NOT NULL auto_increment,
  `Name` varchar(64) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SystemNodes`
--


/*!40000 ALTER TABLE `SystemNodes` DISABLE KEYS */;
LOCK TABLES `SystemNodes` WRITE;
INSERT INTO `SystemNodes` VALUES (5,'druby://localhost:3333'),(2,'druby://localhost:4444'),(4,'druby://localhost:5555');
UNLOCK TABLES;
/*!40000 ALTER TABLE `SystemNodes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

