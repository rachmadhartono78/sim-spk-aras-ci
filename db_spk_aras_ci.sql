/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : db_spk_aras_ci

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 16/01/2025 18:51:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alternatif
-- ----------------------------
DROP TABLE IF EXISTS `alternatif`;
CREATE TABLE `alternatif`  (
  `id_alternatif` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_alternatif`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of alternatif
-- ----------------------------
INSERT INTO `alternatif` VALUES (16, 'Huda');
INSERT INTO `alternatif` VALUES (17, 'Willy');
INSERT INTO `alternatif` VALUES (18, 'Gana');
INSERT INTO `alternatif` VALUES (19, 'Anton');
INSERT INTO `alternatif` VALUES (20, 'Rachmad');

-- ----------------------------
-- Table structure for hasil
-- ----------------------------
DROP TABLE IF EXISTS `hasil`;
CREATE TABLE `hasil`  (
  `id_hasil` int NOT NULL AUTO_INCREMENT,
  `id_alternatif` int NOT NULL,
  `nilai` float NOT NULL,
  PRIMARY KEY (`id_hasil`) USING BTREE,
  INDEX `id_alternatif`(`id_alternatif` ASC) USING BTREE,
  CONSTRAINT `hasil_ibfk_1` FOREIGN KEY (`id_alternatif`) REFERENCES `alternatif` (`id_alternatif`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hasil
-- ----------------------------
INSERT INTO `hasil` VALUES (1, 16, 0.932728);
INSERT INTO `hasil` VALUES (2, 17, 0.649849);
INSERT INTO `hasil` VALUES (3, 18, 0.400605);
INSERT INTO `hasil` VALUES (4, 19, 0.681224);
INSERT INTO `hasil` VALUES (5, 20, 0.708253);

-- ----------------------------
-- Table structure for kriteria
-- ----------------------------
DROP TABLE IF EXISTS `kriteria`;
CREATE TABLE `kriteria`  (
  `id_kriteria` int NOT NULL AUTO_INCREMENT,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_kriteria` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bobot` float NOT NULL,
  `jenis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_kriteria`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kriteria
-- ----------------------------
INSERT INTO `kriteria` VALUES (24, 'Ketepatan Datang Kerja', 'C1', 0.3, 'Kinerja');
INSERT INTO `kriteria` VALUES (25, 'Kehadiran Kerja ', 'C2', 0.15, 'Kinerja');
INSERT INTO `kriteria` VALUES (26, 'Meninggalkan Kantor untuk Kepentingan Pribadi pada Waktu Kerja ', 'C3', 0.1, 'Risiko');
INSERT INTO `kriteria` VALUES (27, 'Pulang Kerja Lebih Cepat Selama-lamanya 30 Menit ', 'C4', 0.2, 'Kinerja');
INSERT INTO `kriteria` VALUES (28, 'Teguran Tertulis ', 'C5', 0.25, 'Kinerja');

-- ----------------------------
-- Table structure for penilaian
-- ----------------------------
DROP TABLE IF EXISTS `penilaian`;
CREATE TABLE `penilaian`  (
  `id_penilaian` int NOT NULL AUTO_INCREMENT,
  `id_alternatif` int NOT NULL,
  `id_kriteria` int NOT NULL,
  `nilai` int NOT NULL,
  PRIMARY KEY (`id_penilaian`) USING BTREE,
  INDEX `id_alternatif`(`id_alternatif` ASC) USING BTREE,
  INDEX `id_kriteria`(`id_kriteria` ASC) USING BTREE,
  INDEX `nilai`(`nilai` ASC) USING BTREE,
  CONSTRAINT `penilaian_ibfk_1` FOREIGN KEY (`id_alternatif`) REFERENCES `alternatif` (`id_alternatif`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_ibfk_2` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id_kriteria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_ibfk_3` FOREIGN KEY (`nilai`) REFERENCES `sub_kriteria` (`id_sub_kriteria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian
-- ----------------------------
INSERT INTO `penilaian` VALUES (128, 16, 24, 109);
INSERT INTO `penilaian` VALUES (129, 16, 25, 112);
INSERT INTO `penilaian` VALUES (130, 16, 26, 115);
INSERT INTO `penilaian` VALUES (131, 16, 27, 118);
INSERT INTO `penilaian` VALUES (132, 16, 28, 121);
INSERT INTO `penilaian` VALUES (133, 17, 24, 110);
INSERT INTO `penilaian` VALUES (134, 17, 25, 113);
INSERT INTO `penilaian` VALUES (135, 17, 26, 116);
INSERT INTO `penilaian` VALUES (136, 17, 27, 119);
INSERT INTO `penilaian` VALUES (137, 17, 28, 122);
INSERT INTO `penilaian` VALUES (138, 18, 24, 111);
INSERT INTO `penilaian` VALUES (139, 18, 25, 114);
INSERT INTO `penilaian` VALUES (140, 18, 26, 117);
INSERT INTO `penilaian` VALUES (141, 18, 27, 120);
INSERT INTO `penilaian` VALUES (142, 18, 28, 123);
INSERT INTO `penilaian` VALUES (143, 19, 24, 109);
INSERT INTO `penilaian` VALUES (144, 19, 25, 114);
INSERT INTO `penilaian` VALUES (145, 19, 26, 116);
INSERT INTO `penilaian` VALUES (146, 19, 27, 120);
INSERT INTO `penilaian` VALUES (147, 19, 28, 121);
INSERT INTO `penilaian` VALUES (148, 20, 24, 109);
INSERT INTO `penilaian` VALUES (149, 20, 25, 113);
INSERT INTO `penilaian` VALUES (150, 20, 26, 117);
INSERT INTO `penilaian` VALUES (151, 20, 27, 120);
INSERT INTO `penilaian` VALUES (152, 20, 28, 122);

-- ----------------------------
-- Table structure for sub_kriteria
-- ----------------------------
DROP TABLE IF EXISTS `sub_kriteria`;
CREATE TABLE `sub_kriteria`  (
  `id_sub_kriteria` int NOT NULL AUTO_INCREMENT,
  `id_kriteria` int NOT NULL,
  `deskripsi` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai` float NOT NULL,
  PRIMARY KEY (`id_sub_kriteria`) USING BTREE,
  INDEX `id_kriteria`(`id_kriteria` ASC) USING BTREE,
  CONSTRAINT `sub_kriteria_ibfk_1` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id_kriteria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sub_kriteria
-- ----------------------------
INSERT INTO `sub_kriteria` VALUES (109, 24, 'Selalu datang tepat waktu', 3);
INSERT INTO `sub_kriteria` VALUES (110, 24, 'Terlambat datang kerja selama-lamanya 30 menit dari waktu kerja yang telah ditentukan sebanyak 1 (satu) kali ', 2);
INSERT INTO `sub_kriteria` VALUES (111, 24, 'Terlambat datang kerja selama-lamanya 30 menit dari waktu kerja yang telah ditentukan sebanyak 2 (dua) kali. ', 1);
INSERT INTO `sub_kriteria` VALUES (112, 25, 'Tidak Pernah Absen', 3);
INSERT INTO `sub_kriteria` VALUES (113, 25, 'Tidak Pernah Masuk Kerja Sebanyak 1 Kali', 2);
INSERT INTO `sub_kriteria` VALUES (114, 25, 'Tidak Pernah Masuk kerja sebanyak 2 kali', 1);
INSERT INTO `sub_kriteria` VALUES (115, 26, 'Tidak Pernah Meninggalkan kantor', 3);
INSERT INTO `sub_kriteria` VALUES (116, 26, 'Meninggalkan kantor dengan ijin selama-lamanya 6 jam', 2);
INSERT INTO `sub_kriteria` VALUES (117, 26, 'Meninggalkan kantor dengaan izin lebih dari 6 jam dan selama lamanya 7 jam', 1);
INSERT INTO `sub_kriteria` VALUES (118, 27, 'Tidak pernah pulang kerja sebelum waktu kerjaa berakhir', 3);
INSERT INTO `sub_kriteria` VALUES (119, 27, 'Pernah pulang kerja lebih cepat sebanyak 1 kali', 2);
INSERT INTO `sub_kriteria` VALUES (120, 27, 'Pernah pulang kerja lebih cepat sebanyak 2 kali', 1);
INSERT INTO `sub_kriteria` VALUES (121, 28, 'Tidak pernah mendapat teguran tertulis', 3);
INSERT INTO `sub_kriteria` VALUES (122, 28, 'Pernah mendapat teguran tertulis sebanyak 1 kali', 2);
INSERT INTO `sub_kriteria` VALUES (123, 28, 'Pernah mendapat teguran tertulis sebanyak 2 kali', 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `id_user_level` int NOT NULL,
  `nama` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_user`) USING BTREE,
  INDEX `id_user_level`(`id_user_level` ASC) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`id_user_level`) REFERENCES `user_level` (`id_user_level`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, 'Admin', 'admin@gmail.com', 'admin', '21232f297a57a5a743894a0e4a801fc3');
INSERT INTO `user` VALUES (3, 2, 'User', 'user@gmail.com', 'user', '54321');

-- ----------------------------
-- Table structure for user_level
-- ----------------------------
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level`  (
  `id_user_level` int NOT NULL AUTO_INCREMENT,
  `user_level` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_user_level`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_level
-- ----------------------------
INSERT INTO `user_level` VALUES (1, 'Administrator');
INSERT INTO `user_level` VALUES (2, 'User');

SET FOREIGN_KEY_CHECKS = 1;
