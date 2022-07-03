/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : xiaomissm

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 02/07/2022 21:49:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `addressId` int(0) NOT NULL AUTO_INCREMENT,
  `uid` int(0) NULL DEFAULT NULL,
  `cnee` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`addressId`) USING BTREE,
  INDEX `FK_Reference_1`(`uid`) USING BTREE,
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, 'zar', '15266676667', '北京海淀甲骨文');
INSERT INTO `address` VALUES (2, 1, 'oracle', '15266678888', '北京朝阳科技文化一条街');
INSERT INTO `address` VALUES (3, 2, '张三', '15290888162', '北京大兴西红门');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `a_id` int(0) NOT NULL AUTO_INCREMENT,
  `a_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_pass` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '000000');

-- ----------------------------
-- Table structure for carshop
-- ----------------------------
DROP TABLE IF EXISTS `carshop`;
CREATE TABLE `carshop`  (
  `cid` int(0) NOT NULL AUTO_INCREMENT,
  `uid` int(0) NULL DEFAULT NULL,
  `pid` int(0) NULL DEFAULT NULL,
  `numbers` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `FK_Reference_3`(`uid`) USING BTREE,
  INDEX `FK_Reference_4`(`pid`) USING BTREE,
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`pid`) REFERENCES `product_info` (`p_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carshop
-- ----------------------------
INSERT INTO `carshop` VALUES (1, 1, 1, 2);

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `odid` int(0) NOT NULL AUTO_INCREMENT,
  `oid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` int(0) NULL DEFAULT NULL,
  `pnumber` int(0) NULL DEFAULT NULL,
  `ptotal` double(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`odid`) USING BTREE,
  INDEX `FK_Reference_7`(`oid`) USING BTREE,
  INDEX `FK_Reference_8`(`pid`) USING BTREE,
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`pid`) REFERENCES `product_info` (`p_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`oid`) REFERENCES `xmorder` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES (1, 'abcd111222333444777888999000wwww', 1, 2, 9996.00);

-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info`  (
  `p_id` int(0) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_content` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_price` int(0) NULL DEFAULT NULL,
  `p_image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_number` int(0) NULL DEFAULT NULL,
  `type_id` int(0) NULL DEFAULT NULL,
  `p_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `product_info_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `product_type` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES (1, '小米Note2', '双曲面 黑色 6GB内存 64GB闪存', 2899, 'xmNote2.jpg', 500, 1, '2018-01-04');
INSERT INTO `product_info` VALUES (2, '红米Note5A', '5.5英寸 粉色 2GB内存 16GB闪存', 699, 'hmNote5A.jpg', 500, 1, '2018-01-05');
INSERT INTO `product_info` VALUES (3, '红米Note4X', '5.5英寸 绿色 4GB内存 64GB闪存', 1299, 'hmNote4X.jpg', 500, 1, '2018-01-06');
INSERT INTO `product_info` VALUES (4, '红米4', '5英寸 金色 3GB内存 32GB闪存', 999, 'hm4.jpg', 500, 1, '2018-01-07');
INSERT INTO `product_info` VALUES (5, '红米4X', '5英寸 黑色 3GB内存 32GB闪存', 899, 'hm4X.jpg', 500, 1, '2018-01-08');
INSERT INTO `product_info` VALUES (6, '小米平板3', '7.9英寸 金色 4GB内存 64GB闪存', 1499, 'xmPad3.jpg', 500, 2, '2018-01-09');
INSERT INTO `product_info` VALUES (7, '小米Air12', '12.5英寸 银色 4GB内存 128GB闪存', 3599, 'xmAir12.jpg', 500, 2, '2018-01-18');
INSERT INTO `product_info` VALUES (8, '小米Air13', '13.3英寸 银色 8GB内存 256GB闪存', 4999, 'xmAir13.jpg', 500, 2, '2018-01-17');
INSERT INTO `product_info` VALUES (9, '小米Pro', '15.6英寸 灰色 16GB内存 256GB闪存', 6999, 'xmPro.jpg', 500, 2, '2018-01-16');
INSERT INTO `product_info` VALUES (10, '小米电视4', '49英寸 原装LG屏 3840×2160 真4K', 3299, 'xmTV4-49.jpg', 500, 3, '2018-01-15');
INSERT INTO `product_info` VALUES (11, '小米电视4', '55英寸 原装三星屏 3840×2160 真4K', 3999, 'xmTV4-55.jpg', 500, 3, '2018-01-13');
INSERT INTO `product_info` VALUES (12, '小米电视4', '65英寸 原装三星屏 3840×2160 真4K', 8999, 'xmTV4-65.jpg', 500, 3, '2018-01-22');
INSERT INTO `product_info` VALUES (13, '小米电视4A', '43英寸 FHD全高清屏 1920*1080', 1999, 'xmTV4A-43.jpg', 500, 3, '2018-01-11');
INSERT INTO `product_info` VALUES (14, '小米电视4A', '49英寸 FHD全高清屏 1920*1080', 2299, 'xmTV4A-49.jpg', 500, 3, '2018-01-21');
INSERT INTO `product_info` VALUES (15, '小米MIX2', '全陶瓷 黑色 8GB内存 128GB闪存', 4699, 'xmMIX2.jpg', 500, 1, '2018-04-01');
INSERT INTO `product_info` VALUES (16, '小米Note3', '全网通 蓝色 6GB内存 64GB闪存', 2499, 'xmNote3.jpg', 500, 1, '2018-03-01');
INSERT INTO `product_info` VALUES (17, '小米6', '玻璃金属 白色 6GB内存 128GB闪存', 2899, 'xm6.jpg', 500, 1, '2018-02-01');
INSERT INTO `product_info` VALUES (18, '小米MAX2', '全金属 金色 4GB内存 64GB闪存', 1599, 'xmMAX2.jpg', 500, 1, '2018-01-02');
INSERT INTO `product_info` VALUES (19, '小米5X', '全金属 金色 4GB内存 64GB闪存', 1499, 'xm5X.jpg', 500, 1, '2018-01-03');

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type`  (
  `type_id` int(0) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO `product_type` VALUES (1, '手机');
INSERT INTO `product_type` VALUES (2, '电脑');
INSERT INTO `product_type` VALUES (3, '电视');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `uid` int(0) NOT NULL AUTO_INCREMENT,
  `uname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `upass` varbinary(50) NULL DEFAULT NULL,
  `ustatus` int(0) NULL DEFAULT NULL,
  `ulevel` int(0) NULL DEFAULT NULL,
  `score` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'zar', 0x313233343536, 0, 0, 0);
INSERT INTO `users` VALUES (2, 'zhangsan', 0x313233343536, 1, 0, 0);

-- ----------------------------
-- Table structure for xmorder
-- ----------------------------
DROP TABLE IF EXISTS `xmorder`;
CREATE TABLE `xmorder`  (
  `oid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(0) NULL DEFAULT NULL,
  `addressId` int(0) NULL DEFAULT NULL,
  `totalprice` double(10, 2) NULL DEFAULT NULL,
  `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `odate` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `FK_Reference_5`(`uid`) USING BTREE,
  INDEX `FK_Reference_6`(`addressId`) USING BTREE,
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xmorder
-- ----------------------------
INSERT INTO `xmorder` VALUES ('abcd111222333444777888999000wwww', 1, 1, 9996.00, '尽快送到', '待发货', '2022-07-02 21:45:43');

SET FOREIGN_KEY_CHECKS = 1;
