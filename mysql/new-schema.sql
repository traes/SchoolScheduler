-- MySQL dump 10.9
--
-- Host: localhost    Database: traes
-- ------------------------------------------------------
-- Server version	4.1.19

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
  `Persons` int(3) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DataSchoolCoursemeetings`
--


/*!40000 ALTER TABLE `DataSchoolCoursemeetings` DISABLE KEYS */;
LOCK TABLES `DataSchoolCoursemeetings` WRITE;
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
UNLOCK TABLES;
/*!40000 ALTER TABLE `DataSchoolTimeslots` ENABLE KEYS */;

--
-- Table structure for table `SystemAccounts`
--

DROP TABLE IF EXISTS `SystemAccounts`;
CREATE TABLE `SystemAccounts` (
  `Id` int(5) NOT NULL auto_increment,
  `Username` varchar(64) default NULL,
  `UsertypeId` int(2) default NULL,
  `Password` varchar(64) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SystemAccounts`
--


/*!40000 ALTER TABLE `SystemAccounts` DISABLE KEYS */;
LOCK TABLES `SystemAccounts` WRITE;
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
UNLOCK TABLES;
/*!40000 ALTER TABLE `SystemNodes` ENABLE KEYS */;

--
-- Table structure for table `SystemUsertypes`
--

DROP TABLE IF EXISTS `SystemUsertypes`;
CREATE TABLE `SystemUsertypes` (
  `Id` int(2) NOT NULL auto_increment,
  `Usertype` varchar(64) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SystemUsertypes`
--


/*!40000 ALTER TABLE `SystemUsertypes` DISABLE KEYS */;
LOCK TABLES `SystemUsertypes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `SystemUsertypes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

