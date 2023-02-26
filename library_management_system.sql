/*
 Navicat Premium Data Transfer

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 80028 (8.0.28)
 Source Host           : localhost:3306
 Source Schema         : library_management_system

 Target Server Type    : MySQL
 Target Server Version : 80028 (8.0.28)
 File Encoding         : 65001

 Date: 25/02/2023 23:05:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lms_book
-- ----------------------------
DROP TABLE IF EXISTS `lms_book`;
CREATE TABLE `lms_book`  (
  `id` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书发行号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `publishing_house` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `classification_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类编号',
  `publish_date` datetime NULL DEFAULT NULL COMMENT '出版日期',
  `number` int NOT NULL DEFAULT 0 COMMENT '图书被借次数',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书照片',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书内容',
  `library_id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存放的图书馆',
  `place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存放位置',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `state` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否被借（在馆0，不在则为借阅者id）',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `book_classification`(`classification_id` ASC) USING BTREE,
  INDEX `book_library`(`library_id` ASC) USING BTREE,
  CONSTRAINT `book_classification` FOREIGN KEY (`classification_id`) REFERENCES `lms_classification` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `book_library` FOREIGN KEY (`library_id`) REFERENCES `lms_library` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图书信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_book
-- ----------------------------
INSERT INTO `lms_book` VALUES ('1', '《三国演义》', '孙悟空', '09A4NKJXQ2', '2', '2017-12-08 14:39:59', 37, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/%E6%9F%AF%E6%9F%AF%E5%B0%8F%E6%9C%8B%E5%8F%8B%E7%9A%84%E8%AF%BE%E4%BB%B6.pptx', '1', 'E7vz1aUYOB', '4F09U1wFlr', '0', 0, '2020-02-15 19:24:54', '2022-12-12 22:46:22');
INSERT INTO `lms_book` VALUES ('10', '《三国演义》', '猪八戒', 'C3N8Ym5Fp5', '1596863617995685889', '2005-09-02 08:56:14', 859, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/%E8%AF%BE%E7%A8%8B%E8%A1%A8.pdf', '1596897357832667137', '7iZszo8IFv', 'upPaqcjtK7', '1602572892483145729', 0, '2007-07-26 07:47:49', '2022-12-13 20:42:25');
INSERT INTO `lms_book` VALUES ('1597071610611793922', '《三国演义》', '哈哈哈', '鬼知道呢', NULL, NULL, 0, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', NULL, NULL, '没有啥子描述的', '1602572892483145729', 0, NULL, '2022-12-13 20:43:38');
INSERT INTO `lms_book` VALUES ('1602344075038593025', '哈哈哈哈', '哈哈哈哈', '哈哈哈', '2', '2022-12-14 00:00:00', 0, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/c0ad3abdd45d4db3ba7b3b31aec055a2.txt', '1596897357832667137', '哈哈哈哈', '哈哈哈哈哈哈哈', '1602572892483145729', 0, '2022-12-13 00:46:12', '2022-12-21 17:10:07');
INSERT INTO `lms_book` VALUES ('1602344584508116993', '哈哈哈哈', '哈哈哈哈', '哈哈哈哈', '1596863617995685889', '2022-12-14 00:00:00', 0, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1596897357832667137', '哈哈哈哈', '哈哈哈哈哈哈哈', '0', 0, '2022-12-13 00:48:14', '2022-12-21 18:05:44');
INSERT INTO `lms_book` VALUES ('2', '《三国演义》', '罗贯中', 'ntxFErDrTt', '2', '2004-01-30 02:28:12', 650, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1', 'OqatsxmdGY', 'tvPhkCoVxH', '0', 0, '2021-02-14 12:01:11', '2022-12-13 20:38:34');
INSERT INTO `lms_book` VALUES ('3', '《三国演义》', '罗贯中', 'zdbSRV2xLi', '1596863617995685889', '2019-03-17 16:27:05', 242, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1', 'oKTlzLaYXq', 'I9WrTeV2IU', '0', 0, '2020-09-18 01:51:58', '2022-03-07 01:34:05');
INSERT INTO `lms_book` VALUES ('4', '《三国演义》', '罗贯中', '1ZYSB4KB4p', '1596863617995685889', '2004-07-31 15:47:56', 174, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1597060478656348162', 'sRre9CVzp9', 'VAsZ7aKfR1', '0', 0, '2000-08-31 16:34:40', '2022-12-13 16:44:30');
INSERT INTO `lms_book` VALUES ('5', '《三国演义》', '罗贯中', 'TPRqQGe5dS', '1596863617995685889', '2006-01-24 13:45:37', 340, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1', '4fZlzFsyMH', 'WfHq3SFNd9', '0', 0, '2001-03-13 07:40:19', '2022-12-13 16:45:36');
INSERT INTO `lms_book` VALUES ('6', '《三国演义》', '罗贯中', 'DuqKMx64IM', '1596863617995685889', '2002-10-02 04:29:24', 421, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1597060478656348162', 'eYCrr4ZTU7', 'qVMyOtSg4O', '0', 0, '2014-07-09 20:44:44', '2022-12-13 16:50:16');
INSERT INTO `lms_book` VALUES ('7', '《三国演义》', '罗贯中', 'oJEQ27Et96', '2', '2009-07-14 21:09:24', 214, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1596897357832667137', 'jPy7lRClut', '9tFP3kddgP', '0', 0, '2006-02-22 14:43:28', '2022-12-13 16:53:47');
INSERT INTO `lms_book` VALUES ('8', '《三国演义》', '罗贯中', 'xAyQACvwMZ', '1596863617995685889', '2005-03-16 02:20:59', 965, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/aaf51ac432bc426ca0b8bed0f63a2180.mp4', '1597060478656348162', 'knJtOLqUxh', 'EHASXny4rK', '0', 0, '2008-06-30 17:09:39', '2022-12-13 16:48:53');
INSERT INTO `lms_book` VALUES ('9', '《三国演义》', '罗贯中', '0OKt8dmYbl', '2', '2012-09-12 03:07:31', 203, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/picture/2d4baa506c724e809182869f6ceeb7a5.gif', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/book/content/Students.xlsx', '1596897357832667137', 'S45OTeIpIw', 'qj2TU3HMf8', '0', 0, '2012-06-23 00:58:32', '2022-12-13 16:55:02');

-- ----------------------------
-- Table structure for lms_borrow
-- ----------------------------
DROP TABLE IF EXISTS `lms_borrow`;
CREATE TABLE `lms_borrow`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '借阅编号',
  `user_id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外键',
  `book_id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键',
  `borrow_date` datetime NULL DEFAULT NULL COMMENT '借阅日期',
  `limit` int NULL DEFAULT 30 COMMENT '可借时长',
  `return_date` datetime NULL DEFAULT NULL COMMENT '归还日期',
  `violation_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '违规描述',
  `handler` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理人',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `borrow_book_id`(`book_id` ASC) USING BTREE,
  INDEX `borrow_handler_id`(`handler` ASC) USING BTREE,
  INDEX `borrow_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `borrow_book_id` FOREIGN KEY (`book_id`) REFERENCES `lms_book` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `borrow_handler_id` FOREIGN KEY (`handler`) REFERENCES `lms_user_auth` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `borrow_user_id` FOREIGN KEY (`user_id`) REFERENCES `lms_user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借阅信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_borrow
-- ----------------------------
INSERT INTO `lms_borrow` VALUES ('1602645110487568386', '1602572892483145729', '10', '2022-12-13 20:42:25', 60, '2022-12-13 20:43:23', NULL, NULL, 1, '2022-12-13 20:42:25', '2022-12-13 20:43:23');
INSERT INTO `lms_borrow` VALUES ('1602645419981066241', '1602572892483145729', '1597071610611793922', '2022-12-13 20:43:39', 30, '2022-12-13 20:45:27', NULL, NULL, 0, '2022-12-13 20:43:39', '2022-12-13 20:46:09');
INSERT INTO `lms_borrow` VALUES ('1602647057693200385', '1602572892483145729', '1602344075038593025', '2022-12-13 20:50:09', 60, '2022-12-13 20:52:13', NULL, NULL, 1, '2022-12-13 20:50:09', '2022-12-13 23:27:57');
INSERT INTO `lms_borrow` VALUES ('1602701020782153729', '1602572892483145729', '1602344584508116993', '2022-12-14 00:24:35', 60, '2022-12-21 17:11:20', '哈哈哈', NULL, 0, '2022-12-14 00:24:35', '2022-12-21 17:11:20');
INSERT INTO `lms_borrow` VALUES ('1605490786875555842', '1602572892483145729', '1602344075038593025', '2022-12-21 17:10:07', 30, NULL, '该书已经超时！', NULL, 0, '2022-12-21 17:10:07', '2023-02-25 22:32:29');
INSERT INTO `lms_borrow` VALUES ('1605504783494496258', '1602572892483145729', '1602344584508116993', '2022-12-21 18:05:44', 60, '2022-12-21 18:06:39', NULL, NULL, 0, '2022-12-21 18:05:44', '2022-12-21 18:06:39');

-- ----------------------------
-- Table structure for lms_classification
-- ----------------------------
DROP TABLE IF EXISTS `lms_classification`;
CREATE TABLE `lms_classification`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类id',
  `classification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类描述',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图书分类信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_classification
-- ----------------------------
INSERT INTO `lms_classification` VALUES ('1', '工学', '计算机、机械', 0, '2022-11-27 15:39:26', '2022-11-27 21:49:21');
INSERT INTO `lms_classification` VALUES ('1596863617995685889', '文学', '人文社科等', 0, '2022-11-27 21:48:49', '2022-11-27 21:49:04');
INSERT INTO `lms_classification` VALUES ('1600167374078660610', '语言', '哈哈哈哈哈，英语好难啊', 0, '2022-12-07 00:36:46', '2022-12-07 00:36:46');
INSERT INTO `lms_classification` VALUES ('2', '史学', '历史，不包含计算机，但是包括政治', 0, '2022-11-27 15:39:26', '2022-11-27 21:49:21');

-- ----------------------------
-- Table structure for lms_library
-- ----------------------------
DROP TABLE IF EXISTS `lms_library`;
CREATE TABLE `lms_library`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书馆id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `principal` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `network` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '官网',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '介绍',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图书馆信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_library
-- ----------------------------
INSERT INTO `lms_library` VALUES ('1', '余家头图书馆', '白骨精', '120', 'http://lib.wut.edu.cn/', '哈哈哈哈憨憨', '广埠屯', 0, NULL, '2022-11-28 10:50:31');
INSERT INTO `lms_library` VALUES ('1596897357832667137', '南湖图书馆', '奥特曼', '110', 'http://lib.whut.edu.cn/', '哈哈哈道德划等号', '珞狮路', 0, '2022-11-28 00:02:54', '2022-11-28 00:02:54');
INSERT INTO `lms_library` VALUES ('1597060478656348162', '111111111111', '111111111111111', '11111111', '1111111111', '111111111111111', '11111111111', 0, '2022-11-28 10:51:05', '2022-11-28 10:51:23');

-- ----------------------------
-- Table structure for lms_permission
-- ----------------------------
DROP TABLE IF EXISTS `lms_permission`;
CREATE TABLE `lms_permission`  (
  `id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '编号',
  `pid` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '所属上级',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '类型(1:菜单,2:按钮)',
  `permission_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限值',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问路径',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
  `is_deleted` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_pid`(`pid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_permission
-- ----------------------------
INSERT INTO `lms_permission` VALUES ('1', '0', '全部数据', 0, NULL, NULL, NULL, NULL, NULL, 0, '2019-11-15 17:13:06', '2019-11-15 17:13:06');
INSERT INTO `lms_permission` VALUES ('1195268474480156673', '1', '权限管理', 1, NULL, '/acl', 'Layout', NULL, NULL, 0, '2019-11-15 17:13:06', '2019-11-18 13:54:25');
INSERT INTO `lms_permission` VALUES ('1195268616021139457', '1195268474480156673', '用户管理', 1, NULL, 'user/list', '/acl/user/list', NULL, NULL, 0, '2019-11-15 17:13:40', '2019-11-18 13:53:12');
INSERT INTO `lms_permission` VALUES ('1195268788138598401', '1195268474480156673', '角色管理', 1, NULL, 'role/list', '/acl/role/list', NULL, NULL, 0, '2019-11-15 17:14:21', '2019-11-15 17:14:21');
INSERT INTO `lms_permission` VALUES ('1195268893830864898', '1195268474480156673', '菜单管理', 1, NULL, 'menu/list', '/acl/menu/list', NULL, NULL, 0, '2019-11-15 17:14:46', '2019-11-15 17:14:46');
INSERT INTO `lms_permission` VALUES ('1195269143060602882', '1195268616021139457', '查看', 2, 'user.list', '', '', NULL, NULL, 0, '2019-11-15 17:15:45', '2019-11-17 21:57:16');
INSERT INTO `lms_permission` VALUES ('1195269295926206466', '1195268616021139457', '添加', 2, 'user.add', 'user/add', '/acl/user/form', NULL, NULL, 0, '2019-11-15 17:16:22', '2019-11-15 17:16:22');
INSERT INTO `lms_permission` VALUES ('1195269473479483394', '1195268616021139457', '修改', 2, 'user.update', 'user/update/:id', '/acl/user/form', NULL, NULL, 0, '2019-11-15 17:17:04', '2019-11-15 17:17:04');
INSERT INTO `lms_permission` VALUES ('1195269547269873666', '1195268616021139457', '删除', 2, 'user.remove', '', '', NULL, NULL, 0, '2019-11-15 17:17:22', '2019-11-15 17:17:22');
INSERT INTO `lms_permission` VALUES ('1195269821262782465', '1195268788138598401', '修改', 2, 'role.update', 'role/update/:id', '/acl/role/form', NULL, NULL, 0, '2019-11-15 17:18:27', '2019-11-15 17:19:53');
INSERT INTO `lms_permission` VALUES ('1195269903542444034', '1195268788138598401', '查看', 2, 'role.list', '', '', NULL, NULL, 0, '2019-11-15 17:18:47', '2019-11-15 17:18:47');
INSERT INTO `lms_permission` VALUES ('1195270037005197313', '1195268788138598401', '添加', 2, 'role.add', 'role/add', '/acl/role/form', NULL, NULL, 0, '2019-11-15 17:19:19', '2019-11-18 11:05:42');
INSERT INTO `lms_permission` VALUES ('1195270442602782721', '1195268788138598401', '删除', 2, 'role.remove', '', '', NULL, NULL, 0, '2019-11-15 17:20:55', '2019-11-15 17:20:55');
INSERT INTO `lms_permission` VALUES ('1195270621548568578', '1195268788138598401', '角色权限', 2, 'role.acl', 'role/distribution/:id', '/acl/role/roleForm', NULL, NULL, 0, '2019-11-15 17:21:38', '2019-11-15 17:21:38');
INSERT INTO `lms_permission` VALUES ('1195270744097742849', '1195268893830864898', '查看', 2, 'permission.list', '', '', NULL, NULL, 0, '2019-11-15 17:22:07', '2019-11-15 17:22:07');
INSERT INTO `lms_permission` VALUES ('1195270810560684034', '1195268893830864898', '添加', 2, 'permission.add', '', '', NULL, NULL, 0, '2019-11-15 17:22:23', '2019-11-15 17:22:23');
INSERT INTO `lms_permission` VALUES ('1195270862100291586', '1195268893830864898', '修改', 2, 'permission.update', '', '', NULL, NULL, 0, '2019-11-15 17:22:35', '2019-11-15 17:22:35');
INSERT INTO `lms_permission` VALUES ('1195270887933009922', '1195268893830864898', '删除', 2, 'permission.remove', '', '', NULL, NULL, 0, '2019-11-15 17:22:41', '2019-11-15 17:22:41');
INSERT INTO `lms_permission` VALUES ('1195349439240048642', '1', '学生管理', 1, NULL, '/lms/student', 'Layout', NULL, NULL, 0, '2019-11-15 22:34:49', '2022-11-28 14:46:06');
INSERT INTO `lms_permission` VALUES ('1195349699995734017', '1195349439240048642', '学生列表', 1, NULL, 'list', '/lms/student/list', NULL, NULL, 0, '2019-11-15 22:35:52', '2022-11-28 14:47:05');
INSERT INTO `lms_permission` VALUES ('1195349810561781761', '1195349439240048642', '导入学生', 1, NULL, 'import', '/lms/student/import', NULL, NULL, 1, '2019-11-15 22:36:18', '2022-12-13 21:59:14');
INSERT INTO `lms_permission` VALUES ('1195349876252971010', '1195349810561781761', '添加', 2, 'teacher.add', '', '', NULL, NULL, 0, '2019-11-15 22:36:34', '2019-11-15 22:36:34');
INSERT INTO `lms_permission` VALUES ('1195349979797753857', '1195349699995734017', '查看', 2, 'student.list', '', '', NULL, NULL, 0, '2019-11-15 22:36:58', '2022-11-28 14:47:57');
INSERT INTO `lms_permission` VALUES ('1195350117270261762', '1195349699995734017', '修改', 2, 'student.update', 'update/:id', '/lms/student/form', NULL, NULL, 0, '2019-11-15 22:37:31', '2022-12-05 21:15:21');
INSERT INTO `lms_permission` VALUES ('1195350188359520258', '1195349699995734017', '删除', 2, 'student.remove', '', '', NULL, NULL, 0, '2019-11-15 22:37:48', '2022-11-28 14:47:19');
INSERT INTO `lms_permission` VALUES ('1195350299365969922', '1', '课程分类', 1, NULL, '/edu/subject', 'Layout', NULL, NULL, 1, '2019-11-15 22:38:15', '2022-11-28 15:33:22');
INSERT INTO `lms_permission` VALUES ('1195350397751758850', '1195350299365969922', '课程分类列表', 1, NULL, 'list', '/edu/subject/list', NULL, NULL, 0, '2019-11-15 22:38:38', '2019-11-15 22:38:38');
INSERT INTO `lms_permission` VALUES ('1195350500512206850', '1195350299365969922', '导入课程分类', 1, NULL, 'import', '/edu/subject/import', NULL, NULL, 0, '2019-11-15 22:39:03', '2019-11-15 22:39:03');
INSERT INTO `lms_permission` VALUES ('1195350612172967938', '1195350397751758850', '查看', 2, 'subject.list', '', '', NULL, NULL, 0, '2019-11-15 22:39:29', '2019-11-15 22:39:29');
INSERT INTO `lms_permission` VALUES ('1195350687590748161', '1195350500512206850', '导入', 2, 'subject.import', '', '', NULL, NULL, 0, '2019-11-15 22:39:47', '2019-11-15 22:39:47');
INSERT INTO `lms_permission` VALUES ('1195350831744782337', '1', '课程管理', 1, NULL, '/edu/course', 'Layout', NULL, NULL, 1, '2019-11-15 22:40:21', '2022-11-28 15:33:26');
INSERT INTO `lms_permission` VALUES ('1195350919074385921', '1195350831744782337', '课程列表', 1, NULL, 'list', '/edu/course/list', NULL, NULL, 0, '2019-11-15 22:40:42', '2019-11-15 22:40:42');
INSERT INTO `lms_permission` VALUES ('1195351020463296513', '1195350831744782337', '发布课程', 1, NULL, 'info', '/edu/course/info', NULL, NULL, 0, '2019-11-15 22:41:06', '2019-11-15 22:41:06');
INSERT INTO `lms_permission` VALUES ('1195351159672246274', '1195350919074385921', '完成发布', 2, 'course.publish', 'publish/:id', '/edu/course/publish', NULL, NULL, 0, '2019-11-15 22:41:40', '2019-11-15 22:44:01');
INSERT INTO `lms_permission` VALUES ('1195351326706208770', '1195350919074385921', '编辑课程', 2, 'course.update', 'info/:id', '/edu/course/info', NULL, NULL, 0, '2019-11-15 22:42:19', '2019-11-15 22:42:19');
INSERT INTO `lms_permission` VALUES ('1195351566221938690', '1195350919074385921', '编辑课程大纲', 2, 'chapter.update', 'chapter/:id', '/edu/course/chapter', NULL, NULL, 0, '2019-11-15 22:43:17', '2019-11-15 22:43:17');
INSERT INTO `lms_permission` VALUES ('1195351862889254913', '1', '统计分析', 1, NULL, '/statistics/daily', 'Layout', NULL, NULL, 0, '2019-11-15 22:44:27', '2019-11-15 22:44:27');
INSERT INTO `lms_permission` VALUES ('1195351968841568257', '1195351862889254913', '生成统计', 1, NULL, 'create', '/statistics/daily/create', NULL, NULL, 0, '2019-11-15 22:44:53', '2019-11-15 22:44:53');
INSERT INTO `lms_permission` VALUES ('1195352054917074946', '1195351862889254913', '统计图表', 1, NULL, 'chart', '/statistics/daily/chart', NULL, NULL, 0, '2019-11-15 22:45:13', '2019-11-15 22:45:13');
INSERT INTO `lms_permission` VALUES ('1195352127734386690', '1195352054917074946', '查看', 2, 'daily.list', '', '', NULL, NULL, 0, '2019-11-15 22:45:30', '2019-11-15 22:45:30');
INSERT INTO `lms_permission` VALUES ('1195352215768633346', '1195351968841568257', '生成', 2, 'daily.add', '', '', NULL, NULL, 0, '2019-11-15 22:45:51', '2019-11-15 22:45:51');
INSERT INTO `lms_permission` VALUES ('1195352547621965825', '1', 'CMS管理', 1, NULL, '/cms', 'Layout', NULL, NULL, 1, '2019-11-15 22:47:11', '2022-11-28 15:33:30');
INSERT INTO `lms_permission` VALUES ('1195352856645701633', '1195353513549205505', '查看', 2, 'banner.list', '', NULL, NULL, NULL, 0, '2019-11-15 22:48:24', '2019-11-15 22:48:24');
INSERT INTO `lms_permission` VALUES ('1195352909401657346', '1195353513549205505', '添加', 2, 'banner.add', 'banner/add', '/cms/banner/form', NULL, NULL, 0, '2019-11-15 22:48:37', '2019-11-18 10:52:10');
INSERT INTO `lms_permission` VALUES ('1195353051395624961', '1195353513549205505', '修改', 2, 'banner.update', 'banner/update/:id', '/cms/banner/form', NULL, NULL, 0, '2019-11-15 22:49:11', '2019-11-18 10:52:05');
INSERT INTO `lms_permission` VALUES ('1195353513549205505', '1195352547621965825', 'Bander列表', 1, NULL, 'banner/list', '/cms/banner/list', NULL, NULL, 0, '2019-11-15 22:51:01', '2019-11-18 10:51:29');
INSERT INTO `lms_permission` VALUES ('1195353672110673921', '1195353513549205505', '删除', 2, 'banner.remove', '', '', NULL, NULL, 0, '2019-11-15 22:51:39', '2019-11-15 22:51:39');
INSERT INTO `lms_permission` VALUES ('1195354076890370050', '1', '订单管理', 1, NULL, '/order', 'Layout', NULL, NULL, 0, '2019-11-15 22:53:15', '2022-11-28 10:52:37');
INSERT INTO `lms_permission` VALUES ('1195354153482555393', '1195354076890370050', '订单列表', 1, NULL, 'list', '/order/list', NULL, NULL, 0, '2019-11-15 22:53:33', '2019-11-15 22:53:58');
INSERT INTO `lms_permission` VALUES ('1195354315093282817', '1195354153482555393', '查看', 2, 'order.list', '', '', NULL, NULL, 0, '2019-11-15 22:54:12', '2019-11-15 22:54:12');
INSERT INTO `lms_permission` VALUES ('1196301740985311234', '1195268616021139457', '分配角色', 2, 'user.assgin', 'user/role/:id', '/acl/user/roleForm', NULL, NULL, 0, '2019-11-18 13:38:56', '2019-11-18 13:38:56');
INSERT INTO `lms_permission` VALUES ('1596302389128777729', '1', '学生管理', 1, NULL, '/student', 'Layout', NULL, NULL, 1, '2022-11-26 08:38:42', '2022-11-26 08:45:44');
INSERT INTO `lms_permission` VALUES ('1596303771948863490', '1596302389128777729', '学生列表', 1, NULL, 'list', '/student/list', NULL, NULL, 1, '2022-11-26 08:44:12', '2022-11-26 08:45:41');
INSERT INTO `lms_permission` VALUES ('1596304017957376002', '1596303771948863490', '查看', 2, 'student.list', '', '', NULL, NULL, 1, '2022-11-26 08:45:10', '2022-11-26 08:45:33');
INSERT INTO `lms_permission` VALUES ('1596681480323506178', '1', '分类管理', 1, NULL, '/lms/classification', 'Layout', NULL, NULL, 0, '2022-11-27 09:45:04', '2022-11-27 23:21:31');
INSERT INTO `lms_permission` VALUES ('1596682252276768770', '1596681480323506178', '导入图书分类', 1, NULL, 'import', '/lms/classification/import', NULL, NULL, 1, '2022-11-27 09:48:09', '2022-12-13 21:54:32');
INSERT INTO `lms_permission` VALUES ('1596682459521523714', '1596681480323506178', '图书分类列表', 1, NULL, 'list', '/lms/classification/list', NULL, NULL, 0, '2022-11-27 09:48:58', '2022-11-27 09:48:58');
INSERT INTO `lms_permission` VALUES ('1596682719413182466', '1596682459521523714', '查看', 2, 'classification.list', '', '', NULL, NULL, 0, '2022-11-27 09:50:00', '2022-11-27 17:24:14');
INSERT INTO `lms_permission` VALUES ('1596823997211738113', '1596682459521523714', '添加', 2, 'classification.add', 'add', '/lms/classification/form', NULL, NULL, 0, '2022-11-27 19:11:23', '2022-11-27 19:41:47');
INSERT INTO `lms_permission` VALUES ('1596852727548215298', '1596682459521523714', '批量添加', 2, 'classification.save', 'save', '/lms/classification/add', NULL, NULL, 0, '2022-11-27 21:05:33', '2022-11-27 21:19:28');
INSERT INTO `lms_permission` VALUES ('1596856561142071297', '1596682459521523714', '修改', 2, 'classification.update', 'update/:id', '/lms/classification/form', NULL, NULL, 0, '2022-11-27 21:20:47', '2022-11-27 21:20:47');
INSERT INTO `lms_permission` VALUES ('1596885995953881090', '1', '图书馆管理', 1, NULL, '/lms/library', 'Layout', NULL, NULL, 0, '2022-11-27 23:17:45', '2022-11-27 23:17:45');
INSERT INTO `lms_permission` VALUES ('1596886336971767809', '1596885995953881090', '图书馆列表', 1, NULL, 'list', '/lms/library/list', NULL, NULL, 0, '2022-11-27 23:19:06', '2022-11-27 23:19:06');
INSERT INTO `lms_permission` VALUES ('1596886477929742338', '1596886336971767809', '查看', 2, 'library.list', '', '', NULL, NULL, 0, '2022-11-27 23:19:40', '2022-11-27 23:19:40');
INSERT INTO `lms_permission` VALUES ('1596886788631199746', '1596885995953881090', '导入图书馆', 1, NULL, 'import', '/lms/library/import', NULL, NULL, 1, '2022-11-27 23:20:54', '2022-12-13 21:56:03');
INSERT INTO `lms_permission` VALUES ('1596890622678040577', '1596886336971767809', '添加', 2, 'library.add', 'add', '/lms/library/form', NULL, NULL, 0, '2022-11-27 23:36:08', '2022-11-27 23:49:37');
INSERT INTO `lms_permission` VALUES ('1596890892979961857', '1596886336971767809', '修改', 2, 'library.update', 'update/:id', '/lms/library/form', NULL, NULL, 0, '2022-11-27 23:37:12', '2022-11-27 23:37:12');
INSERT INTO `lms_permission` VALUES ('1596891114233692162', '1596682459521523714', '删除', 2, 'classification.remove', '', '', NULL, NULL, 0, '2022-11-27 23:38:05', '2022-11-27 23:38:05');
INSERT INTO `lms_permission` VALUES ('1596891217249992705', '1596886336971767809', '删除', 2, 'library.remove', '', '', NULL, NULL, 0, '2022-11-27 23:38:30', '2022-11-27 23:38:30');
INSERT INTO `lms_permission` VALUES ('1597064358324621314', '1', '书籍管理', 1, NULL, '/lms/book', 'Layout', NULL, NULL, 0, '2022-11-28 11:06:30', '2022-11-28 11:06:30');
INSERT INTO `lms_permission` VALUES ('1597064636495056898', '1597064358324621314', '导入图书', 1, NULL, 'import', '/lms/book/import', NULL, NULL, 1, '2022-11-28 11:07:36', '2022-12-13 21:51:06');
INSERT INTO `lms_permission` VALUES ('1597064762626166785', '1597064358324621314', '书籍列表', 1, NULL, 'list', '/lms/book/list', NULL, NULL, 0, '2022-11-28 11:08:06', '2022-11-28 11:08:06');
INSERT INTO `lms_permission` VALUES ('1597064895212310529', '1597064762626166785', '查看', 2, 'book.list', '', '', NULL, NULL, 0, '2022-11-28 11:08:38', '2022-11-28 11:08:38');
INSERT INTO `lms_permission` VALUES ('1597065053765390338', '1597064762626166785', '添加', 2, 'book.add', 'add', '/lms/book/form', NULL, NULL, 0, '2022-11-28 11:09:16', '2022-11-28 11:09:16');
INSERT INTO `lms_permission` VALUES ('1597065155603091457', '1597064762626166785', '删除', 2, 'book.remove', '', '', NULL, NULL, 0, '2022-11-28 11:09:40', '2022-11-28 11:09:40');
INSERT INTO `lms_permission` VALUES ('1597065349518348290', '1597064762626166785', '修改', 2, 'book.update', 'update/:id', '/lms/book/form', NULL, NULL, 0, '2022-11-28 11:10:26', '2022-11-28 11:10:26');
INSERT INTO `lms_permission` VALUES ('1597129500584333313', '1', '借阅管理', 1, NULL, '/lms/borrow', 'Layout', NULL, NULL, 0, '2022-11-28 15:25:21', '2022-11-28 15:31:41');
INSERT INTO `lms_permission` VALUES ('1597129804734287873', '1597129500584333313', '借阅记录', 1, NULL, 'list', '/lms/borrow/list', NULL, NULL, 0, '2022-11-28 15:26:33', '2022-11-28 15:27:26');
INSERT INTO `lms_permission` VALUES ('1597129902935527425', '1597129804734287873', '查看', 2, 'borrow.list', '', '', NULL, NULL, 0, '2022-11-28 15:26:57', '2022-11-28 15:26:57');
INSERT INTO `lms_permission` VALUES ('1597130412463771650', '1597129500584333313', '借阅处理', 1, NULL, 'list', '/lms/borrow/list', NULL, NULL, 1, '2022-11-28 15:28:58', '2022-12-13 22:12:23');
INSERT INTO `lms_permission` VALUES ('1598138066325749762', '1', '用户访问', 1, NULL, '/visit', 'Layout', NULL, NULL, 0, '2022-12-01 10:13:02', '2022-12-01 10:14:58');
INSERT INTO `lms_permission` VALUES ('1598138752383860737', '1598138066325749762', '借阅', 1, NULL, 'borrow', '/visit/main', NULL, NULL, 0, '2022-12-01 10:15:45', '2022-12-05 09:25:17');
INSERT INTO `lms_permission` VALUES ('1598138864896065537', '1598138752383860737', '查看', 2, 'visit.list', '', '', NULL, NULL, 0, '2022-12-01 10:16:12', '2022-12-01 10:16:12');
INSERT INTO `lms_permission` VALUES ('1598145218876555266', '1', '借阅历史', 1, NULL, '/record', 'Layout', NULL, NULL, 0, '2022-12-01 10:41:27', '2022-12-01 10:43:11');
INSERT INTO `lms_permission` VALUES ('1598145451652038658', '1598145218876555266', '借阅列表', 1, NULL, 'list', '/visit/record', NULL, NULL, 0, '2022-12-01 10:42:22', '2022-12-01 10:42:22');
INSERT INTO `lms_permission` VALUES ('1598145545294069761', '1598145451652038658', '查看', 2, 'record.list', '', '', NULL, NULL, 0, '2022-12-01 10:42:45', '2022-12-01 10:42:45');
INSERT INTO `lms_permission` VALUES ('1598145819232452609', '1', '用户中心', 1, NULL, '/usercenter', 'Layout', NULL, NULL, 0, '2022-12-01 10:43:50', '2022-12-01 10:43:50');
INSERT INTO `lms_permission` VALUES ('1598146693153439745', '1598145819232452609', '个人中心', 1, NULL, 'usercenter', '/visit/usercenter/info', NULL, NULL, 0, '2022-12-01 10:47:18', '2022-12-02 09:34:46');
INSERT INTO `lms_permission` VALUES ('1598146830424621057', '1598146693153439745', '查看', 2, 'usercenter.info', '', '', NULL, NULL, 0, '2022-12-01 10:47:51', '2022-12-02 09:34:01');
INSERT INTO `lms_permission` VALUES ('1598491317621542914', '1598146693153439745', '修改', 2, 'userinfo.update', 'update/:id', '/visit/usercenter/form', NULL, NULL, 0, '2022-12-02 09:36:43', '2022-12-02 09:36:43');
INSERT INTO `lms_permission` VALUES ('1598491452795572225', '1598146693153439745', '添加', 2, 'userinfo.add', 'add', '/visit/usercenter/form', NULL, NULL, 0, '2022-12-02 09:37:16', '2022-12-02 09:37:16');
INSERT INTO `lms_permission` VALUES ('1599673819673513986', '1195349699995734017', '添加', 2, 'student.add', 'add', '/lms/student/form', NULL, NULL, 0, '2022-12-05 15:55:34', '2022-12-05 15:55:34');
INSERT INTO `lms_permission` VALUES ('1600037630049816578', '1597064762626166785', '详细', 2, 'book.detail', 'detail/:id', '/lms/book/detail', NULL, NULL, 0, '2022-12-06 16:01:13', '2022-12-06 16:03:19');
INSERT INTO `lms_permission` VALUES ('1602624222178435073', '1598145451652038658', '续借', 2, 'book.renew', '', '', NULL, NULL, 0, '2022-12-13 19:19:25', '2022-12-13 19:22:46');
INSERT INTO `lms_permission` VALUES ('1602624711423025153', '1598145451652038658', '归还', 2, 'book.return', '', '', NULL, NULL, 0, '2022-12-13 19:21:21', '2022-12-13 19:26:26');
INSERT INTO `lms_permission` VALUES ('1602667848166064130', '1597129804734287873', '添加', 2, 'borrow.add', '', '', NULL, NULL, 0, '2022-12-13 22:12:46', '2022-12-13 22:12:46');
INSERT INTO `lms_permission` VALUES ('1602667925563555841', '1597129804734287873', '删除', 2, 'borrow.remove', '', '', NULL, NULL, 0, '2022-12-13 22:13:04', '2022-12-13 22:13:04');
INSERT INTO `lms_permission` VALUES ('1602668002600337409', '1597129804734287873', '导出', 2, 'borrow.download', '', '', NULL, NULL, 0, '2022-12-13 22:13:23', '2022-12-13 22:13:23');
INSERT INTO `lms_permission` VALUES ('1602668349754490882', '1597129804734287873', '修改', 2, 'borrow.update', '', '', NULL, NULL, 0, '2022-12-13 22:14:45', '2022-12-13 22:14:45');
INSERT INTO `lms_permission` VALUES ('1602668561952718850', '1597129804734287873', '详情', 2, 'borrow.detail', '', '', NULL, NULL, 0, '2022-12-13 22:15:36', '2022-12-13 22:15:36');
INSERT INTO `lms_permission` VALUES ('1602676164258705410', '1', '图书', 1, NULL, '/visit/book', 'Layout', NULL, NULL, 0, '2022-12-13 22:45:49', '2022-12-13 22:56:52');
INSERT INTO `lms_permission` VALUES ('1602677070589079554', '1602676164258705410', '图书列表', 1, NULL, 'list', '/visit/book/list', NULL, NULL, 0, '2022-12-13 22:49:25', '2022-12-13 22:49:25');
INSERT INTO `lms_permission` VALUES ('1602677180395958273', '1602677070589079554', '查看', 2, 'visit.book.list', '', '', NULL, NULL, 0, '2022-12-13 22:49:51', '2022-12-13 22:49:51');
INSERT INTO `lms_permission` VALUES ('1602677624706969602', '1602677070589079554', '详情', 2, 'visit.book.detail', 'detail/:id', '/visit/book/detail', NULL, NULL, 0, '2022-12-13 22:51:37', '2022-12-13 22:56:24');

-- ----------------------------
-- Table structure for lms_role
-- ----------------------------
DROP TABLE IF EXISTS `lms_role`;
CREATE TABLE `lms_role`  (
  `id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '角色id',
  `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_deleted` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_role
-- ----------------------------
INSERT INTO `lms_role` VALUES ('1', '系统管理员', '1', '1', 0, '2019-11-11 13:09:32', '2022-11-24 22:45:02');
INSERT INTO `lms_role` VALUES ('1193757683205607426', '普通管理员', '2', '1', 0, '2019-11-11 13:09:32', '2022-11-24 22:45:06');
INSERT INTO `lms_role` VALUES ('1595778206288355330', 'test', 'ACD', '1', 0, '2019-11-11 13:09:32', '2022-11-24 22:45:19');

-- ----------------------------
-- Table structure for lms_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `lms_role_permission`;
CREATE TABLE `lms_role_permission`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role_id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `permission_id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `is_deleted` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_permission_id`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `permission_role_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `lms_permission` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `permission_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `lms_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_role_permission
-- ----------------------------
INSERT INTO `lms_role_permission` VALUES ('1196301979754455041', '1', '1', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301979792203778', '1', '1195268474480156673', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301979821563906', '1', '1195268616021139457', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301979842535426', '1', '1195269143060602882', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301979855118338', '1', '1195269295926206466', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301979880284161', '1', '1195269473479483394', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301979913838593', '1', '1195269547269873666', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301979926421506', '1', '1196301740985311234', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301979951587330', '1', '1195268788138598401', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980014501889', '1', '1195269821262782465', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301980035473410', '1', '1195269903542444034', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301980052250626', '1', '1195270037005197313', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301980077416450', '1', '1195270442602782721', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301980094193665', '1', '1195270621548568578', 1, '2019-11-18 13:39:53', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1196301980119359489', '1', '1195268893830864898', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980136136706', '1', '1195270744097742849', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980249382913', '1', '1195270810560684034', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980270354434', '1', '1195270862100291586', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980287131649', '1', '1195270887933009922', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980303908866', '1', '1195349439240048642', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980320686082', '1', '1195349699995734017', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980345851905', '1', '1195349979797753857', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980362629121', '1', '1195350117270261762', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980383600641', '1', '1195350188359520258', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980408766465', '1', '1195349810561781761', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980421349378', '1', '1195349876252971010', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980438126593', '1', '1195350299365969922', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980450709506', '1', '1195350397751758850', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980501041153', '1', '1195350612172967938', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980517818370', '1', '1195350500512206850', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980538789889', '1', '1195350687590748161', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980622675970', '1', '1195350831744782337', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980639453186', '1', '1195350919074385921', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980660424705', '1', '1195351159672246274', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980677201922', '1', '1195351326706208770', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980698173441', '1', '1195351566221938690', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980714950658', '1', '1195351020463296513', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980723339266', '1', '1195351862889254913', 1, '2019-11-18 13:39:53', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1196301980744310786', '1', '1195351968841568257', 1, '2019-11-18 13:39:53', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1196301980761088001', '1', '1195352215768633346', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980777865217', '1', '1195352054917074946', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980794642434', '1', '1195352127734386690', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980811419650', '1', '1195352547621965825', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980828196865', '1', '1195353513549205505', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980844974082', '1', '1195352856645701633', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980861751298', '1', '1195352909401657346', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980886917122', '1', '1195353051395624961', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980928860162', '1', '1195353672110673921', 1, '2019-11-18 13:39:53', '2019-11-18 13:39:53');
INSERT INTO `lms_role_permission` VALUES ('1196301980954025986', '1', '1195354076890370050', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980970803201', '1', '1195354153482555393', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1196301980987580418', '1', '1195354315093282817', 0, '2019-11-18 13:39:53', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413634', '1', '1', 0, '2022-11-27 21:10:00', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413635', '1', '1596681480323506178', 1, '2022-11-27 21:10:00', '2022-11-27 21:10:00');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413636', '1', '1596682252276768770', 1, '2022-11-27 21:10:00', '2022-11-27 21:10:00');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413637', '1', '1596682459521523714', 1, '2022-11-27 21:10:00', '2022-11-27 21:10:00');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413638', '1', '1596682719413182466', 0, '2022-11-27 21:10:00', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413639', '1', '1596823997211738113', 0, '2022-11-27 21:10:00', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1596853846521413640', '1', '1596852727548215298', 0, '2022-11-27 21:10:00', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717377', '1', '1195269547269873666', 1, '2022-12-13 23:09:02', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717378', '1', '1196301740985311234', 1, '2022-12-13 23:09:02', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717379', '1', '1195268788138598401', 1, '2022-12-13 23:09:02', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717380', '1', '1195268893830864898', 1, '2022-12-13 23:09:02', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717381', '1', '1195352215768633346', 1, '2022-12-13 23:09:02', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717382', '1', '1195352054917074946', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717383', '1', '1596885995953881090', 1, '2022-12-13 23:09:02', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717384', '1', '1596886336971767809', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717385', '1', '1596886477929742338', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717386', '1', '1596890622678040577', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717387', '1', '1596890892979961857', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717388', '1', '1596891217249992705', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717389', '1', '1597064358324621314', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717390', '1', '1597064762626166785', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717391', '1', '1597064895212310529', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717392', '1', '1597065053765390338', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717393', '1', '1597065155603091457', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717394', '1', '1597065349518348290', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717395', '1', '1600037630049816578', 1, '2022-12-13 23:09:02', '2022-12-13 23:09:02');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717396', '1', '1597129500584333313', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717397', '1', '1597129804734287873', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717398', '1', '1597129902935527425', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717399', '1', '1602667848166064130', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717400', '1', '1602667925563555841', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717401', '1', '1602668002600337409', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717402', '1', '1602668349754490882', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682010367717403', '1', '1602668561952718850', 0, '2022-12-13 23:09:02', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098561', '1595778206288355330', '1', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098562', '1595778206288355330', '1598138066325749762', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098563', '1595778206288355330', '1598138752383860737', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098564', '1595778206288355330', '1598138864896065537', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098565', '1595778206288355330', '1598145218876555266', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098566', '1595778206288355330', '1598145451652038658', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098567', '1595778206288355330', '1598145545294069761', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098568', '1595778206288355330', '1602624222178435073', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098569', '1595778206288355330', '1602624711423025153', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098570', '1595778206288355330', '1598145819232452609', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098571', '1595778206288355330', '1598146693153439745', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098572', '1595778206288355330', '1598146830424621057', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098573', '1595778206288355330', '1598491317621542914', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098574', '1595778206288355330', '1598491452795572225', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098575', '1595778206288355330', '1602676164258705410', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098576', '1595778206288355330', '1602677070589079554', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098577', '1595778206288355330', '1602677180395958273', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1602682538204098578', '1595778206288355330', '1602677624706969602', 0, '2022-12-13 23:11:08', '2022-12-13 23:11:08');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445698', '1', '1196301740985311234', 1, '2022-12-21 17:03:11', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445699', '1', '1195268788138598401', 1, '2022-12-21 17:03:11', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445700', '1', '1195268893830864898', 0, '2022-12-21 17:03:11', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445701', '1', '1195349439240048642', 0, '2022-12-21 17:03:11', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445702', '1', '1195349699995734017', 0, '2022-12-21 17:03:11', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445703', '1', '1599673819673513986', 1, '2022-12-21 17:03:11', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445704', '1', '1195351862889254913', 1, '2022-12-21 17:03:11', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445705', '1', '1195351968841568257', 0, '2022-12-21 17:03:11', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445706', '1', '1195352215768633346', 1, '2022-12-21 17:03:11', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1605489043500445707', '1', '1600037630049816578', 1, '2022-12-21 17:03:11', '2022-12-21 17:03:11');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648897', '1', '1195269143060602882', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648898', '1', '1195269295926206466', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648899', '1', '1195269473479483394', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648900', '1', '1195269547269873666', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648901', '1', '1196301740985311234', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648902', '1', '1195268788138598401', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648903', '1', '1195269821262782465', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648904', '1', '1195269903542444034', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648905', '1', '1195270037005197313', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648906', '1', '1195270442602782721', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648907', '1', '1195270621548568578', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648908', '1', '1599673819673513986', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648909', '1', '1195351862889254913', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648910', '1', '1195352215768633346', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648911', '1', '1596681480323506178', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648912', '1', '1596682459521523714', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648913', '1', '1596856561142071297', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648914', '1', '1596891114233692162', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648915', '1', '1596885995953881090', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');
INSERT INTO `lms_role_permission` VALUES ('1605489450557648916', '1', '1600037630049816578', 0, '2022-12-21 17:04:48', '2022-12-21 17:04:48');

-- ----------------------------
-- Table structure for lms_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `lms_user_auth`;
CREATE TABLE `lms_user_auth`  (
  `id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编号',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `login_type` tinyint(1) NULL DEFAULT 0 COMMENT '登录类型：0-用户名、1-微信、2-微博',
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户签名',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户登录ip',
  `ip_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `last_login_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '上次登录时间',
  `state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-正常、0-停用',
  `user_info_id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外键---用户信息',
  `is_deleted` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  INDEX `user_auth_info`(`user_info_id` ASC) USING BTREE,
  CONSTRAINT `user_auth_info` FOREIGN KEY (`user_info_id`) REFERENCES `lms_user_info` (`id`) ON DELETE RESTRICT ON UPDATE SET NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户登录信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_user_auth
-- ----------------------------
INSERT INTO `lms_user_auth` VALUES ('1', 'admin', '96e79218965eb72c92a549dd5a330112', 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '风吹裤衩屁屁凉', 0, NULL, '', NULL, '2022-12-01 15:21:54', 1, '1', 0, '2019-11-01 10:39:47', '2022-12-01 14:35:06');
INSERT INTO `lms_user_auth` VALUES ('1595083572943790081', '1', '9db06bcff9248837f86d1a6bcf41c9e7', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/avatar/099d10b753194fc8b059d3caff90697f.jpg', '测', 0, NULL, NULL, NULL, '2022-11-24 21:19:01', 1, NULL, 0, '2022-11-22 23:55:34', '2022-12-12 17:34:05');
INSERT INTO `lms_user_auth` VALUES ('1595445134183387138', '你好啊', '9db06bcff9248837f86d1a6bcf41c9e7', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/avatar/fe7ee250223047aeb9be4489a728136e.jpg', '你好啊', 0, NULL, NULL, NULL, '2022-11-24 21:19:14', 1, NULL, 0, '2022-11-23 23:52:17', '2022-12-12 22:00:45');
INSERT INTO `lms_user_auth` VALUES ('1595754182183284737', '李白', '96e79218965eb72c92a549dd5a330112', '', '一二三', 0, NULL, NULL, NULL, NULL, 1, NULL, 0, '2022-11-24 20:20:19', '2022-11-24 20:20:19');
INSERT INTO `lms_user_auth` VALUES ('1600156051911540738', 'kebo', '96e79218965eb72c92a549dd5a330112', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/avatar/8cfc9bc2b122491db32251e051432a03.gif', '柯博', 0, NULL, NULL, NULL, NULL, 1, NULL, 0, '2022-12-06 23:51:47', '2022-12-06 23:51:47');
INSERT INTO `lms_user_auth` VALUES ('2', '测试', '96e79218965eb72c92a549dd5a330112', 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/avatar/f6d0b5246fde441fa6f94b0cc88b4d9b.gif', '测试1', 0, NULL, '', NULL, '2022-12-13 15:55:41', 1, '1602572892483145729', 0, '2019-11-01 16:36:07', '2022-12-13 14:51:28');

-- ----------------------------
-- Table structure for lms_user_info
-- ----------------------------
DROP TABLE IF EXISTS `lms_user_info`;
CREATE TABLE `lms_user_info`  (
  `id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `student_id` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` tinyint(1) NOT NULL DEFAULT 0 COMMENT '性别：0-男、1-女',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '照片',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `department` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '院系',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户基本信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_user_info
-- ----------------------------
INSERT INTO `lms_user_info` VALUES ('1', '0121810870100', '张三', 1, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/avatar/1e5810b1491a44e0834fd60a2fe21c80.gif', '15129630497', '284026@whut.edu.cn', '哈哈哈哈哈', '1111111', 0, '2022-11-16 14:49:12', '2022-12-07 00:34:22');
INSERT INTO `lms_user_info` VALUES ('1597209218407014401', '0121810870101', '李白', 0, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/avatar/f868a6e1ee584583b9afbe495955d712.jpg', '15129630498', '284027@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-12-12 17:35:03');
INSERT INTO `lms_user_info` VALUES ('1597209218415403009', '0121810870102', '李白', 1, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/student/a11d1dc96fb84dc580486acd85eee578.jpg', '15129630499', '284028@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-12-12 22:09:10');
INSERT INTO `lms_user_info` VALUES ('1597209218415403010', '0121810870103', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630500', '284029@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-11-28 20:42:07');
INSERT INTO `lms_user_info` VALUES ('1597209218415403011', '0121810870104', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630501', '284030@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-11-28 20:42:07');
INSERT INTO `lms_user_info` VALUES ('1597209218474123266', '0121810870105', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630502', '284031@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-11-28 20:42:07');
INSERT INTO `lms_user_info` VALUES ('1597209218474123267', '0121810870106', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630503', '284032@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-11-28 20:42:07');
INSERT INTO `lms_user_info` VALUES ('1597209218474123268', '0121810870107', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630504', '284033@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-11-28 20:42:07');
INSERT INTO `lms_user_info` VALUES ('1597209218474123269', '0121810870108', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630505', '284034@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-11-28 20:42:07', '2022-11-28 20:42:07');
INSERT INTO `lms_user_info` VALUES ('1602572892483145729', '0121810870123', '龚东东', 0, 'https://library-management-system.oss-cn-shanghai.aliyuncs.com/student/77f8a937c1f64e05ac96ce1163895248.png', '15129630498', '284027@qq.com', '计算机科学', '啊啊啊啊啊啊啊啊', 0, '2022-12-13 15:55:27', '2022-12-13 15:55:27');
INSERT INTO `lms_user_info` VALUES ('1605489265991565313', '0121810870101', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630498', '284027@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489265991565314', '0121810870102', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc28fd.gif', '15129630499', '284028@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489265991565315', '0121810870103', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc29fd.gif', '15129630500', '284029@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489266029314049', '0121810870104', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc30fd.gif', '15129630501', '284030@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489266029314050', '0121810870105', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc31fd.gif', '15129630502', '284031@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489266029314051', '0121810870106', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc32fd.gif', '15129630503', '284032@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489266029314052', '0121810870107', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc33fd.gif', '15129630504', '284033@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605489266029314053', '0121810870108', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc34fd.gif', '15129630505', '284034@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 17:04:04', '2022-12-21 17:04:04');
INSERT INTO `lms_user_info` VALUES ('1605504209977950210', '0121810870101', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif', '15129630498', '284027@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950211', '0121810870102', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc28fd.gif', '15129630499', '284028@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950212', '0121810870103', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc29fd.gif', '15129630500', '284029@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950213', '0121810870104', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc30fd.gif', '15129630501', '284030@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950214', '0121810870105', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc31fd.gif', '15129630502', '284031@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950215', '0121810870106', '李白', 1, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc32fd.gif', '15129630503', '284032@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950216', '0121810870107', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc33fd.gif', '15129630504', '284033@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');
INSERT INTO `lms_user_info` VALUES ('1605504209977950217', '0121810870108', '李白', 0, 'https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc34fd.gif', '15129630505', '284034@whut.edu.cn', '计算机学院电子信息', '该用户未写简介', 0, '2022-12-21 18:03:27', '2022-12-21 18:03:27');

-- ----------------------------
-- Table structure for lms_user_role
-- ----------------------------
DROP TABLE IF EXISTS `lms_user_role`;
CREATE TABLE `lms_user_role`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键id',
  `role_id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '角色id',
  `user_id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `is_deleted` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `user_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `lms_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `lms_user_auth` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lms_user_role
-- ----------------------------
INSERT INTO `lms_user_role` VALUES ('1594958581782814722', '1', '1', 0, '2022-11-22 15:38:53', '2022-11-22 15:38:53');
INSERT INTO `lms_user_role` VALUES ('1595778434454298626', '1193757683205607426', '1595754182183284737', 1, '2022-11-24 21:56:42', '2022-11-24 21:56:42');
INSERT INTO `lms_user_role` VALUES ('1596686269610463234', '1595778206288355330', '2', 1, '2022-11-27 10:04:06', '2022-11-27 10:04:06');
INSERT INTO `lms_user_role` VALUES ('1602555922903756802', '1595778206288355330', '2', 1, '2022-12-13 14:48:01', '2022-12-13 14:48:01');
INSERT INTO `lms_user_role` VALUES ('1602659002815135746', '1595778206288355330', '2', 0, '2022-12-13 21:37:37', '2022-12-13 21:37:37');

SET FOREIGN_KEY_CHECKS = 1;
