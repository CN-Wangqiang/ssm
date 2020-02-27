/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : ssmbuild

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 27/02/2020 12:57:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `bookID` int(10) NOT NULL AUTO_INCREMENT COMMENT '书id',
  `bookName` varchar(100) NOT NULL COMMENT '书名',
  `bookCounts` int(11) NOT NULL COMMENT '数量',
  `detail` varchar(200) NOT NULL COMMENT '描述',
  KEY `bookID` (`bookID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of books
-- ----------------------------
BEGIN;
INSERT INTO `books` VALUES (1, 'Java', 2, '从入门到放弃');
INSERT INTO `books` VALUES (2, 'MySQL', 10, '从删库到跑路');
INSERT INTO `books` VALUES (3, 'Linux', 5, '从进门到进牢');
INSERT INTO `books` VALUES (4, 'javascript', 100, '前端');
INSERT INTO `books` VALUES (5, 'html', 4, '美工');
INSERT INTO `books` VALUES (6, 'spring', 2, '框架');
INSERT INTO `books` VALUES (7, 'SpringMVC', 12, '框架');
INSERT INTO `books` VALUES (8, 'Mybatis', 56, 'Mybatis');
INSERT INTO `books` VALUES (9, 'SpringCloud', 3, 'SpringCloud');
INSERT INTO `books` VALUES (10, 'dubbo', 4, 'dubbo');
INSERT INTO `books` VALUES (11, 'Mybatis', 56, 'Mybatis');
INSERT INTO `books` VALUES (12, 'SpringCloud', 3, 'SpringCloud');
INSERT INTO `books` VALUES (13, 'dubbo', 4, 'dubbo');
INSERT INTO `books` VALUES (14, 'Java', 2, '从入门到放弃');
INSERT INTO `books` VALUES (15, 'MySQL', 10, '从删库到跑路');
INSERT INTO `books` VALUES (16, 'Linux', 5, '从进门到进牢');
INSERT INTO `books` VALUES (17, 'javascript', 100, '前端');
INSERT INTO `books` VALUES (18, 'dubbo', 1, '1');
INSERT INTO `books` VALUES (19, 'Java', 2, '从入门到放弃');
INSERT INTO `books` VALUES (20, 'spring', 2, '框架');
INSERT INTO `books` VALUES (21, 'SpringMVC', 12, '框架');
INSERT INTO `books` VALUES (22, 'Mybatis', 56, 'Mybatis');
INSERT INTO `books` VALUES (23, 'SpringCloud', 3, 'SpringCloud');
INSERT INTO `books` VALUES (24, 'dubbo', 4, 'dubbo');
INSERT INTO `books` VALUES (25, 'Mybatis', 56, 'Mybatis');
INSERT INTO `books` VALUES (26, 'SpringCloud', 3, 'SpringCloud');
INSERT INTO `books` VALUES (27, 'dubbo', 4, 'dubbo');
INSERT INTO `books` VALUES (28, 'javascript', 100, '前端');
INSERT INTO `books` VALUES (29, 'html', 4, '美工');
INSERT INTO `books` VALUES (30, 'spring', 2, '框架');
INSERT INTO `books` VALUES (31, 'SpringMVC', 12, '框架');
INSERT INTO `books` VALUES (32, 'Mybatis', 56, 'Mybatis');
INSERT INTO `books` VALUES (33, 'SpringCloud', 3, 'SpringCloud');
INSERT INTO `books` VALUES (34, 'dubbo', 4, 'dubbo');
INSERT INTO `books` VALUES (35, 'Mybatis', 56, 'Mybatis');
INSERT INTO `books` VALUES (36, 'SpringCloud', 3, 'SpringCloud');
INSERT INTO `books` VALUES (37, 'dubbo', 4, 'dubbo');
INSERT INTO `books` VALUES (38, 'MySQL', 10, '从删库到跑路');
INSERT INTO `books` VALUES (39, 'Linux', 5, '从进门到进牢');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
