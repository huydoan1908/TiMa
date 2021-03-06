/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lock` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `quantity` int DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  `total` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_cart_customer1_idx` (`customer_id`),
  KEY `fk_cart_product` (`product_id`) USING BTREE,
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_cart_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `total_products` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_category_category1_idx` (`parent_id`),
  CONSTRAINT `fk_category_category1` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` varchar(255) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `lock` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `telephone_UNIQUE` (`telephone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `rate` int NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_feedback_customer_idx` (`customer_id`),
  KEY `fk_feedback_product_idx` (`product_id`),
  CONSTRAINT `fk_feedback_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_feedback_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` varchar(255) NOT NULL,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiver_address_id` int NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `status` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_order_receiver_address1_idx` (`receiver_address_id`),
  KEY `fk_order_customer_idx` (`customer_id`),
  CONSTRAINT `fk_order_address` FOREIGN KEY (`receiver_address_id`) REFERENCES `receiver_address` (`id`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) NOT NULL,
  `product_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `size` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_order_detail_product_idx` (`product_id`),
  KEY `fk_detail_order_idx` (`order_id`),
  CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `fk_order_detail_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `price` decimal(10,0) NOT NULL,
  `rate` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_product_category1_idx` (`category_id`),
  CONSTRAINT `fk_product_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_image_product_idx` (`product_id`),
  CONSTRAINT `fk_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `product_size`;
CREATE TABLE `product_size` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `size` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_size_product_idx` (`product_id`),
  CONSTRAINT `fk_size_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `receiver_address`;
CREATE TABLE `receiver_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiver_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `province` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `city` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `district` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ward` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `specific_address` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_address_customer_idx` (`customer_id`),
  CONSTRAINT `fk_address_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

INSERT INTO `admin` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `avatar`, `lock`) VALUES
('921caff7-59d8-4720-92b1-aa5766e55f40', 'huy27201', '$2b$10$IZFFJCLfuoZyXHDUyBdztuH71HdnhFs/JI9ZTn6TFKDzLAK8mTfoy', 'Huy', 'Nguyen', 'giahuy@gmail.com', '0779669005', NULL, 0),
('cff82d42-21e8-47a0-b2a5-ad7df35f9bde', 'admin1', '$2b$10$6EdCCp29JOzEhybGnktrxO.Q4vVd84rgnNTx8bI6xyw0aRCkoXnv6', 'T??m', 'Minh', 'minhtam@gmail.com', '0912444777', NULL, 0);
INSERT INTO `admin` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `avatar`, `lock`) VALUES
('e6455620-c8f1-4ec0-a06f-7b9df8f5041a', 'admin2', '$2b$10$6pcOaKybQ.iocDtWF0RUvOPDbyoI/QVusCfrj.0O7YBSMmfA81eOW', 'Huy', '??o??n', 'doanhuy@gmail.com', '0988111333', NULL, 0);


INSERT INTO `cart` (`id`, `customer_id`, `product_id`, `quantity`, `size`, `total`) VALUES
(1, 'c13b50cf-6d5a-4816-ab11-e4c0b59fad35', '1', 1, 'L', 499000);
INSERT INTO `cart` (`id`, `customer_id`, `product_id`, `quantity`, `size`, `total`) VALUES
(2, 'c13b50cf-6d5a-4816-ab11-e4c0b59fad35', '2', 2, 'XL', 798000);


INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(1, NULL, '??o', '', 13);
INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(2, NULL, 'Qu???n', '', 8);
INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(3, 1, '??o len', '??o len', 5);
INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(4, 2, 'Qu???n len', 'qu???n len', 3),
(5, 1, '??o n???', '??o n???', 4),
(6, 2, 'Qu???n n???', 'qu???n n???', 1);

INSERT INTO `customer` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `dob`, `created_at`, `avatar`, `lock`) VALUES
('1', 'minhtam', 'minhtam123456', 'Tam', 'Tam', 'nvminhtam2201@gmail.com', '0914785641', '2001-01-22', '2021-11-11 15:23:10', NULL, 0);
INSERT INTO `customer` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `dob`, `created_at`, `avatar`, `lock`) VALUES
('2', 'wonderwall', 'di123123', 'Di', 'Chu', 'wonder@gmail.com', '0914756148', '1998-03-31', '2021-11-11 23:21:00', NULL, 0);
INSERT INTO `customer` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `dob`, `created_at`, `avatar`, `lock`) VALUES
('3', 'yaqi', 'qiya111', 'Qi', 'Ya', 'yaqi123@gmail.com', '0945781322', '1995-02-27', '2021-11-12 12:10:05', NULL, 0);
INSERT INTO `customer` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `dob`, `created_at`, `avatar`, `lock`) VALUES
('34805f84-09af-46bb-b40d-c9ae585bc47c', 'giahuy2001', '$2b$10$q84O8.1bJn.cwJrDZWfO/uwsS6AU6mOuKU7uYM5BWmygbLtgY3Rkm', 'Huy', 'Nguyen', 'maxieprohuy@gmail.com', '0787892224', '2018-01-01', '2021-12-16 09:27:54', NULL, 0),
('4', 'daqi', '123456', 'Qi', 'Da', 'helloo@gmail.com', '0647856148', '1990-08-19', '2021-11-13 07:00:47', 'https://scontent.fsgn2-4.fna.fbcdn.net/v/t1.6435-9/147443784_1546166522240135_3145401986095318496_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=174925&_nc_ohc=UPAV0ZfD1sUAX_449Py&_nc_ht=scontent.fsgn2-4.fna&oh=9721195ab36a64e9749cc28190f29118&oe=61CAA62E', 0),
('c13b50cf-6d5a-4816-ab11-e4c0b59fad35', 'doanhuy198', '$2b$10$oVHsnhuXpQf5zXFu6/e4xe6GjxBM9EPUW7yIJ2zmYDgpWLPPpq2R2', 'Huy', 'Doan', 'huy11900@gmail.com', '0565204641', '2018-01-01', '2021-12-16 09:32:10', NULL, 0);

INSERT INTO `feedback` (`id`, `customer_id`, `product_id`, `content`, `rate`, `created_at`) VALUES
(1, '1', '1', 'Good', 5, '2021-11-15 22:00:00');
INSERT INTO `feedback` (`id`, `customer_id`, `product_id`, `content`, `rate`, `created_at`) VALUES
(2, '1', '2', 'T???m ???n', 4, '2021-11-15 15:23:04');
INSERT INTO `feedback` (`id`, `customer_id`, `product_id`, `content`, `rate`, `created_at`) VALUES
(3, '3', '3', NULL, 3, '2021-11-15 12:02:45');
INSERT INTO `feedback` (`id`, `customer_id`, `product_id`, `content`, `rate`, `created_at`) VALUES
(4, '4', '4', 'Ch???t l?????ng t???t', 5, '2021-11-15 14:02:47'),
(5, 'c84076a5-1ad3-4486-8f53-d86254c93054', '1', 'perfect', 5, '2021-12-09 18:30:20'),
(12, 'c84076a5-1ad3-4486-8f53-d86254c93054', '1', 'Good', 4, '2021-12-10 18:36:24'),
(13, '4', '1', 'Nice', 5, '2021-12-10 20:16:15'),
(14, 'c84076a5-1ad3-4486-8f53-d86254c93054', '1', 'Nice', 5, '2021-12-10 20:16:18'),
(27, 'c84076a5-1ad3-4486-8f53-d86254c93054', '1', 'Hello', 5, '2021-12-15 15:20:55');

INSERT INTO `order` (`id`, `customer_id`, `receiver_address_id`, `total`, `status`, `created_at`, `note`) VALUES
('1', '1', 1, 150000, 'Success', '2021-11-13 22:05:30', NULL);
INSERT INTO `order` (`id`, `customer_id`, `receiver_address_id`, `total`, `status`, `created_at`, `note`) VALUES
('2', '1', 2, 364000, 'Success', '2021-11-13 15:00:22', NULL);
INSERT INTO `order` (`id`, `customer_id`, `receiver_address_id`, `total`, `status`, `created_at`, `note`) VALUES
('3', '3', 3, 1120000, 'Success', '2021-11-13 21:46:00', NULL);
INSERT INTO `order` (`id`, `customer_id`, `receiver_address_id`, `total`, `status`, `created_at`, `note`) VALUES
('4', '4', 4, 945000, 'Success', '2021-11-14 00:00:02', NULL);

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size`, `quantity`, `price`) VALUES
(1, '1', '1', 'S', 2, 200000);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size`, `quantity`, `price`) VALUES
(2, '1', '2', 'S', 1, 150000);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size`, `quantity`, `price`) VALUES
(3, '2', '3', 'M', 1, 200000);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size`, `quantity`, `price`) VALUES
(4, '3', '2', 'S', 2, 300000),
(5, '4', '2', 'S', 1, 150000);

INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('1', 1, '??o Thun C??? Tr??n', '??o Thun C??? Tr??n D??ng R???ng Kh??ng Tay', 499000, 5);
INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('10', 1, '??o Gi??? L??ng C???u C??? L???', 'D???a v??o ph???n h???i c???a c??c kh??ch h??ng tr?????c ????, ph???n th??n ??o ???? ???????c ??i???u ch???nh ????? v???a v???n tho???i m??i h??n.', 399000, 5);
INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('11', 4, 'Qu???n Gaucho Len Pha', 'Qu???n l???ng 3/4 v???i len pha', 2499000, 5);
INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('12', 4, 'Qu???n Len Pha X???p Ly', 'M???u qu???n ??u ???????c thi???t k??? theo phong c??ch menswear.', 1499000, 5),
('13', 6, 'Qu???n N??? ???ng T??m', 'Qu???n n??? c?? ????? r?? v???a ph???i.', 999000, 4),
('14', 2, 'Qu???n Jogger D??ng R??', 'Qu???n jogger r???ng r??i c?? vi???n ???ng su??ng. Ch???t li???u v???i m???n t???o v??? thon g???n cho ng?????i m???c.`', 799000, 5),
('15', 2, 'Qu???n Jogger Th??? Thao Si??u Co Gi??n', 'C???m gi??c tho???i m??i ?????c bi???t. Qu???n jogger th???i trang v?? v???i nhi???u t??nh n??ng cho ho???t ?????ng th??? thao ho???c ????? m???c h??ng ng??y.', 499000, 4),
('16', 2, 'Qu???n Jean Skinny Fit', 'Co gi??n g???p ????i. Chi???c qu???n tho???i m??i h??n bao gi??? h???t.', 999000, 5),
('17', 2, 'Qu???n Jeans ???ng Su??ng', 'Jeans made from selvedge denim.', 1499000, 5),
('18', 3, '??o Len Cashmere', 'M???t chi???c ??o len c??? cao cashmere 100% sang tr???ng.', 3499000, 5),
('19', 5, '??o N??? C?? M?? Cashmere', 'M???t chi???c ??o hoodie len cashmere pha sang tr???ng.', 4399000, 4),
('2', 3, '??o kho??c len', '??o kho??c len m??u ??en', 350000, 4),
('20', 3, '??o Len Extra Fine Merino', 'Ch???t li???u 100 ??? len Merino cao c???p. M???t s???n ph???m ??an cao c???p v???i c??c chi ti???t ???????c c???i ti???n.', 799000, 5),
('21', 3, '??o Len Nh??? C??? Tr??n', 'Ch??ng t??i ???? c???i ti???n ki???u ??an chunky truy???n th???ng ????? nh??? h??n v?? tho???i m??i h??n, ?????ng th???i t???o ???n t?????ng v??? ch???t l?????ng cao c???p.', 699000, 4),
('3', 3, '??o kho??c', '??o kho??c m??u ?????', 450500, 5),
('4', 4, 'Qu???n len ng???n', 'Qu???n len ng???n m??u xanh', 150000, 4),
('5', 5, '??o N??? D??i Tay', 'M???t b??? s??u t???p ?????ng v???t ????ng y??u xu???t hi???n trong c??c b??? phim c???a Disney!', 499000, 5),
('6', 5, '??o N??? Si??u Co Gi??n', 'Kh??? n??ng co gi??n ????ng kinh ng???c ????? t??? do di chuy???n. Tho???i m??i ?????n m???c b???n s??? qu??n r???ng b???n ??ang m???c ??o.', 799000, 4),
('7', 5, '??o N??? Chui ?????u D??i Tay', 'Ch???t li???u th???m h??t m??? h??i t???t ????? t??ng c?????ng s??? tho???i m??i. Ki???u d??ng linh ho???t v???a nh?? qu???n ??o m???c h??ng ng??y v???a nh?? qu???n ??o th??? thao.', 799000, 5),
('8', 1, '??o Kho??c C?? M?? C???n Gi??', '??o hoodie gi??? l??ng c???u m???n c?? kh??? n??ng c???n gi?? c???c t???t. Chi???u d??i th??n ??o ???????c c???i ti???n ng???n h??n m???t ch??t ????? ki???u d??ng tr??ng ?????p h??n.', 999000, 5),
('9', 1, '??o Cardigan Gi??? L??ng C???u', 'L???p l??ng c???u m???m m???i bao b???c b???n trong s??? ???m ??p nh??? nh??ng. C?? th??? m???c nh?? m???t l???p b??n trong ??o kho??c ho???c m???c ri??ng.', 799000, 5);

INSERT INTO `product_image` (`id`, `product_id`, `image_url`) VALUES
(1, '1', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/440749/item/vngoods_00_440749.jpg?width=1600&impolicy=quality_75');
INSERT INTO `product_image` (`id`, `product_id`, `image_url`) VALUES
(2, '2', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/439147/item/vngoods_66_439147.jpg?width=1008&impolicy=quality_75');
INSERT INTO `product_image` (`id`, `product_id`, `image_url`) VALUES
(3, '3', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/439146/item/vngoods_52_439146.jpg?width=1008&impolicy=quality_75');
INSERT INTO `product_image` (`id`, `product_id`, `image_url`) VALUES
(4, '4', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/435913/item/vngoods_35_435913.jpg?width=1008&impolicy=quality_75'),
(5, '5', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/443680/item/vngoods_09_443680.jpg?width=1008&impolicy=quality_75'),
(6, '6', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/442479/item/vngoods_04_442479.jpg?width=1008&impolicy=quality_75'),
(7, '7', 'https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/435102/item/goods_66_435102.jpg?width=1600&impolicy=quality_75'),
(8, '8', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/440121/item/vngoods_01_440121.jpg?width=1600&impolicy=quality_75'),
(9, '9', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/439140/item/vngoods_09_439140.jpg?width=1600&impolicy=quality_75'),
(10, '10', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/442063/item/vngoods_31_442063.jpg?width=1600&impolicy=quality_75'),
(11, '11', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/445936/item/vngoods_56_445936.jpg?width=1600&impolicy=quality_75'),
(12, '12', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/443406/item/vngoods_38_443406.jpg?width=1600&impolicy=quality_75'),
(13, '13', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/443246/item/vngoods_58_443246.jpg?width=1600&impolicy=quality_75'),
(14, '14', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/439474/item/vngoods_34_439474.jpg?width=1600&impolicy=quality_75'),
(15, '15', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/433737/item/vngoods_08_433737.jpg?width=1600&impolicy=quality_75'),
(16, '16', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/428683/item/vngoods_68_428683.jpg?width=1600&impolicy=quality_75'),
(17, '17', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/446518/item/vngoods_69_446518.jpg?width=1600&impolicy=quality_75'),
(18, '18', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/445806/item/vngoods_67_445806.jpg?width=1600&impolicy=quality_75'),
(19, '19', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/445804/item/vngoods_69_445804.jpg?width=1600&impolicy=quality_75'),
(20, '20', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/438784/item/vngoods_68_438784.jpg?width=1600&impolicy=quality_75'),
(21, '21', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/442741/item/vngoods_69_442741.jpg?width=1600&impolicy=quality_75'),
(22, '1', 'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/440749/sub/vngoods_440749_sub6.jpg?width=1600&impolicy=quality_75'),
(23, '1', 'https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/440749/sub/goods_440749_sub9.jpg?width=1600&impolicy=quality_75');

INSERT INTO `product_size` (`id`, `product_id`, `size`, `quantity`) VALUES
(1, '1', 'S', 100);
INSERT INTO `product_size` (`id`, `product_id`, `size`, `quantity`) VALUES
(2, '2', 'S', 132);
INSERT INTO `product_size` (`id`, `product_id`, `size`, `quantity`) VALUES
(3, '3', 'M', 31);
INSERT INTO `product_size` (`id`, `product_id`, `size`, `quantity`) VALUES
(4, '4', 'L', 45),
(5, '4', 'M', 65),
(6, '5', 'S', 50),
(7, '5', 'M', 60),
(8, '6', 'L', 40),
(9, '6', 'M', 100),
(10, '7', 'S', 47),
(11, '7', 'M', 50),
(12, '7', 'L', 35),
(13, '8', 'M', 89),
(14, '8', 'L', 56),
(15, '9', 'XL', 20);

INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(1, '1', 'Minh T??m', '0974861257', 'H??? Ch?? Minh', 'H??? Ch?? Minh', '1', '1', '179 Ng?? t???t t???');
INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(2, '1', 'Minh Tam', '0247864123', 'Qu???ng Tr???', 'Gio Linh', 'Gio Linh', '7', NULL);
INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(3, '3', 'Gia Huy', '0178943214', 'H??? Ch?? Minh', 'H??? Ch?? Minh', '5', '19', '20 L?? H???ng Phong');
INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(4, '4', '??o??n Huy', '0915764318', '???? N???ng', '???? N???ng', 'Thanh Kh??', 'An Kh??', '887 Tr?????ng Chinh');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;