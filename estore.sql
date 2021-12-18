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
('cff82d42-21e8-47a0-b2a5-ad7df35f9bde', 'admin1', '$2b$10$6EdCCp29JOzEhybGnktrxO.Q4vVd84rgnNTx8bI6xyw0aRCkoXnv6', 'Tâm', 'Minh', 'minhtam@gmail.com', '0912444777', NULL, 0);
INSERT INTO `admin` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `telephone`, `avatar`, `lock`) VALUES
('e6455620-c8f1-4ec0-a06f-7b9df8f5041a', 'admin2', '$2b$10$6pcOaKybQ.iocDtWF0RUvOPDbyoI/QVusCfrj.0O7YBSMmfA81eOW', 'Huy', 'Đoàn', 'doanhuy@gmail.com', '0988111333', NULL, 0);


INSERT INTO `cart` (`id`, `customer_id`, `product_id`, `quantity`, `size`, `total`) VALUES
(1, 'c13b50cf-6d5a-4816-ab11-e4c0b59fad35', '1', 1, 'L', 499000);
INSERT INTO `cart` (`id`, `customer_id`, `product_id`, `quantity`, `size`, `total`) VALUES
(2, 'c13b50cf-6d5a-4816-ab11-e4c0b59fad35', '2', 2, 'XL', 798000);


INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(1, NULL, 'Áo', '', 13);
INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(2, NULL, 'Quần', '', 8);
INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(3, 1, 'Áo len', 'áo len', 5);
INSERT INTO `category` (`id`, `parent_id`, `name`, `description`, `total_products`) VALUES
(4, 2, 'Quần len', 'quần len', 3),
(5, 1, 'Áo nỉ', 'áo nỉ', 4),
(6, 2, 'Quần nỉ', 'quần nỉ', 1);

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
(2, '1', '2', 'Tạm ổn', 4, '2021-11-15 15:23:04');
INSERT INTO `feedback` (`id`, `customer_id`, `product_id`, `content`, `rate`, `created_at`) VALUES
(3, '3', '3', NULL, 3, '2021-11-15 12:02:45');
INSERT INTO `feedback` (`id`, `customer_id`, `product_id`, `content`, `rate`, `created_at`) VALUES
(4, '4', '4', 'Chất lượng tốt', 5, '2021-11-15 14:02:47'),
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
('1', 1, 'Áo Thun Cổ Tròn', 'Áo Thun Cổ Tròn Dáng Rộng Không Tay', 499000, 5);
INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('10', 1, 'Áo Giả Lông Cừu Cổ Lọ', 'Dựa vào phản hồi của các khách hàng trước đó, phần thân áo đã được điều chỉnh để vừa vặn thoải mái hơn.', 399000, 5);
INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('11', 4, 'Quần Gaucho Len Pha', 'Quần lửng 3/4 vải len pha', 2499000, 5);
INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `rate`) VALUES
('12', 4, 'Quần Len Pha Xếp Ly', 'Mẫu quần âu được thiết kế theo phong cách menswear.', 1499000, 5),
('13', 6, 'Quần Nỉ Ống Túm', 'Quần nỉ có độ rũ vừa phải.', 999000, 4),
('14', 2, 'Quần Jogger Dáng Rũ', 'Quần jogger rộng rãi có viền ống suông. Chất liệu vải mịn tạo vẻ thon gọn cho người mặc.`', 799000, 5),
('15', 2, 'Quần Jogger Thể Thao Siêu Co Giãn', 'Cảm giác thoải mái đặc biệt. Quần jogger thời trang và với nhiều tính năng cho hoạt động thể thao hoặc để mặc hàng ngày.', 499000, 4),
('16', 2, 'Quần Jean Skinny Fit', 'Co giãn gấp đôi. Chiếc quần thoải mái hơn bao giờ hết.', 999000, 5),
('17', 2, 'Quần Jeans Ống Suông', 'Jeans made from selvedge denim.', 1499000, 5),
('18', 3, 'Áo Len Cashmere', 'Một chiếc áo len cổ cao cashmere 100% sang trọng.', 3499000, 5),
('19', 5, 'Áo Nỉ Có Mũ Cashmere', 'Một chiếc áo hoodie len cashmere pha sang trọng.', 4399000, 4),
('2', 3, 'Áo khoác len', 'Áo khoác len màu đen', 350000, 4),
('20', 3, 'Áo Len Extra Fine Merino', 'Chất liệu 100 ％ len Merino cao cấp. Một sản phẩm đan cao cấp với các chi tiết được cải tiến.', 799000, 5),
('21', 3, 'Áo Len Nhẹ Cổ Tròn', 'Chúng tôi đã cải tiến kiểu đan chunky truyền thống để nhẹ hơn và thoải mái hơn, đồng thời tạo ấn tượng về chất lượng cao cấp.', 699000, 4),
('3', 3, 'Áo khoác', 'Áo khoác màu đỏ', 450500, 5),
('4', 4, 'Quần len ngắn', 'Quần len ngắn màu xanh', 150000, 4),
('5', 5, 'Áo Nỉ Dài Tay', 'Một bộ sưu tập động vật đáng yêu xuất hiện trong các bộ phim của Disney!', 499000, 5),
('6', 5, 'Áo Nỉ Siêu Co Giãn', 'Khả năng co giãn đáng kinh ngạc để tự do di chuyển. Thoải mái đến mức bạn sẽ quên rằng bạn đang mặc áo.', 799000, 4),
('7', 5, 'Áo Nỉ Chui Đầu Dài Tay', 'Chất liệu thấm hút mồ hôi tốt để tăng cường sự thoải mái. Kiểu dáng linh hoạt vừa như quần áo mặc hàng ngày vừa như quần áo thể thao.', 799000, 5),
('8', 1, 'Áo Khoác Có Mũ Cản Gió', 'Áo hoodie giả lông cừu mịn có khả năng cản gió cực tốt. Chiều dài thân áo được cải tiến ngắn hơn một chút để kiểu dáng trông đẹp hơn.', 999000, 5),
('9', 1, 'Áo Cardigan Giả Lông Cừu', 'Lớp lông cừu mềm mại bao bọc bạn trong sự ấm áp nhẹ nhàng. Có thể mặc như một lớp bên trong áo khoác hoặc mặc riêng.', 799000, 5);

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
(1, '1', 'Minh Tâm', '0974861257', 'Hồ Chí Minh', 'Hồ Chí Minh', '1', '1', '179 Ngô tất tố');
INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(2, '1', 'Minh Tam', '0247864123', 'Quảng Trị', 'Gio Linh', 'Gio Linh', '7', NULL);
INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(3, '3', 'Gia Huy', '0178943214', 'Hồ Chí Minh', 'Hồ Chí Minh', '5', '19', '20 Lê Hồng Phong');
INSERT INTO `receiver_address` (`id`, `customer_id`, `receiver_name`, `telephone`, `province`, `city`, `district`, `ward`, `specific_address`) VALUES
(4, '4', 'Đoàn Huy', '0915764318', 'Đà Nẵng', 'Đà Nẵng', 'Thanh Khê', 'An Khê', '887 Trường Chinh');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;