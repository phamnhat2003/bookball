-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: goalguard
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Hòa Vang','inactive'),(2,'Hòa Khánh','active'),(3,'Liên chiểu','active');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `court_id` int NOT NULL,
  `booking_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(255) DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `court_id` (`court_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`court_id`) REFERENCES `courts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,2,1,'2024-05-12','07:30:00','08:30:00','Thanh toán trực tiếp',10000000.00,'final'),(2,3,3,'2024-05-13','07:00:00','08:00:00','Thanh toán trực tiếp',1357.00,'pending'),(3,3,3,'2024-05-12','07:30:00','08:00:00','Thanh toán trực tiếp',667.00,'approved'),(4,3,3,'2024-05-12','07:00:00','07:30:00','Thanh toán trực tiếp',667.00,'pending'),(5,3,3,'2024-05-12','08:30:00','09:00:00','Thanh toán trực tiếp',667.00,'pending'),(6,3,1,'2024-05-13','07:00:00','08:00:00','Thanh toán trực tiếp',13688.00,'pending'),(7,3,1,'2024-05-13','07:00:00','08:00:00','Thanh toán trực tiếp',13688.00,'pending'),(8,3,5,'2024-05-21','07:30:00','08:00:00','Thanh toán trực tiếp',69690.00,'pending'),(9,3,5,'2024-05-23','07:00:00','08:30:00','Thanh toán trực tiếp',3445.78,'pending');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courts`
--

DROP TABLE IF EXISTS `courts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_areas` int NOT NULL,
  `id_field_types` int NOT NULL,
  `id_users` int DEFAULT NULL,
  `approval_status` varchar(255) DEFAULT 'pending',
  `status` varchar(255) DEFAULT 'active',
  `price` decimal(10,2) DEFAULT '0.00',
  `image` varchar(500) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `id_areas` (`id_areas`),
  KEY `id_field_types` (`id_field_types`),
  KEY `id_users` (`id_users`),
  CONSTRAINT `courts_ibfk_1` FOREIGN KEY (`id_areas`) REFERENCES `areas` (`id`),
  CONSTRAINT `courts_ibfk_2` FOREIGN KEY (`id_field_types`) REFERENCES `field_types` (`id`),
  CONSTRAINT `courts_ibfk_3` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courts`
--

LOCK TABLES `courts` WRITE;
/*!40000 ALTER TABLE `courts` DISABLE KEYS */;
INSERT INTO `courts` VALUES (1,'Sân Bóng 1',1,1,2,'approved','active',232.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','tes23432sdffffffffffffffffffffffffffffffffffffffffffsss'),(3,'Sân Bóng 2',2,1,2,'pending','active',23.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','tt'),(4,'Sân Bóng 3',2,1,2,'pending','active',234234.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','dsfsdf'),(5,'Sân Bóng 4',2,1,2,'approved','active',2323.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','trrt'),(6,'Sân Bóng 5',2,1,4,'approved','Đang sử dụng',32443.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','ttt'),(7,'Sân Bóng 6',2,1,5,'pending','active',232323.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','sdfsdf'),(8,'Sân Bóng 7',2,1,5,'pending','Đang sử dụng',232323.00,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171612472131878023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=9567552c-4857-4472-910a-e79380d7b8da','sdfsdfsdf');
/*!40000 ALTER TABLE `courts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `employee_code` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'nhân viên 01','nhanvien@gmail.com','$2b$10$oeSW2OnSpbOlCm/fvWvfVugvaV2AnAD9qpFFAViyZtOiP3cNvdeei','isEmployee','actived','kt01',2,'2024-05-06 19:26:58','2024-05-06 19:29:27');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_types`
--

DROP TABLE IF EXISTS `field_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_types`
--

LOCK TABLES `field_types` WRITE;
/*!40000 ALTER TABLE `field_types` DISABLE KEYS */;
INSERT INTO `field_types` VALUES (1,'Sân bóng đá 5 người - có nhân tạo','active'),(2,'Sân bóng đá 4 người','inactive');
/*!40000 ALTER TABLE `field_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Sự kiện','<div>Sự kiện 1</div>','https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171624143435778023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=a512ec46-6341-44e6-8063-0ac76741301c','2024-05-06 17:43:58','2025-03-18 17:35:45');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'Thông báo 01','Thông báo','2024-03-26 10:13:43','2024-03-26 10:13:43'),(2,'hệ thống giảm giá','hệ thống giảm giá','2024-03-26 11:17:09','2024-03-26 11:17:09'),(3,'hệ thống giảm giá','hệ thống giảm giá','2024-03-26 11:17:58','2024-03-26 11:17:58'),(4,'Thắc mắc về booking Email người gửi: test@gmail.com Họ tên: Test đây','booking','2024-05-13 05:26:14','2024-05-13 05:26:14'),(5,'Test liên hệ Email người gửi: vovanhung77h12@gmail.com Họ tên: Võ Hùng','liên hệ','2024-05-13 05:27:23','2024-05-13 05:27:23'),(6,'test Email người gửi: vovanhung77h12@gmail.com Họ tên: Võ Hùng','test','2024-05-13 05:27:48','2024-05-13 05:27:48');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES (1,1,'3e261778bcaefe94c837eb4831cc4d804d218da0','2024-03-26 12:10:23','2024-03-26 11:10:23'),(2,1,'2c62d4167e77624d6af9575b6ecad6e3f4d0c406','2024-05-13 05:33:01','2024-05-13 04:33:00'),(3,1,'43273f4a018f20ac973340ebb8fe1c86d7df2877','2024-05-13 06:01:36','2024-05-13 05:01:36');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_types`
--

DROP TABLE IF EXISTS `product_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_types`
--

LOCK TABLES `product_types` WRITE;
/*!40000 ALTER TABLE `product_types` DISABLE KEYS */;
INSERT INTO `product_types` VALUES (1,'Nước ngọt 1','inactive'),(2,'têt','active'),(3,'têt','active');
/*!40000 ALTER TABLE `product_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `status` varchar(255) DEFAULT 'active',
  `item_status` varchar(255) DEFAULT 'new',
  `id_product_type` int DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product_type` (`id_product_type`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_product_type`) REFERENCES `product_types` (`id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'sdfds1',324.00,24,'active','new',1,2,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1715004631989Video-Man-Hinh_First_Frame.png?alt=media&token=cb2e742d-6ffd-4b98-b5dc-77e19f06b057');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residence_rules`
--

DROP TABLE IF EXISTS `residence_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residence_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residence_rules`
--

LOCK TABLES `residence_rules` WRITE;
/*!40000 ALTER TABLE `residence_rules` DISABLE KEYS */;
INSERT INTO `residence_rules` VALUES (1,'Điều khoản sử dụng','Những điều khoản được áp dụng trên website Thế Giới Thể Thao\nĐiều khoản sử dụng\nChào mừng quý khách hàng đến với Thế Giới Thể Thao\n\nChúng tôi là Công ty Cổ phần Thương mại và xây dựng Thế giới thể thao có địa chỉ trụ sở tại Số 5 Nguyễn Khả Trạc - Mai Dịch - Cầu Giấy - Hà Nội. Chúng tôi quản lý và vận hành website: https://thegioithethao.vn\n\nKhi quý khách hàng truy cập vào trang website của chúng tôi có nghĩa là quý khách đồng ý với các điều khoản này. Trang web có quyền thay đổi, chỉnh sửa, thêm hoặc lược bỏ bất kỳ phần nào trong Điều khoản mua bán hàng hóa này, vào bất cứ lúc nào. Các thay đổi có hiệu lực ngay khi được đăng trên trang web mà không cần thông báo trước. Và khi quý khách tiếp tục sử dụng trang web, sau khi các thay đổi về Điều khoản này được đăng tải, có nghĩa là quý khách chấp nhận với những thay đổi đó.\nQuý khách hàng vui lòng kiểm tra thường xuyên để cập nhật những thay đổi của chúng tôi.\n\nHướng dẫn sử dụng website\nKhi vào web của chúng tôi, khách hàng phải đảm bảo đủ 18 tuổi, hoặc truy cập dưới sự giám sát của cha mẹ hay người giám hộ hợp pháp. Khách hàng đảm bảo có đầy đủ hành vi dân sự để thực hiện các giao dịch mua bán hàng hóa theo quy định hiện hành của pháp luật Việt Nam.\n\nChúng tôi sẽ cấp một tài khoản (Account) sử dụng để khách hàng có thể mua sắm trên website https://thegioithethao.vn trong khuôn khổ Điều khoản và Điều kiện sử dụng đã đề ra.\nQuý khách hàng sẽ phải đăng ký tài khoản với thông tin xác thực về bản thân và phải cập nhật nếu có bất kỳ thay đổi nào. Mỗi người truy cập phải có trách nhiệm với mật khẩu, tài khoản và hoạt động của mình trên web. Hơn nữa, quý khách hàng phải thông báo cho chúng tôi biết khi tài khoản bị truy cập trái phép. Chúng tôi không chịu bất kỳ trách nhiệm nào, dù trực tiếp hay gián tiếp, đối với những thiệt hại hoặc mất mát gây ra do quý khách không tuân thủ quy định.\nNghiêm cấm sử dụng bất kỳ phần nào của trang web này với mục đích thương mại hoặc nhân danh bất kỳ đối tác thứ ba nào nếu không được chúng tôi cho phép bằng văn bản. Nếu vi phạm bất cứ điều nào trong đây, chúng tôi sẽ hủy tài khoản của khách mà không cần báo trước.\nTrong suốt quá trình đăng ký, quý khách đồng ý nhận email quảng cáo từ website. Nếu không muốn tiếp tục nhận mail, quý khách có thể từ chối bằng cách nhấp vào đường link ở dưới cùng trong mọi email quảng cáo.\nÝ kiến của khách hàng\nTất cả nội dung trang web và ý kiến phê bình của quý khách đều là tài sản của chúng tôi. Nếu chúng tôi phát hiện bất kỳ thông tin giả mạo nào, chúng tôi sẽ khóa tài khoản của quý khách ngay lập tức hoặc áp dụng các biện pháp khác theo quy định của pháp luật Việt Nam.','2024-03-26 10:14:42','2024-03-26 10:14:42');
/*!40000 ALTER TABLE `residence_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_results`
--

DROP TABLE IF EXISTS `tournament_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournament_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tournament_id` int NOT NULL,
  `result_info` text,
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tournament_id` (`tournament_id`),
  CONSTRAINT `tournament_results_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_results`
--

LOCK TABLES `tournament_results` WRITE;
/*!40000 ALTER TABLE `tournament_results` DISABLE KEYS */;
INSERT INTO `tournament_results` VALUES (1,1,'Đội A Thắng','https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171550668529410.png?alt=media&token=c7747330-7739-4a9b-bb81-9ab531b8dfcc'),(2,3,'Đội B Thắng','https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1716241464259cach-tao-ma-qr-11.webp?alt=media&token=d6a56df7-46f3-47d7-8403-bd3fbce4746b');
/*!40000 ALTER TABLE `tournament_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournaments`
--

DROP TABLE IF EXISTS `tournaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournaments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `info` text,
  `teams` int DEFAULT '0',
  `matches` int DEFAULT '0',
  `group_count` int DEFAULT '0',
  `prizes` int DEFAULT '0',
  `status` varchar(255) DEFAULT 'active',
  `approval_status` varchar(255) DEFAULT 'pending',
  `id_users` int DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_users` (`id_users`),
  CONSTRAINT `tournaments_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournaments`
--

LOCK TABLES `tournaments` WRITE;
/*!40000 ALTER TABLE `tournaments` DISABLE KEYS */;
INSERT INTO `tournaments` VALUES (1,'giải đấu 02','giải đấu',2,3,4,10000,'active','approved',2,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171624143435778023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=a512ec46-6341-44e6-8063-0ac76741301c'),(3,'giải đấu 01','giải đấu',444,33,44,4343,'active','approved',2,'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/171624143435778023dfb-3555-443f-88a1-f723a00c469c.jpg?alt=media&token=a512ec46-6341-44e6-8063-0ac76741301c');
/*!40000 ALTER TABLE `tournaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'noactive',
  `image` varchar(255) DEFAULT 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_qr` varchar(500) DEFAULT 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'vovanhung77h12@gmail.com','0938283923','Admin','$2b$10$YXMaxfUoSZhXwfjhyku9befvkdgO/UlSvBJ/ypLdMxE3ewMKAN25C','isAdmin','actived','https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png','2024-03-19 06:44:52','2024-03-26 11:10:17','https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png'),(2,'seller@gmail.com','0938283923','seller','$2b$10$8QJCXxuc/WTcyicvKb5KXOFo.iHarOiyb6sQC48ZDUa.PrbvbP0wq','isSeller','actived',NULL,'2024-03-19 07:40:14','2024-05-20 21:47:49','https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1716241662129IMG_7690.jpg?alt=media&token=fab0ee60-f43e-4d16-bd0d-a26eb8b1e9e0'),(3,'client@gmail.com','0123456781','client 5','$2b$10$s/UgWQ5MwNIPRO348h8aF.U9mJW.PGzwYUpq3SgEuxnpENPiNhSxO','isClient','actived','https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1715587018613img-01.webp?alt=media&token=90ced03d-8869-4d57-9fdb-06298a9d73c3','2024-05-12 09:55:53','2024-05-19 07:54:26',NULL),(4,'seller2@gmail.com','0938283923','seller','$2b$10$8QJCXxuc/WTcyicvKb5KXOFo.iHarOiyb6sQC48ZDUa.PrbvbP0wq','isSeller','actived','https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png','2024-03-19 07:40:14','2024-05-19 07:59:20','https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1715585733638cach-tao-ma-qr-11.webp?alt=media&token=c9c97eb0-46cf-40d7-bcc8-9ee3db1f45a0'),(5,'banhang1@gmail.com','0123456789','banhang1','$2b$10$vRBLJ68GZzqC6RARnEJn3eIJmOn2dWrC6hoR2CGFExFRNDxFXRW.y','isSeller','actived','https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png','2024-05-19 13:15:38','2024-05-19 13:15:52','https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-19  0:36:32
