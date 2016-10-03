CREATE DATABASE  IF NOT EXISTS `webadmin` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `webadmin`;
-- MySQL dump 10.13  Distrib 5.7.9, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: webadmin
-- ------------------------------------------------------
-- Server version	5.6.30-0ubuntu0.15.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dictkey` varchar(255) DEFAULT NULL COMMENT '字典键',
  `dictvalues` varchar(255) DEFAULT NULL COMMENT '字典值',
  `dictgroup` varchar(255) DEFAULT NULL COMMENT '字典分组',
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dictkey` (`dictkey`,`dictgroup`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='系统字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` VALUES (2,'3','3','3','2016-05-11 21:34:25','1',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(255) DEFAULT NULL COMMENT '操作者',
  `log` longtext,
  `operate_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
INSERT INTO `sys_log` VALUES (2,'1','查看列表','2016-05-08 16:30:47'),(3,'1','[删除字典]{\"id\":25,\"dictkey\":\"2\",\"dictvalues\":\"23\",\"dictgroup\":\"2\",\"createtime\":\"May 8, 2016 4:18:56 PM\",\"creator\":\"1\",\"updatetime\":\"May 8, 2016 4:18:59 PM\",\"updator\":\"1\"}','2016-05-08 16:36:11'),(4,'1','[????]{\"name\":\"1\",\"orders\":1,\"icons\":\"1\",\"urls\":\"1\",\"isshow\":0,\"authname\":\"\"}','2016-05-10 23:22:05'),(5,'1','????{\"name\":\"3\",\"icons\":\"\",\"urls\":\"\",\"isshow\":0,\"authname\":\"\",\"createtime\":\"May 11, 2016 9:21:46 PM\",\"creator\":\"1\"}','2016-05-11 21:21:48'),(6,'1','[????]{\"dictkey\":\"2\",\"dictvalues\":\"2\",\"dictgroup\":\"2\",\"createtime\":\"May 11, 2016 9:34:10 PM\",\"creator\":\"1\"}','2016-05-11 21:34:11'),(7,'1','[????]{\"id\":1,\"dictkey\":\"2\",\"dictvalues\":\"2\",\"dictgroup\":\"23\",\"updatetime\":\"May 11, 2016 9:34:15 PM\",\"updator\":\"1\"}','2016-05-11 21:34:15'),(8,'1','[????]{\"id\":1,\"dictkey\":\"2\",\"dictvalues\":\"2\",\"dictgroup\":\"23\",\"createtime\":\"May 11, 2016 9:34:11 PM\",\"creator\":\"1\",\"updatetime\":\"May 11, 2016 9:34:15 PM\",\"updator\":\"1\"}','2016-05-11 21:34:18'),(9,'1','[????]{\"dictkey\":\"3\",\"dictvalues\":\"3\",\"dictgroup\":\"3\",\"createtime\":\"May 11, 2016 9:34:25 PM\",\"creator\":\"1\"}','2016-05-11 21:34:25'),(10,'1','[????]{\"name\":\"22\",\"icons\":\"\",\"urls\":\"22\",\"authname\":\"\",\"createtime\":\"May 13, 2016 8:39:04 PM\",\"creator\":\"1\"}','2016-05-13 20:39:04'),(11,'1','[????]{\"id\":34,\"name\":\"22\",\"icons\":\"\",\"urls\":\"22\",\"isshow\":1,\"authname\":\"\",\"createtime\":\"May 13, 2016 8:39:04 PM\",\"creator\":\"1\"}','2016-05-13 20:39:33'),(12,'1','[????]{\"name\":\"2\",\"icons\":\"\",\"urls\":\"2\",\"isshow\":0,\"authname\":\"2\",\"createtime\":\"May 13, 2016 8:39:47 PM\",\"creator\":\"1\"}','2016-05-13 20:39:48'),(13,'1','[????]{\"name\":\"2222\",\"icons\":\"\",\"urls\":\"2\",\"isshow\":0,\"authname\":\"2\",\"updatetime\":\"May 13, 2016 8:43:06 PM\",\"updator\":\"1\"}','2016-05-13 20:43:07'),(14,'1','[????]{\"name\":\"2222\",\"icons\":\"\",\"urls\":\"2\",\"isshow\":0,\"authname\":\"2\",\"updatetime\":\"May 13, 2016 8:43:41 PM\",\"updator\":\"1\"}','2016-05-13 20:43:41'),(15,'1','[????]{\"id\":35,\"name\":\"22\",\"icons\":\"\",\"urls\":\"2\",\"isshow\":0,\"authname\":\"2\",\"updatetime\":\"May 13, 2016 8:44:22 PM\",\"updator\":\"1\"}','2016-05-13 20:44:22'),(16,'1','[????]{\"id\":35,\"name\":\"2233\",\"icons\":\"\",\"urls\":\"2\",\"isshow\":0,\"authname\":\"2\",\"updatetime\":\"May 13, 2016 8:44:35 PM\",\"updator\":\"1\"}','2016-05-13 20:44:36'),(17,'1','[????]{\"id\":35,\"name\":\"2233\",\"icons\":\"\",\"urls\":\"2\",\"isshow\":0,\"authname\":\"2\",\"createtime\":\"May 13, 2016 8:39:48 PM\",\"creator\":\"1\",\"updatetime\":\"May 13, 2016 8:44:36 PM\",\"updator\":\"1\"}','2016-05-13 20:44:38'),(18,'1','[????]{\"name\":\"4\",\"icons\":\"\",\"urls\":\"4\",\"isshow\":1,\"authname\":\"4\",\"createtime\":\"May 14, 2016 4:11:39 PM\",\"creator\":\"1\"}','2016-05-14 16:11:40'),(19,'1','[????]{\"id\":34,\"name\":\"42\",\"icons\":\"\",\"urls\":\"4\",\"isshow\":0,\"authname\":\"4\",\"updatetime\":\"May 14, 2016 4:11:46 PM\",\"updator\":\"1\"}','2016-05-14 16:11:47'),(20,'1','[????]{\"id\":34,\"name\":\"42\",\"icons\":\"\",\"urls\":\"4\",\"isshow\":0,\"authname\":\"4\",\"createtime\":\"May 14, 2016 4:11:40 PM\",\"creator\":\"1\",\"updatetime\":\"May 14, 2016 4:11:47 PM\",\"updator\":\"1\"}','2016-05-14 16:11:51'),(21,'1','[????]{\"id\":1,\"name\":\"??\",\"orders\":1,\"icons\":\"nav-home\",\"urls\":\"#\",\"isshow\":1,\"authname\":\"\",\"updatetime\":\"May 14, 2016 4:22:20 PM\",\"updator\":\"1\"}','2016-05-14 16:22:21'),(22,'1','[编辑菜单]{\"id\":1,\"name\":\"首页\",\"orders\":1,\"icons\":\"nav-home\",\"urls\":\"#\",\"isshow\":1,\"authname\":\"\",\"updatetime\":\"May 14, 2016 4:33:07 PM\",\"updator\":\"1\"}','2016-05-14 16:33:08'),(23,'1','[新增角色]{\"name\":\"4,3\",\"comment\":\"4,3\",\"createtime\":\"May 14, 2016 5:11:43 PM\",\"creator\":\"1\"}','2016-05-14 17:11:44'),(24,'1','[删除角色]{\"id\":4,\"name\":\"4,3\",\"comment\":\"4,3\",\"createtime\":\"May 14, 2016 5:11:43 PM\",\"creator\":\"1\"}','2016-05-14 17:11:51'),(25,'1','[新增角色]{\"name\":\"4\",\"comment\":\"4\",\"createtime\":\"May 14, 2016 5:14:31 PM\",\"creator\":\"1\"}','2016-05-14 17:14:31'),(26,'1','[编辑角色]{\"id\":5,\"name\":\"43\",\"comment\":\"4\",\"updatetime\":\"May 14, 2016 5:16:17 PM\",\"updator\":\"1\"}','2016-05-14 17:16:18'),(27,'1','[新增用户]{\"name\":\"333\",\"comment\":\"\",\"enabled\":1,\"password\":\"c4ca4238a0b923820dcc509a6f75849b\",\"accounts\":\"1\",\"createtime\":\"May 15, 2016 3:49:29 PM\",\"creator\":\"1\"}','2016-05-15 15:49:29'),(28,'1','[编辑用户]{\"id\":4,\"name\":\"3333\",\"comment\":\"\",\"enabled\":1,\"password\":\"c4ca4238a0b923820dcc509a6f75849b\",\"accounts\":\"1\",\"updatetime\":\"May 15, 2016 3:49:47 PM\",\"updator\":\"1\"}','2016-05-15 15:49:47');
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '菜单名称',
  `orders` int(11) DEFAULT NULL COMMENT '菜单排序',
  `icons` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `urls` varchar(255) DEFAULT NULL COMMENT '菜单地址',
  `parentid` int(11) DEFAULT NULL COMMENT '上级菜单ID',
  `isshow` int(11) DEFAULT NULL COMMENT '是否显示 0 是 1 否',
  `authname` varchar(255) DEFAULT NULL COMMENT '权限注解',
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentid` (`parentid`),
  KEY `authname` (`authname`),
  CONSTRAINT `sys_menu_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'首页',1,'nav-home','#',NULL,1,'',NULL,NULL,'2016-05-14 16:33:08','1'),(2,'系统管理',2,'nav-home','#',NULL,1,NULL,NULL,NULL,NULL,NULL),(3,'角色管理',21,'nav-home','/admin/roles/index',2,1,NULL,NULL,NULL,NULL,NULL),(4,'菜单管理',1,'','/admin/menus/index',2,1,NULL,NULL,NULL,NULL,NULL),(6,'用户管理',NULL,'','/admin/users/index',2,1,NULL,NULL,NULL,NULL,NULL),(7,'仪表盘',NULL,'','/admin/index',1,1,'ROLE_SYS_MAINFORM',NULL,NULL,NULL,NULL),(8,'字典管理',NULL,'','/admin/dict/index',2,1,NULL,NULL,NULL,NULL,NULL),(11,'新增角色',NULL,NULL,NULL,3,1,'ROLE_SYS_ROLE_ADD',NULL,NULL,NULL,NULL),(12,'编辑角色',NULL,NULL,NULL,3,1,'ROLE_SYS_ROLE_EDIT',NULL,NULL,NULL,NULL),(13,'删除角色',NULL,NULL,NULL,3,1,'ROLE_SYS_ROLE_DELETE',NULL,NULL,NULL,NULL),(14,'配置用户',NULL,NULL,NULL,3,1,'ROLE_SYS_ROLE_CONFIGUSER',NULL,NULL,NULL,NULL),(15,'配置菜单',NULL,NULL,NULL,3,1,'ROLE_SYS_ROLE_CONFIGMENU',NULL,NULL,NULL,NULL),(16,'查看列表',NULL,NULL,NULL,3,1,'ROLE_SYS_ROLE_LIST',NULL,NULL,NULL,NULL),(17,'新增菜单',NULL,NULL,NULL,4,1,'ROLE_SYS_MENU_ADD',NULL,NULL,NULL,NULL),(18,'编辑菜单',NULL,NULL,NULL,4,1,'ROLE_SYS_MENU_EDIT',NULL,NULL,NULL,NULL),(19,'删除菜单',NULL,NULL,NULL,4,1,'ROLE_SYS_MENU_DELETE',NULL,NULL,NULL,NULL),(20,'查看菜单',NULL,NULL,NULL,4,1,'ROLE_SYS_MENU_LIST',NULL,NULL,NULL,NULL),(21,'新增用户',NULL,NULL,NULL,6,1,'ROLE_SYS_USER_ADD',NULL,NULL,NULL,NULL),(22,'编辑用户',NULL,NULL,NULL,6,1,'ROLE_SYS_USER_EDIT',NULL,NULL,NULL,NULL),(24,'删除用户',NULL,NULL,NULL,6,1,'ROLE_SYS_USER_DELETE',NULL,NULL,NULL,NULL),(25,'配置角色',NULL,NULL,NULL,6,1,'ROLE_SYS_USER_CONFIGROLE',NULL,NULL,NULL,NULL),(26,'查看仪表盘',NULL,NULL,NULL,7,1,'ROLE_SYS_MAINFORM',NULL,NULL,NULL,NULL),(27,'新增字典',NULL,NULL,NULL,8,1,'ROLE_SYS_DICT_ADD',NULL,NULL,NULL,NULL),(28,'查看字典',NULL,NULL,NULL,8,1,'ROLE_SYS_DICT_LIST',NULL,NULL,NULL,NULL),(29,'删除字典',NULL,NULL,NULL,8,1,'ROLE_SYS_DICT_DELETE',NULL,NULL,NULL,NULL),(30,'编辑字典',NULL,NULL,NULL,8,1,'ROLE_SYS_DICT_EDIT',NULL,NULL,NULL,NULL),(31,'系统权限-管理员',NULL,NULL,NULL,NULL,2,'ROLE_ADMIN',NULL,NULL,NULL,NULL),(32,'系统权限-用户',NULL,NULL,NULL,NULL,2,'ROLE_USER',NULL,NULL,NULL,NULL),(33,'查看用户',NULL,NULL,NULL,6,1,'ROLE_SYS_USER_LIST',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `comment` varchar(255) DEFAULT NULL COMMENT '角色备注',
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'系统管理员','系统管理员',NULL,NULL,NULL,NULL),(3,'3','3',NULL,NULL,NULL,NULL),(5,'43','4','2016-05-14 17:14:31','1','2016-05-14 17:16:18','1');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_auth`
--

DROP TABLE IF EXISTS `sys_role_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  `authname` varchar(255) DEFAULT NULL COMMENT '角色权限',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `sys_role_auth_ibfk_1` (`authname`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `sys_role_auth_ibfk_1` FOREIGN KEY (`authname`) REFERENCES `sys_menu` (`authname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_auth_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='角色权限记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_auth`
--

LOCK TABLES `sys_role_auth` WRITE;
/*!40000 ALTER TABLE `sys_role_auth` DISABLE KEYS */;
INSERT INTO `sys_role_auth` VALUES (1,1,'ROLE_ADMIN',NULL),(2,1,'ROLE_USER',NULL),(4,1,'ROLE_SYS_DICT_ADD',NULL),(5,1,'ROLE_SYS_DICT_EDIT',NULL),(6,1,'ROLE_SYS_DICT_DELETE',NULL),(7,1,'ROLE_SYS_DICT_LIST',NULL),(8,1,'ROLE_SYS_MAINFORM',NULL),(9,1,'ROLE_SYS_MENU_LIST',NULL),(10,1,'ROLE_SYS_MENU_ADD',NULL),(11,1,'ROLE_SYS_MENU_EDIT',NULL),(12,1,'ROLE_SYS_MENU_DELETE',NULL),(13,1,'ROLE_SYS_ROLE_LIST',NULL),(14,1,'ROLE_SYS_ROLE_ADD',NULL),(15,1,'ROLE_SYS_ROLE_EDIT',NULL),(16,1,'ROLE_SYS_ROLE_DELETE',NULL),(17,1,'ROLE_SYS_ROLE_CONFIGUSER',NULL),(18,1,'ROLE_SYS_ROLE_CONFIGMENU',NULL),(19,1,'ROLE_SYS_USER_LIST',NULL),(20,1,'ROLE_SYS_USER_ADD',NULL),(21,1,'ROLE_SYS_USER_EDIT',NULL),(22,1,'ROLE_SYS_USER_DELETE',NULL),(23,1,'ROLE_SYS_USER_CONFIGROLE',NULL),(26,3,'ROLE_SYS_MAINFORM',NULL),(27,3,'ROLE_SYS_MAINFORM',NULL),(28,3,NULL,NULL),(29,3,'ROLE_SYS_ROLE_ADD',NULL),(30,3,'ROLE_SYS_ROLE_EDIT',NULL),(31,3,'ROLE_SYS_ROLE_DELETE',NULL),(32,3,'ROLE_SYS_ROLE_CONFIGUSER',NULL),(33,3,'ROLE_SYS_ROLE_CONFIGMENU',NULL),(34,3,NULL,NULL),(35,3,'ROLE_SYS_MENU_ADD',NULL),(36,3,'ROLE_SYS_MENU_EDIT',NULL),(37,3,'ROLE_SYS_MENU_DELETE',NULL),(38,3,'ROLE_SYS_MENU_LIST',NULL),(39,3,NULL,NULL),(40,3,'ROLE_SYS_USER_ADD',NULL),(41,3,'ROLE_SYS_USER_EDIT',NULL),(42,3,'ROLE_SYS_USER_DELETE',NULL),(43,3,'ROLE_SYS_USER_CONFIGROLE',NULL),(44,3,'ROLE_SYS_USER_LIST',NULL),(45,3,NULL,NULL),(46,3,'ROLE_SYS_DICT_ADD',NULL),(47,3,'ROLE_SYS_DICT_LIST',NULL),(48,3,'ROLE_SYS_DICT_DELETE',NULL),(49,3,'ROLE_SYS_DICT_EDIT',NULL),(50,3,'ROLE_USER',NULL),(51,5,'ROLE_SYS_MAINFORM',NULL),(52,5,'ROLE_SYS_MAINFORM',NULL),(53,NULL,'ROLE_USER',NULL);
/*!40000 ALTER TABLE `sys_role_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menuid` (`menuid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `sys_role_menu_ibfk_1` FOREIGN KEY (`menuid`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_menu_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='角色菜单关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (4,3,1),(5,4,1),(6,6,1),(9,7,3),(10,26,3),(11,3,3),(12,11,3),(13,12,3),(14,13,3),(15,14,3),(16,15,3),(17,4,3),(18,17,3),(19,18,3),(20,19,3),(21,20,3),(22,6,3),(23,21,3),(24,22,3),(25,24,3),(26,25,3),(27,33,3),(28,8,3),(29,27,3),(30,28,3),(31,29,3),(32,30,3),(33,7,5),(34,26,5);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_user`
--

DROP TABLE IF EXISTS `sys_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleid` (`roleid`),
  KEY `userid` (`userid`),
  CONSTRAINT `sys_role_user_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_user_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='角色用户关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_user`
--

LOCK TABLES `sys_role_user` WRITE;
/*!40000 ALTER TABLE `sys_role_user` DISABLE KEYS */;
INSERT INTO `sys_role_user` VALUES (3,1,1),(5,3,1),(8,1,5),(9,4,5);
/*!40000 ALTER TABLE `sys_role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `accounts` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts` (`accounts`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'1','1',1,'c4ca4238a0b923820dcc509a6f75849b','1',NULL,NULL,NULL,NULL),(3,'2','2',1,'c81e728d9d4c2f636f067f89cc14862c','2',NULL,NULL,NULL,NULL),(4,'3333','',1,'c4ca4238a0b923820dcc509a6f75849b','1','2016-05-15 15:49:29','1','2016-05-15 15:49:47','1');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-15 16:13:57
