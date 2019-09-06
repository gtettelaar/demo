-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: happylager
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

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
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `craft_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assets`
--

DROP TABLE IF EXISTS `craft_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assets_folderId_idx` (`folderId`),
  KEY `craft_assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_idx` (`groupId`),
  KEY `craft_categories_parentId_fk` (`parentId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categorygroups_name_idx` (`name`),
  KEY `craft_categorygroups_handle_idx` (`handle`),
  KEY `craft_categorygroups_structureId_idx` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups_sites`
--

DROP TABLE IF EXISTS `craft_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `craft_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_content_siteId_idx` (`siteId`),
  KEY `craft_content_title_idx` (`title`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_craftidtokens`
--

DROP TABLE IF EXISTS `craft_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craft_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_drafts`
--

DROP TABLE IF EXISTS `craft_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `craft_drafts_sourceId_fk` (`sourceId`),
  KEY `craft_drafts_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elementindexsettings`
--

DROP TABLE IF EXISTS `craft_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `craft_elements_draftId_fk` (`draftId`),
  KEY `craft_elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `craft_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `craft_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements_sites`
--

DROP TABLE IF EXISTS `craft_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_elements_sites_siteId_idx` (`siteId`),
  KEY `craft_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `craft_elements_sites_enabled_idx` (`enabled`),
  KEY `craft_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `craft_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_idx` (`authorId`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_parentId_fk` (`parentId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafterrors`
--

DROP TABLE IF EXISTS `craft_entrydrafterrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafterrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `craft_entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `craft_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entrydrafts_siteId_idx` (`siteId`),
  KEY `craft_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `craft_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_idx` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversionerrors`
--

DROP TABLE IF EXISTS `craft_entryversionerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversionerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versionId` int(11) DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `craft_entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `craft_entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_sectionId_idx` (`sectionId`),
  KEY `craft_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entryversions_siteId_idx` (`siteId`),
  KEY `craft_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_groupId_idx` (`groupId`),
  KEY `craft_fields_context_idx` (`context`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_globalsets_name_idx` (`name`),
  KEY `craft_globalsets_handle_idx` (`handle`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_gqlschemas`
--

DROP TABLE IF EXISTS `craft_gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_gqlschemas_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `craft_gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_migrations_pluginId_idx` (`pluginId`),
  KEY `craft_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_queue`
--

DROP TABLE IF EXISTS `craft_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `craft_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `craft_relations_sourceId_idx` (`sourceId`),
  KEY `craft_relations_targetId_idx` (`targetId`),
  KEY `craft_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_resourcepaths`
--

DROP TABLE IF EXISTS `craft_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_revisions`
--

DROP TABLE IF EXISTS `craft_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `craft_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sections_handle_idx` (`handle`),
  KEY `craft_sections_name_idx` (`name`),
  KEY `craft_sections_structureId_idx` (`structureId`),
  KEY `craft_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections_sites`
--

DROP TABLE IF EXISTS `craft_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `craft_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sequences`
--

DROP TABLE IF EXISTS `craft_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_idx` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sitegroups`
--

DROP TABLE IF EXISTS `craft_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sites`
--

DROP TABLE IF EXISTS `craft_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sites_handle_idx` (`handle`),
  KEY `craft_sites_sortOrder_idx` (`sortOrder`),
  KEY `craft_sites_groupId_fk` (`groupId`),
  CONSTRAINT `craft_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_systemmessages`
--

DROP TABLE IF EXISTS `craft_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `craft_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_taggroups_name_idx` (`name`),
  KEY `craft_taggroups_handle_idx` (`handle`),
  KEY `craft_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_idx` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecachequeries`
--

DROP TABLE IF EXISTS `craft_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `craft_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `craft_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `craft_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `craft_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `craft_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpreferences`
--

DROP TABLE IF EXISTS `craft_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `craft_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_email_idx` (`email`),
  KEY `craft_users_username_idx` (`username`),
  KEY `craft_users_photoId_fk` (`photoId`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `craft_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumefolders`
--

DROP TABLE IF EXISTS `craft_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `craft_volumefolders_parentId_idx` (`parentId`),
  KEY `craft_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumes`
--

DROP TABLE IF EXISTS `craft_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_volumes_name_idx` (`name`),
  KEY `craft_volumes_handle_idx` (`handle`),
  KEY `craft_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_idx` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'happylager'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-06  9:43:34
-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: happylager
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

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
-- Dumping data for table `craft_assets`
--

LOCK TABLES `craft_assets` WRITE;
/*!40000 ALTER TABLE `craft_assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups_sites`
--

LOCK TABLES `craft_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_content` VALUES (1,1,1,NULL,'2019-09-06 09:04:11','2019-09-06 09:04:11','f12ffe78-5bb0-4ed5-905e-2c1ceb49cd27'),(3,3,1,'Blog article 1','2019-09-06 09:38:45','2019-09-06 09:41:04','646fce97-990f-423b-a2aa-dc7d2099cecb'),(4,4,1,'Blog article 1','2019-09-06 09:38:45','2019-09-06 09:38:45','bbc9f673-ea01-4337-86ab-311f4eddae9d'),(6,6,1,'Blog article 2','2019-09-06 09:38:56','2019-09-06 09:41:04','e9b9fa4f-a08e-4fab-9de3-063d201a9e27'),(7,7,1,'Blog article 2','2019-09-06 09:38:56','2019-09-06 09:38:56','49465688-5d8d-4d0f-b8c5-05581696647c'),(9,9,1,'Blog article 3','2019-09-06 09:39:07','2019-09-06 09:41:04','bb7507ea-d549-4b6a-83b9-74469419a6a4'),(10,10,1,'Blog article 3','2019-09-06 09:39:07','2019-09-06 09:39:07','c9c1a320-83ab-44d3-a3b9-7d29a8d6fcf6');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_craftidtokens`
--

LOCK TABLES `craft_craftidtokens` WRITE;
/*!40000 ALTER TABLE `craft_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_drafts`
--

LOCK TABLES `craft_drafts` WRITE;
/*!40000 ALTER TABLE `craft_drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-09-06 09:04:11','2019-09-06 09:04:11',NULL,'b0d3d613-cd6b-404f-8d6c-f529f0105f5c'),(3,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-09-06 09:38:32','2019-09-06 09:38:45',NULL,'1d27fd62-6a27-4507-967b-ee229ceebc21'),(4,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2019-09-06 09:38:45','2019-09-06 09:38:45',NULL,'99b79dfa-4e46-4fd6-98e5-e78099cbe19f'),(6,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-09-06 09:38:47','2019-09-06 09:38:56',NULL,'d282a391-a13c-4069-9e33-21d96d1f2ee7'),(7,NULL,2,NULL,'craft\\elements\\Entry',1,0,'2019-09-06 09:38:56','2019-09-06 09:38:56',NULL,'d78caecd-34fc-478c-a61f-8bd0dc3dde71'),(9,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-09-06 09:38:58','2019-09-06 09:39:07',NULL,'d4d13b35-20c8-4899-bd2e-91cc7ae5435b'),(10,NULL,3,NULL,'craft\\elements\\Entry',1,0,'2019-09-06 09:39:07','2019-09-06 09:39:07',NULL,'8f00097e-cc7f-44f2-a157-c0d435481576');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements_sites`
--

LOCK TABLES `craft_elements_sites` WRITE;
/*!40000 ALTER TABLE `craft_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-09-06 09:04:11','2019-09-06 09:04:11','5bf2fe98-5e61-4736-a255-794a8df0b6ed'),(3,3,1,'blog-article-1',NULL,1,'2019-09-06 09:38:45','2019-09-06 09:38:45','e3520d37-1234-4c52-b8f7-c7724bf0ed04'),(4,4,1,'blog-article-1',NULL,1,'2019-09-06 09:38:45','2019-09-06 09:38:45','ab5d988a-e72d-470a-b4ad-0a9844ed2c5c'),(6,6,1,'blog-article-2',NULL,1,'2019-09-06 09:38:56','2019-09-06 09:38:56','a6840044-5975-4746-976c-f3a994a6dc6b'),(7,7,1,'blog-article-2',NULL,1,'2019-09-06 09:38:56','2019-09-06 09:38:56','db87bba7-5f7e-44fc-84b9-3848870b7201'),(9,9,1,'blog-article-3',NULL,1,'2019-09-06 09:39:07','2019-09-06 09:39:07','8efeee5c-d7d0-4eda-a858-6c15aeae1b45'),(10,10,1,'blog-article-3',NULL,1,'2019-09-06 09:39:07','2019-09-06 09:39:07','8be79c0f-fe68-4684-b3db-f08fb7f61307');
/*!40000 ALTER TABLE `craft_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entries` VALUES (3,1,NULL,1,1,'2019-09-06 09:38:00',NULL,NULL,'2019-09-06 09:38:45','2019-09-06 09:38:45','3c7943fc-c035-4579-9716-28ef992f0647'),(4,1,NULL,1,1,'2019-09-06 09:38:00',NULL,NULL,'2019-09-06 09:38:45','2019-09-06 09:38:45','a31e1f25-39ef-45ec-bf86-4210542512cd'),(6,1,NULL,1,1,'2019-09-06 09:38:00',NULL,NULL,'2019-09-06 09:38:56','2019-09-06 09:38:56','4da9c7ea-c7c5-4761-9013-b6e76cde36d3'),(7,1,NULL,1,1,'2019-09-06 09:38:00',NULL,NULL,'2019-09-06 09:38:56','2019-09-06 09:38:56','7be6edbc-5ddf-480a-8b7b-3b52d10b6cbe'),(9,1,NULL,1,1,'2019-09-06 09:38:00',NULL,NULL,'2019-09-06 09:39:07','2019-09-06 09:39:07','b9fbde7a-5461-45c8-b21b-45f9f6ed63df'),(10,1,NULL,1,1,'2019-09-06 09:38:00',NULL,NULL,'2019-09-06 09:39:07','2019-09-06 09:39:07','e5c8f388-87ca-4f62-a6da-6ee0afc27d0a');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafterrors`
--

LOCK TABLES `craft_entrydrafterrors` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafterrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafterrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entrytypes` VALUES (1,1,NULL,'Blog','blog',1,'Title','',1,'2019-09-06 09:38:19','2019-09-06 09:41:01',NULL,'365dc3b2-73ad-42d8-be98-1adc552adc40');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversionerrors`
--

LOCK TABLES `craft_entryversionerrors` WRITE;
/*!40000 ALTER TABLE `craft_entryversionerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entryversionerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldgroups` VALUES (1,'Common','2019-09-06 09:04:11','2019-09-06 09:04:11','f5bf5da0-9d15-4e69-9700-89ac33a92c39');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_gqlschemas`
--

LOCK TABLES `craft_gqlschemas` WRITE;
/*!40000 ALTER TABLE `craft_gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_info` VALUES (1,'3.3.0.1','3.3.3',0,'{\"fieldGroups\":{\"f5bf5da0-9d15-4e69-9700-89ac33a92c39\":{\"name\":\"Common\"}},\"siteGroups\":{\"d2c8fc19-e330-476c-9fc8-b86dd8452e16\":{\"name\":\"Happylager\"}},\"sites\":{\"cde3602d-b5f5-4190-8f36-ce58b7251dab\":{\"baseUrl\":\"$DEFAULT_SITE_URL\",\"handle\":\"default\",\"hasUrls\":true,\"language\":\"en-US\",\"name\":\"Happylager\",\"primary\":true,\"siteGroup\":\"d2c8fc19-e330-476c-9fc8-b86dd8452e16\",\"sortOrder\":1}},\"email\":{\"fromEmail\":\"giel@yellowflash.net\",\"fromName\":\"Happylager\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"system\":{\"edition\":\"solo\",\"name\":\"Happylager\",\"live\":true,\"schemaVersion\":\"3.3.3\",\"timeZone\":\"America/Los_Angeles\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeUid\":null,\"photoSubpath\":\"\"},\"dateModified\":1567762861,\"sections\":{\"54239566-8b6a-412c-a35d-e4f5f574c3fa\":{\"name\":\"Blog\",\"handle\":\"blog\",\"type\":\"channel\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"cde3602d-b5f5-4190-8f36-ce58b7251dab\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":\"\",\"template\":null}},\"entryTypes\":{\"365dc3b2-73ad-42d8-be98-1adc552adc40\":{\"name\":\"Blog\",\"handle\":\"blog\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"\",\"sortOrder\":1}}}}}','[]','lwUgyRBOtLlX','2019-09-06 09:04:11','2019-09-06 09:04:13','ae75cc12-94e2-45eb-bd06-17fb1df162c7');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_migrations` VALUES (1,NULL,'app','Install','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','ce7a0be7-79cb-4258-9295-481a12ff8d8e'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','3e3a6d41-0683-4833-8b61-30622d9a137b'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','acfd98e1-8750-4373-a3d3-dbacec08e187'),(4,NULL,'app','m150403_184533_field_version','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','89d2751c-f529-4eaf-9d4b-eef27be27e5e'),(5,NULL,'app','m150403_184729_type_columns','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','cf746b2f-ebcb-4437-a39f-512663d3336d'),(6,NULL,'app','m150403_185142_volumes','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','fb2680ce-5020-4184-b436-be5e30de2f9a'),(7,NULL,'app','m150428_231346_userpreferences','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','4a9cc959-e2cc-46bc-a636-0b090ebb0275'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','9b183b8e-3690-40b4-baa4-07c1c80fab9b'),(9,NULL,'app','m150617_213829_update_email_settings','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','5bb03ebe-206f-4ada-a14d-b9023cd3b90b'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','b8c94882-1c69-4ec4-b28c-79b4a0d1f7f4'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','1102e8f1-d47c-415e-87d6-742bac9cbd52'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','1141d825-8829-425f-92d2-06b6452e1ac9'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','e1ec42be-6bb7-441f-887a-59c581f1395b'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','e755b866-76f6-4050-9fc8-a3e38f52c6d2'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','1a1068b1-0481-4340-b37d-264eac62c53a'),(16,NULL,'app','m151209_000000_move_logo','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','08afa4c6-2368-40a0-bb75-a187549798cd'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','87e52e01-75fb-4df1-aeaa-79f43915941d'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','1a92e964-3237-4ec0-995b-204cf9804cb2'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','a4866399-cf3b-4db2-955f-e4c73b0ef6f5'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','78750638-fb32-436e-8124-6f0c4825b648'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','b29e82d1-4113-4515-8a2a-8bba7e64eec4'),(22,NULL,'app','m160727_194637_column_cleanup','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','f606e103-038f-43af-8f2e-80c86b0a92c1'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','08dbd417-d389-48f3-9dba-5d66f4b26f84'),(24,NULL,'app','m160807_144858_sites','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','b1889940-c86e-4758-a99c-4040f9001c69'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','60373b25-394f-4ce8-a5e9-da0182e12517'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','68a49214-6b2f-4559-b18f-aacfa0231c8d'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','d206880d-ed81-4df7-b266-d65cc701b69f'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','4973fe49-8ab4-4f0e-958a-6924d0255c10'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','784816a3-65cf-4f16-8155-a3da8ee85630'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','0ea2056b-7ce7-4758-8920-c7a31b23e15f'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','e32ff921-a73c-4b46-93b8-5c5b6039f7af'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','db4911fa-f3fe-46cf-953a-bfb7a0e664b7'),(33,NULL,'app','m161007_130653_update_email_settings','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','ef4dc960-0c1a-481e-8cfa-622d4bfc7b6b'),(34,NULL,'app','m161013_175052_newParentId','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','3c35c995-419f-479c-94b3-b9a6cfcc36bc'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','b043ebd3-11d8-49c2-bb15-3638ed1fe92a'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','87d460de-fd58-40e6-9a96-357ad92f7e11'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','a1e56c44-d6e6-4438-9ee9-73280dc5d2e7'),(38,NULL,'app','m161029_124145_email_message_languages','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','7a1be5f7-9a3b-4976-ba14-a87a78343177'),(39,NULL,'app','m161108_000000_new_version_format','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','bf4ababa-a8bb-443c-9c27-97aef43e375e'),(40,NULL,'app','m161109_000000_index_shuffle','2019-09-06 09:04:12','2019-09-06 09:04:12','2019-09-06 09:04:12','fb43b173-8feb-4c03-bb4e-fd696511a6de'),(41,NULL,'app','m161122_185500_no_craft_app','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','2f9e8809-db68-4598-b9c0-8c9cab0d0cea'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','06f7c290-3bca-4877-96f2-4cfe8f6c6611'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','8d150bfe-66a9-4392-9f9d-a1b7c62f9acc'),(44,NULL,'app','m170114_161144_udates_permission','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','3d2f3208-441e-47f7-b820-7519060f339d'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','9614f97a-e6bd-4036-8053-ab2e0e661d09'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','c5286960-dba8-4ad5-8efd-c07afe58c9ee'),(47,NULL,'app','m170206_142126_system_name','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','6d849be9-0397-4352-88d1-0eaddd452912'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','4605e0bc-5243-4686-adce-257156df44c5'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','11c47e90-ea12-4549-8e1d-6a2dfaa7ffbe'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','15d5c5eb-5b08-445c-8ce3-ef78a1900eeb'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','681bd90a-f754-40bd-959e-5f83252dba62'),(52,NULL,'app','m170228_171113_system_messages','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','c1674d9f-5cba-41c3-a83b-f9ce5ce5a557'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','c9dda69d-3fb3-4116-a166-ad2eb1656889'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','feec7737-5046-49d4-abce-6dd8eeff7bea'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','3f60ae45-7eff-49c4-9c99-74ee6b9f1a53'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','3652759d-2b57-4165-9b3e-a4acad2cbe0e'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','06122ec8-d328-4e95-8011-645e8b8bb751'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','4961b874-5a63-4cdb-893e-db447dc38f30'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','7d563c27-f996-4da5-88cf-360afacce132'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','354eb0d5-f33e-4447-976a-72a64affb26a'),(61,NULL,'app','m170704_134916_sites_tables','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','e25f2910-5e9e-4732-b908-1909b349eb0a'),(62,NULL,'app','m170706_183216_rename_sequences','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','e8b97677-103b-4458-86a5-f6e58ce65c34'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','aa5d9bc5-dd7b-4ac4-9145-cc7f598531bb'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','ed615d2e-479e-4944-8f65-7ec7aba2735a'),(65,NULL,'app','m170810_201318_create_queue_table','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','1da061a5-131e-4217-a8e7-25fa046f80e4'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','c3714476-7d1e-469a-945d-484f7b9dfc40'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','b6baecdd-0ed0-4880-b271-2f560fc53157'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','0ef5baa9-9ee5-47b8-aa96-5584bd234641'),(69,NULL,'app','m171011_214115_site_groups','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','88534fa9-14cc-4836-832b-0caa5a39467a'),(70,NULL,'app','m171012_151440_primary_site','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','76acd844-ab17-4687-9287-b010cf5580f2'),(71,NULL,'app','m171013_142500_transform_interlace','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','bdfe84c9-10f7-4c3d-bd15-43f55f2de7d7'),(72,NULL,'app','m171016_092553_drop_position_select','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','0c18b9f2-113b-4ed5-bb1c-8155485a139e'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','49daa32b-f4ee-42e6-add7-a8ec2437e5aa'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','7dc56fdc-522e-428e-89ca-0bfafae908b0'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','f053bd5d-46ae-458b-b40c-6919a70a1b0e'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','329df945-d6e9-4c33-8789-4bc2c18b247a'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','ef102604-8318-4229-a713-6b08e35a7e36'),(78,NULL,'app','m171202_004225_update_email_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','ca70ce2c-5a20-41a1-8c8d-1e67fcb68107'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','8307c578-3f19-4a85-8d2e-137aa7be0e5e'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','85554506-7436-4871-8b9e-2c1034f74511'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','1d3ee079-c943-4f23-be27-01f5a50201d9'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','962eb885-4d78-471c-8020-6ad07b20fdf1'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','afcf7813-a978-4425-bf62-bc78d084b9c1'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','f8becad2-168a-4f28-8b2f-51c78c382dad'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','94b0c36a-ebdf-4435-bb97-782b1ca95317'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','27a35db7-af60-4f16-bbb0-ab6b88d340e2'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','bfe4470a-7612-4096-8705-6a68f1f3f861'),(88,NULL,'app','m180217_172123_tiny_ints','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','560b1d5c-5f2a-4da5-9b48-c321b67256d4'),(89,NULL,'app','m180321_233505_small_ints','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','8da4cb17-25aa-4fc5-8701-bf48edf6f27f'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','016cfbc8-3b06-4b46-9c88-578476593f3c'),(91,NULL,'app','m180404_182320_edition_changes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','99545f59-c173-4e09-9a09-42268a7768b1'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','eb5cde7e-2500-4e3c-9a4b-9b4aefbe6ad1'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','e77ed0e5-076e-4d32-8520-1a3ba0b4ba10'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','9217e713-147c-4c48-8bb3-43f674743836'),(95,NULL,'app','m180425_203349_searchable_fields','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','ddcdc60b-b9e0-4298-a466-2fdf516e5afa'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','346e95d0-8479-4c22-b89d-7b0acbb1fa3d'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d2d595ba-7f9d-41fd-857b-0af7bdfef9d8'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','8b4dd0d7-4616-492b-988b-4117910da593'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d5f65def-0522-451e-b7ad-ce6061610c3e'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','18cfaec0-6acd-4c13-a779-fc2d7be94684'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','5f3ce74b-c2e7-4116-8cd4-dc1b46aef341'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d0154b2b-4eb7-4e33-878e-be7448b10e37'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','b3bc1a87-bbf6-426d-8982-d1c2a30d282a'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','e0403ef0-22a5-44d5-80c2-33f3c2d74c4a'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','5b1157fb-093b-4f78-81a8-bedc7a8d73e3'),(106,NULL,'app','m180904_112109_permission_changes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','e4761e65-9689-4e77-b4f3-dbcf4d445451'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','b7f903ca-e946-4d12-9014-65d87ce8280c'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','82e97177-9f3c-444d-9b24-b78afe38e0aa'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','24a8cb21-48ff-4afd-af54-e0ecd62f1dea'),(110,NULL,'app','m181017_225222_system_config_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','08d5098e-47fb-44a0-8411-b4b955dab00c'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','450bf9f3-7dba-476b-82cd-baede4c2d7d3'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','75da3d68-d5e0-498e-954b-c43bdd2792d0'),(113,NULL,'app','m181112_203955_sequences_table','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','ba95aeb4-8371-4010-bc97-182743a1b582'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d0045402-770c-43dd-ae8f-318a6207090d'),(115,NULL,'app','m181128_193942_fix_project_config','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','828546e3-f4a2-4b5e-bf13-e7d1fc40939d'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','54dce382-40ea-485c-8f49-24e8aaf54d03'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d2db5ded-fc41-4a93-9c85-6c59b53d54c8'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','b9b89044-0824-41de-bc6d-4dd752082467'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','ff2c1874-9c5d-43b3-ab78-13467f3135d6'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','fbb52909-1740-49a4-b4b6-cfc3a7e3220c'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','b90f9b3b-67c1-4c0c-af66-5cc029cd61e3'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','dab83e43-e94f-4c3a-8b4c-331fd7683f7c'),(123,NULL,'app','m190109_172845_fix_colspan','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','fd62b34a-d109-4616-bc20-fd89c2771c28'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','de632010-95a8-434e-9e89-e67ed229b2d3'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','daf27c88-40f5-4c6c-8651-1cc4bcc8c947'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','8267cc9a-6318-440c-97ee-5a748ba7e656'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','a9584083-849b-4f1f-b535-a66b1109d038'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d1ec4306-9e70-4deb-bd84-cc7fd8d7767c'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','462c466f-234f-4901-8e45-6a1d0c33b7b1'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','298b31ec-68cd-4355-95b3-8449811ad67f'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','173dc337-2fc9-4368-94e2-ce790db251c7'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','cdd56cf4-2d19-4d1a-b804-1b4630021c2f'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','62c9badb-a8f0-4ff5-8d6b-d31355fdf7ea'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','d4de1e83-104d-4ee4-88ee-568c9c69ce8d'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-09-06 09:04:13','2019-09-06 09:04:13','2019-09-06 09:04:13','0e2c5c04-8b3b-4f13-8107-6667746c2a36'),(136,NULL,'app','m190312_152740_element_revisions','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','8a5a3d66-f2e2-477e-adee-01b3fe5188ef'),(137,NULL,'app','m190327_235137_propagation_method','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','0cba93b7-ed18-492f-a494-110ffb04bd07'),(138,NULL,'app','m190401_223843_drop_old_indexes','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','4085294d-360e-4f59-bba9-43d138bf9f61'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','119f52ba-ccd0-4bae-8155-593f088ad8ee'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','26120dc7-77ff-42c9-9b0f-11547106d7c7'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','682a653e-06b5-44f2-86d0-ae0bd92597c6'),(142,NULL,'app','m190504_150349_preview_targets','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','f448817c-d863-45f3-850c-89ade047b4e6'),(143,NULL,'app','m190516_184711_job_progress_label','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','5614e1f5-e737-4ad7-8cef-a51e68155d55'),(144,NULL,'app','m190523_190303_optional_revision_creators','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','f99cea8c-0b04-4e3f-8d47-0e16cb509796'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-09-06 09:23:08','2019-09-06 09:23:08','2019-09-06 09:23:08','f57e0b70-8951-4900-9061-fe89e7c0bb14'),(146,NULL,'app','m190605_223807_unsaved_drafts','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','d06fee0b-8748-44f4-90fb-ef3afc2ee923'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','8ef8b45d-2036-4349-98fa-479d05f19096'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','9a90d5f6-6c9d-4b99-ad20-49b0647ee2cc'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','ff747fcb-c0a4-4d56-90d5-87b2f6b9f8d9'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','5c07abf4-59d2-452e-af44-cb809d49a912'),(151,NULL,'app','m190711_153020_drop_snapshots','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','8d5518db-a82f-4fa9-932b-7c50f1a96c24'),(152,NULL,'app','m190712_195914_no_draft_revisions','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','214925c9-50f5-492b-8003-65f871704323'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','e474df72-8936-4c65-9cc2-a4ddc8bc8872'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','a8c42daa-0edc-48c1-896e-57e629fd98b2'),(155,NULL,'app','m190823_020339_optional_draft_creators','2019-09-06 09:23:09','2019-09-06 09:23:09','2019-09-06 09:23:09','adeaef8c-a771-49f0-9246-b167d0ce32be');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_queue`
--

LOCK TABLES `craft_queue` WRITE;
/*!40000 ALTER TABLE `craft_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_resourcepaths`
--

LOCK TABLES `craft_resourcepaths` WRITE;
/*!40000 ALTER TABLE `craft_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_resourcepaths` VALUES ('186f6763','@lib/garnishjs'),('22d36c76','@lib/jquery-touch-events'),('2c25f687','@app/web/assets/feed/dist'),('3019b2c','@lib'),('32c941a4','@lib/d3'),('33bf9ce8','@lib/velocity'),('3d9f514a','@lib/fileupload'),('42e156a7','@lib/element-resize-detector'),('49e1179c','@craft/web/assets/craftsupport/dist'),('4b560c3','@lib/jquery.payment'),('563b548e','@lib/jquery-ui'),('6140455a','@app/web/assets/craftsupport/dist'),('6708dfbb','@app/web/assets/cp/dist'),('68524a30','@lib/velocity'),('6fef1b99','@craft/web/assets/feed/dist'),('79ddbd4d','@bower/jquery/dist'),('82133813','@lib/jquery-touch-events'),('85b704d1','@lib/picturefill'),('87ab7189','@app/web/assets/updater/dist'),('8be34ea6','@craft/web/assets/updateswidget/dist'),('8f28c234','@app/web/assets/dashboard/dist'),('91d3856','@bower/jquery/dist'),('97fe23b6','@app/web/assets/updateswidget/dist'),('9e745f0b','@craft/web/assets/recententries/dist'),('9f56f687','@lib/element-resize-detector'),('a109ac4e','@lib/selectize'),('a47534a6','@lib/jquery.payment'),('a94461d8','@app/web/assets/recententries/dist'),('af8e0034','@app/web/assets/editentry/dist'),('b0604d17','@app/web/assets/dbbackup/dist'),('b27ed985','@lib/xregexp'),('c7dc441f','@app/web/assets/editsection/dist'),('cf776669','@lib/timepicker'),('d21e93e8','@lib/fileupload'),('d29b35d','@lib/fabric'),('d67204c4','@app/web/assets/utilities/dist'),('e2a871ff','@lib/fabric'),('e9930f5d','@lib/xregexp'),('eef59480','@lib/garnishjs'),('ef7ee184','@lib/d3'),('f4333804','@craft/web/assets/cp/dist'),('f57781ca','@lib/picturefill'),('f6fb00eb','@lib/jquery-ui'),('fae47a96','@lib/selectize'),('fb70c13','@craft/web/assets/dashboard/dist');
/*!40000 ALTER TABLE `craft_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_revisions`
--

LOCK TABLES `craft_revisions` WRITE;
/*!40000 ALTER TABLE `craft_revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_revisions` VALUES (1,3,1,1,NULL),(2,6,1,1,NULL),(3,9,1,1,NULL);
/*!40000 ALTER TABLE `craft_revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,1,' gieltettelaar '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' giel yellowflash net '),(1,'slug',0,1,''),(3,'slug',0,1,' blog article 1 '),(3,'title',0,1,' blog article 1 '),(6,'slug',0,1,' blog article 2 '),(6,'title',0,1,' blog article 2 '),(9,'slug',0,1,' blog article 3 '),(9,'title',0,1,' blog article 3 ');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections` VALUES (1,NULL,'Blog','blog','channel',1,'all',NULL,'2019-09-06 09:38:19','2019-09-06 09:41:01',NULL,'54239566-8b6a-412c-a35d-e4f5f574c3fa');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections_sites`
--

LOCK TABLES `craft_sections_sites` WRITE;
/*!40000 ALTER TABLE `craft_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections_sites` VALUES (1,1,1,0,NULL,NULL,1,'2019-09-06 09:38:19','2019-09-06 09:41:01','7269d6cf-ff2d-4bee-9688-39190eee38ac');
/*!40000 ALTER TABLE `craft_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sequences`
--

LOCK TABLES `craft_sequences` WRITE;
/*!40000 ALTER TABLE `craft_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sitegroups`
--

LOCK TABLES `craft_sitegroups` WRITE;
/*!40000 ALTER TABLE `craft_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sitegroups` VALUES (1,'Happylager','2019-09-06 09:04:11','2019-09-06 09:04:11',NULL,'d2c8fc19-e330-476c-9fc8-b86dd8452e16');
/*!40000 ALTER TABLE `craft_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sites`
--

LOCK TABLES `craft_sites` WRITE;
/*!40000 ALTER TABLE `craft_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sites` VALUES (1,1,1,'Happylager','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-09-06 09:04:11','2019-09-06 09:04:11',NULL,'cde3602d-b5f5-4190-8f36-ce58b7251dab');
/*!40000 ALTER TABLE `craft_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_systemmessages`
--

LOCK TABLES `craft_systemmessages` WRITE;
/*!40000 ALTER TABLE `craft_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpreferences`
--

LOCK TABLES `craft_userpreferences` WRITE;
/*!40000 ALTER TABLE `craft_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `craft_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_users` VALUES (1,'gieltettelaar',NULL,NULL,NULL,'giel@yellowflash.net','$2y$13$YAdN6Ukg04QuVUjU292Y2ur2uh2xlTSAlC8hqLuYyllCTMixs19ja',1,0,0,0,'2019-09-06 09:04:12',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-09-06 09:04:11','2019-09-06 09:04:11','2019-09-06 09:04:15','84ca39ee-dcb0-4425-87a4-9866fe105533');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumefolders`
--

LOCK TABLES `craft_volumefolders` WRITE;
/*!40000 ALTER TABLE `craft_volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumes`
--

LOCK TABLES `craft_volumes` WRITE;
/*!40000 ALTER TABLE `craft_volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-09-06 09:04:15','2019-09-06 09:04:15','f8ce60aa-89cf-46e9-a92f-2a3784f457f1'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-09-06 09:04:15','2019-09-06 09:04:15','7d547218-1540-45c7-a410-1a8f7f879e83'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-09-06 09:04:15','2019-09-06 09:04:15','4f793a6e-8949-499a-9012-3b035944eb69'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-09-06 09:04:15','2019-09-06 09:04:15','92cddaeb-7f27-4ed9-8ce6-4d67d5326535');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'happylager'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-06  9:43:34
