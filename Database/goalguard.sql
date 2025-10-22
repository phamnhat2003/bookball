-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2025 at 09:07 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `goalguard`
--

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `name`, `status`) VALUES
(1, 'Khoái Châu', 'inactive'),
(2, 'Yên Mỹ', 'active'),
(4, 'Ân Thi', 'active'),
(5, 'Văn Lâm', 'active'),
(6, 'Văn Giang', 'active'),
(7, 'Kim Động', 'active'),
(8, 'Thành phố Hưng Yên', 'active'),
(9, 'Mỹ Hào', 'active'),
(10, 'Tiên Lữ', 'active'),
(11, 'Phù Cừ', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `court_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(255) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courts`
--

CREATE TABLE `courts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `id_areas` int(11) NOT NULL,
  `id_field_types` int(11) NOT NULL,
  `id_users` int(11) DEFAULT NULL,
  `approval_status` varchar(255) DEFAULT 'pending',
  `status` varchar(255) DEFAULT 'active',
  `price` decimal(10,2) DEFAULT 0.00,
  `image` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `courts`
--

INSERT INTO `courts` (`id`, `name`, `id_areas`, `id_field_types`, `id_users`, `approval_status`, `status`, `price`, `image`, `description`) VALUES
(9, 'Sân Cỏ Nhân Tạo Kỳ Hòa', 2, 1, 6, 'approved', 'active', 100000.00, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748884983381san1.jpg?alt=media&token=a2626f84-09bf-45fa-8029-d03ad0c1b360', 'Sân bóng cỏ nhân tạo 7 người, mặt sân bằng phẳng, hệ thống chiếu sáng LED hiện đại, có khu vực gửi xe và phòng thay đồ sạch sẽ.'),
(10, 'Sân Vận Động Thành Long', 4, 1, 6, 'approved', 'active', 150000.00, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885024524san2.jpg?alt=media&token=3d4a906d-bd14-4971-894e-8391c88bec47', 'Sân bóng đá chuyên nghiệp với sức chứa hơn 1.000 người, phù hợp tổ chức các giải đấu lớn nhỏ. Có khu vực khán đài, WC và máy bán nước tự động.'),
(11, 'Sân Mini Phú Nhuận', 5, 4, 6, 'approved', 'active', 200000.00, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885226085san3.webp?alt=media&token=18fdf323-15c6-4628-9a2a-fb6560d441aa', 'Sân bóng 11 người, phù hợp chơi giải trí buổi tối. Mặt sân cao su nhân tạo êm ái, có mái che mưa nắng và dàn đèn công suất cao.'),
(12, 'Sân Bóng Hưng Thịnh', 6, 3, 6, 'approved', 'active', 200000.00, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885257636san4.jpg?alt=media&token=56cfe024-ab1c-403b-bda0-f65bbf3d5078', 'Sân bóng mới xây, chuẩn kích thước FIFA dành cho 11 người. Có nhà xe, chỗ nghỉ ngơi cho cầu thủ và nhân viên y tế túc trực trong giờ cao điểm.'),
(13, 'Sân Cầu Giấy United', 7, 1, 6, 'approved', 'active', 200000.00, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885301026san5.jpg?alt=media&token=26d39550-45ab-4169-8900-d8a451ef440b', 'Sân bóng đá cộng đồng nằm trong khuôn viên trung tâm thể thao, được nhiều đội bóng phủi thuê vào cuối tuần. Dịch vụ thuê đồ và trọng tài sẵn có.');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `employee_code` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `username`, `email`, `password`, `role`, `status`, `employee_code`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 'Nhân viên 1', 'nv1@gmail.com', '$2b$10$gg3P.9PPoiP8SB/8A1Arh.l2uwRJ5kL2sjh6ZZ/Sb3yTfe059TgaS', 'isEmployee', 'actived', '1', 6, '2025-06-02 17:17:47', '2025-06-02 17:17:47'),
(3, 'Nhân viên 2', 'nv2@gmail.com', '$2b$10$FxtQXa17bi5WHN9gA1UhUOvGclrrHqANehowuN81cwo5dq5NOddt2', 'isEmployee', 'actived', '2', 6, '2025-06-02 17:18:05', '2025-06-02 17:18:05');

-- --------------------------------------------------------

--
-- Table structure for table `field_types`
--

CREATE TABLE `field_types` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `field_types`
--

INSERT INTO `field_types` (`id`, `type`, `status`) VALUES
(1, 'Sân bóng đá 7 người - có nhân tạo', 'active'),
(3, 'Sân bóng đá 9 người - cỏ tự nhiên', 'active'),
(4, 'Sân bóng đá 11 người - cỏ tự nhiên', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`) VALUES
(2, 'Vòng loại World Cup 2026', '<p style=\"margin: 0px 0px 15px; padding: 0px; list-style: none; outline: 0px; box-sizing: border-box; border: 0px; vertical-align: bottom; background: rgb(255, 255, 255); font-size: 18px; line-height: 1.6; text-align: justify; color: rgb(17, 17, 17); font-family: Roboto, Helvetica, Arial, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Vòng loại World Cup 2026 là tâm điểm của bóng đá quốc tế trong năm 2025. Các khu vực như châu Á, châu Âu, Nam Mỹ và châu Phi sẽ bước vào giai đoạn cạnh tranh gay cấn. Một số mốc thời gian quan trọng của sự kiện này say đây:</span></p><ul style=\"margin: 0px 0px 15px; padding: 0px 0px 0px 40px; list-style: initial; outline: 0px; box-sizing: border-box; border: 0px; vertical-align: bottom; background: rgb(255, 255, 255); color: rgb(17, 17, 17); font-family: Roboto, Helvetica, Arial, sans-serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><li style=\"font-size: 14px;\"><span style=\"font-size: 14px;\"><strong>Châu Á:</strong>&nbsp;Loạt trận từ tháng 3, tháng 6 và tháng 11.</span></li><li style=\"font-size: 14px;\"><span style=\"font-size: 14px;\"><strong>Châu Âu:</strong>&nbsp;Các vòng loại diễn ra vào tháng 3, 6, 9, 10 và 11.</span></li><li style=\"font-size: 14px;\"><span style=\"font-size: 14px;\"><strong>Nam Mỹ:</strong>&nbsp;Diễn ra xuyên suốt từ tháng 3 đến tháng 11.</span></li><li style=\"font-size: 14px;\"><span style=\"font-size: 14px;\"><strong>Châu Phi:&nbsp;</strong>Tiếp tục các lượt trận quan trọng vào tháng 3.</span></li></ul>', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748882602747tintuc1.jpg?alt=media&token=77459f77-8dce-44c1-a9d4-fcae356707f9', '2025-06-02 16:43:26', '2025-06-02 16:49:05'),
(3, 'FIFA Club World Cup hứa hẹn những bất ngờ', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Giải đấu bóng đá quốc tế được chờ đợi nhất trong năm 2025 sẽ là FIFA Club World Cup được tổ chức theo phiên bản hoàn toàn mới. 32 câu lạc bộ hàng đầu sẽ tranh tài tại 12 sân vận động của nước Mỹ từ ngày 15/6 đến ngày 13/7. Đây là lần đầu tiên trong lịch sử, FIFA Club World Cup có nhiều đội bóng tham gia như vậy. Đây là cơ hội cho khán giả bóng đá trên toàn thế giới có trải nghiệm xem một “World Cup phiên bản câu lạc bộ” với các đại diện đến từ khắp các châu lục.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Danh sách tham gia FIFA Club World Cup 2025 gồm 12 đội đến từ châu Âu, 4 đội châu Á, 4 đội châu Phi, 4 đội khu vực CONCACAF, 6 đội Nam Mỹ, 6 đội châu Đại dương và 1 đội đại diện cho nước chủ nhà Mỹ là Inter Miami, nơi siêu sao Lionel Messi đang thi đấu. Tất cả các đội đều là nhà vô địch cấp câu lạc bộ ở châu lục của họ trong 4 năm gần nhất, hoặc có điểm xếp hạng trung bình cao nhất tại châu lục của họ trong 4 năm. 32 đội tham gia sẽ được chia vào 8 bảng đấu, mỗi bảng 4 đội thi đấu vòng tròn một lượt chọn ra 2 đội dẫn đầu vào vòng loại trực tiếp. Đây là thể thức đã trở nên rất quen thuộc ở các kỳ World Cup trước đây.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Những cái tên tham dự FIFA Club World Cup 2025 là sự đảm bảo chất lượng giải đấu. Châu Âu, nơi có số đội bóng tham dự lớn nhất, sẽ có lực lượng gồm những “đại gia” sừng sỏ nhất như Real Madrid, Man City, Chelsea, Bayern Munich, Inter Milan... Đại diện của khu vực Nam Mỹ là 4 đội bóng hàng đầu Brazil gồm Palmeiras, Flamengo, Fluminense, Botafogo và 2 thế lực lớn nhất của bóng đá Argentina là Boca Juniors, River Plate. 4 đại diện của châu Á gồm Al-Hilal (Ả Rập Xê Út), Urawa Red Diamonds (Nhật Bản), Al Ain (Các tiểu vương quốc Ả Rập thống nhất), Ulsan Hyundai (Hàn Quốc).</span></p><div><span style=\"font-size: 14px;\">​</span></div>', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748882759981tintuc2.jpg?alt=media&token=de8f1a99-0657-4d03-b5a4-c6482b2d9cba', '2025-06-02 16:46:03', '2025-06-02 16:49:16'),
(4, 'SEA Games 33 là tâm điểm của thể thao Việt Nam 2025', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Trong năm 2025, các huấn luyện viên và vận động viên thể thao Việt Nam sẽ tham dự 3 đại hội thể thao quốc tế lớn. Tâm điểm sẽ là kỳ SEA Games 33 tổ chức tại Thái Lan từ ngày 9 đến ngày 20/12. Kỳ SEA Games năm nay sẽ có tổng cộng 50 môn thi đấu, 104 phân môn, 569 nội dung. Mục tiêu của đoàn thể thao Việt Nam tại SEA Games 33 là giành khoảng 75 đến 85 tấm Huy chương Vàng, đứng ở vị trí top 3 trong bảng tổng sắp huy chương và nếu có thể là vào được top 2. Các môn thể thao trọng điểm thuộc hệ thống thi đấu của Thế vận hội Olympic, Á vận hội ASIAD cần phải có được thành tích cao, cạnh tranh vị trí dẫn đầu ở các bộ môn.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">SEA Games 33 được xem là giải đấu “tạo nguồn” cho thể thao Việt Nam hướng tới ASIAD 2026 và Olympic 2028. Chính vì thế, các môn thể thao trọng điểm, nằm trong nội dung thi đấu của các kỳ đại hội thể thao cấp châu lục và thế giới rất được quan tâm. Đoàn thể thao Việt Nam sẽ có sự sàng lọc, tuyển lựa kỹ càng để chọn ra lực lượng tốt nhất tham dự 14 môn nằm trong nội dung Olympic gồm: Điền kinh, cử tạ, đấu kiếm, boxing, taekwondo, xe đạp, bắn cung, bơi, bắn súng, thể dục, cầu lông, judo, vật, đua thuyền; cùng 3 môn ASIAD là wushu, cầu mây, karatedo.</span></p><div><br></div>', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748882992360tintuc3.webp?alt=media&token=d17a7c3e-45d4-41d6-823e-458c5a89333f', '2025-06-02 16:49:55', '2025-06-02 16:49:55'),
(5, 'Đoạn kết mùa giải buồn cho Kylian Mbappe', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\"><strong>Thất bại toàn diện</strong></span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Các cầu thủ Real Madrid chỉ có thể tự trách mình, khi để thua tại Camp Nou dù đã dẫn trước tới 2-0 chỉ sau có 14 phút thi đấu. Cú đúp sớm của Mbappe tưởng chừng đã mở ra một thế trận tưng bừng cho Los Blancos, giúp họ chấm dứt chuỗi 3 trận toàn thua kình địch Barcelona trong mùa giải này. Thế nhưng tất cả đã xoay chiều từ thời điểm hậu vệ Eric Garcia gỡ lại 1 bàn cho đội bóng xứ Catalan. Chỉ trong vòng 15 phút cuối hiệp 1, hàng công của Barcelona với những cầu thủ đang đạt phong độ rất cao Ferran Torres, Lamine Yamal và Raphinha đã “xé nát” hàng phòng ngự lỏng lẻo của Real Madrid để có cú lội ngược dòng ngay trong nửa đầu trận đấu.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Mbappe đã hoàn tất cú hat-trick đầu tiên của mình trong các trận “siêu kinh điển” ở phút 70, song đó cũng chỉ là bàn thắng giúp Real Madrid rút ngắn cách biệt xuống. Chung cuộc, Real Madrid để thua 3-4 trước Barcelona và gần như đã “giương cờ trắng” trong cuộc đua vô địch. Hiện tại, đội chủ sân Santiago Bernabeu đã kém Barca tới 7 điểm, khi giải đấu chỉ còn 3 vòng đấu nữa. Chỉ cần đội bóng xứ Catalan có thêm một chiến thắng, họ sẽ đăng quang tại La Liga mùa giải này.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Đây là thất bại thứ 4 của Real Madrid trước Barcelona chỉ trong vòng 1 mùa giải. Trước đó, họ đã để thua Barca tại trận lượt đi La Liga với tỷ số 0-4, Siêu Cúp Tây Ban Nha với tỷ số 2-5 và chung kết Cúp Nhà vua với tỷ số 2-3. Như vậy, Los Blancos thủng lưới tổng cộng 16 bàn trong 4 lần gặp Barca mùa này, trung bình 4 bàn/trận! Một thống kê không thể chấp nhận nổi với hệ thống phòng ngự của đội bóng Hoàng gia Tây Ban Nha.</span></p><div><span style=\"font-size: 14px;\">​</span></div>', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748883072863tintuc4.jpg?alt=media&token=81fc4be2-1cc8-4ded-990f-a30a696326b4', '2025-06-02 16:51:15', '2025-06-02 16:51:15'),
(6, 'Inter Milan vào chung kết UEFA Champions League: Sự kính phục dành cho Simone Inzaghi', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\"><strong>Bản lĩnh của người Italia</strong></span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Giống như trận lượt đi tại Camp Nou, trận lượt về tại San Siro đã diễn ra theo một kịch bản mà không một ai có thể đoán trước được. Inter Milan có 2 bàn dẫn trước ngay trong hiệp 1 nhờ công của Lautaro Martinez và Hakan Calhanoglu, nhưng cũng như trận lượt đi, đội bóng Italia đã không thể giữ được lợi thế trước sự vùng lên mạnh mẽ của Barcelona. Đoàn quân của HLV Hansi Flick có 2 bàn gỡ chỉ trong vòng 6 phút (từ phút 54 đến phút 60) do công của Eric Garcia và Dani Olmo.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Đội bóng xứ Catalan đã ở rất gần một cuộc lội ngược dòng kinh điển, khi Raphinha nâng tỷ số lên 3-2 ở phút 87 của trận đấu. Tuy nhiên, kịch tính chỉ được đẩy lên cao trào, khi lão tướng Francesco Arcebi cân bằng tỷ số 3-3 cho Inter ở những phút bù giờ cuối cùng. 2 lượt trận cùng kết thúc với kết quả 3-3 sau 90 phút thi đấu chính thức buộc 2 đội phải đá thêm giờ.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Phút 99, số phận đã lựa chọn cầu thủ dự bị Davide Frattesi là người hùng của Inter. Tiền vệ sinh năm 1999 đã có một tình huống xử lý bình tĩnh, trước khi dứt điểm lạnh lùng vào lưới Barcelona nâng tỷ số lên 4-3. Trong những phút còn lại của hiệp phụ, mọi nỗ lực của đội bóng xứ Catalan đều không thể thắng được thủ môn Yann Sommer. Thủ thành người Thụy Sĩ đã có một trận đấu xuất thần khi cản phá một loạt tình huống dứt điểm nguy hiểm, đặc biệt là những cú sút đến từ tài năng trẻ Lamine Yamal.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; line-height: 20.8px; color: rgb(34, 34, 34); font-family: Roboto, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span style=\"font-size: 14px;\">Trận đấu khép lại với tỷ số 4-3, kết quả giúp Inter có vé vào chung kết với tổng tỷ số 7-6 sau 2 lượt trận. Đây là lần thứ 2 trong 3 mùa giải, Nerazzurri lọt vào trận đấu cuối cùng của giải đấu danh giá nhất châu Âu.</span></p>', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748883138487tintuc5.jpg?alt=media&token=4b06b067-3038-4eda-8d5a-39176d5399d5', '2025-06-02 16:52:21', '2025-06-02 16:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `user_id`, `token`, `expires_at`, `created_at`) VALUES
(1, 1, '3e261778bcaefe94c837eb4831cc4d804d218da0', '2024-03-26 12:10:23', '2024-03-26 11:10:23'),
(2, 1, '2c62d4167e77624d6af9575b6ecad6e3f4d0c406', '2024-05-13 05:33:01', '2024-05-13 04:33:00'),
(3, 1, '43273f4a018f20ac973340ebb8fe1c86d7df2877', '2024-05-13 06:01:36', '2024-05-13 05:01:36');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(255) DEFAULT 'active',
  `item_status` varchar(255) DEFAULT 'new',
  `id_product_type` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `quantity`, `status`, `item_status`, `id_product_type`, `id_user`, `image`) VALUES
(2, 'Nước lavie', 10000.00, 100, 'active', 'new', 4, 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885598180lavie.jpg?alt=media&token=175f20bc-b98d-4b84-b245-494c847e16c4'),
(3, 'bánh mỳ kinh đô', 10000.00, 100, 'active', 'new', 5, 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885629444banhmy.jpg?alt=media&token=228141c2-39fc-448c-880a-839267dc693c'),
(4, 'bimbim', 10000.00, 100, 'active', 'new', 5, 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885658168bimbim.jpg?alt=media&token=05ba8f2f-9819-4bc1-bad7-41bd6c68d0e1'),
(5, 'thuốc lá', 10000.00, 100, 'active', 'new', 6, 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885684700thuocla.jpg?alt=media&token=320ebee7-b319-480e-b22b-709446924555'),
(6, 'Khăn lạnh', 10000.00, 1000, 'active', 'new', 6, 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748885735070khan.jpg?alt=media&token=a8bd684c-79f2-43df-adb2-5011096cefcd');

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE `product_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `product_types`
--

INSERT INTO `product_types` (`id`, `name`, `status`) VALUES
(4, 'Nước uống', 'active'),
(5, 'Đồ ăn', 'active'),
(6, 'Dịch vụ khác', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `residence_rules`
--

CREATE TABLE `residence_rules` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `residence_rules`
--

INSERT INTO `residence_rules` (`id`, `title`, `content`, `created_at`, `updated_at`) VALUES
(2, 'Quy định hệ thống', 'Điều khoản sử dụng\nChào mừng quý khách đến với BookBall – Hệ thống đặt lịch sân bóng trực tuyến.\n\nChúng tôi là Công ty Cổ phần Thể thao BookBall, có trụ sở tại Khoái Châu - Hưng Yên và hiện đang quản lý, vận hành website: https://bookball.vn.\n\nKhi quý khách truy cập và sử dụng website của chúng tôi, đồng nghĩa với việc quý khách đã đồng ý với các Điều khoản sử dụng này. Chúng tôi có quyền thay đổi, chỉnh sửa, bổ sung hoặc loại bỏ bất kỳ nội dung nào trong điều khoản này vào bất kỳ thời điểm nào mà không cần thông báo trước. Các thay đổi sẽ có hiệu lực ngay khi được đăng tải lên website. Khi tiếp tục sử dụng website sau khi có thay đổi, quý khách mặc nhiên đồng ý với các cập nhật đó.\n\nVui lòng kiểm tra thường xuyên để nắm được những thay đổi mới nhất từ chúng tôi.\n\nHướng dẫn sử dụng website\nKhi truy cập website BookBall, quý khách xác nhận đã đủ 18 tuổi hoặc đang sử dụng dịch vụ dưới sự giám sát của cha mẹ hoặc người giám hộ hợp pháp.\n\nBookBall cung cấp cho người dùng một tài khoản cá nhân (Account) để đặt sân, quản lý lịch thi đấu, theo dõi lịch sử giao dịch và sử dụng các tính năng khác trong phạm vi quy định của Điều khoản sử dụng.\n\nKhi đăng ký tài khoản, quý khách cam kết cung cấp thông tin chính xác và cập nhật kịp thời khi có thay đổi. Quý khách có trách nhiệm giữ bảo mật thông tin tài khoản và mật khẩu, đồng thời chịu trách nhiệm với mọi hoạt động diễn ra dưới tài khoản của mình. Nếu phát hiện tài khoản bị sử dụng trái phép, quý khách cần thông báo ngay cho chúng tôi. BookBall không chịu trách nhiệm đối với các tổn thất, thiệt hại phát sinh do việc khách hàng không tuân thủ các quy định trên.\n\nNghiêm cấm sử dụng website này cho mục đích thương mại không được sự cho phép bằng văn bản của chúng tôi hoặc nhân danh bên thứ ba. Nếu vi phạm, BookBall có quyền khóa tài khoản mà không cần thông báo trước.\n\nTrong quá trình sử dụng dịch vụ, quý khách có thể nhận được email thông báo, khuyến mãi hoặc quảng cáo từ hệ thống. Nếu không muốn tiếp tục nhận, quý khách có thể hủy đăng ký qua liên kết ở cuối email.\n\nÝ kiến của khách hàng\nMọi nội dung phản hồi, đánh giá hoặc ý kiến đóng góp từ người dùng gửi về website đều thuộc quyền sở hữu của BookBall. Trong trường hợp phát hiện hành vi gian lận, cung cấp thông tin sai lệch, giả mạo hoặc vi phạm pháp luật, BookBall có quyền tạm khóa hoặc xóa vĩnh viễn tài khoản, và xử lý theo đúng quy định pháp luật hiện hành.', '2025-06-02 16:55:39', '2025-06-02 16:56:37');

-- --------------------------------------------------------

--
-- Table structure for table `tournaments`
--

CREATE TABLE `tournaments` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `info` text DEFAULT NULL,
  `teams` int(11) DEFAULT 0,
  `matches` int(11) DEFAULT 0,
  `group_count` int(11) DEFAULT 0,
  `prizes` int(11) DEFAULT 0,
  `status` varchar(255) DEFAULT 'active',
  `approval_status` varchar(255) DEFAULT 'pending',
  `id_users` int(11) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tournaments`
--

INSERT INTO `tournaments` (`id`, `name`, `info`, `teams`, `matches`, `group_count`, `prizes`, `status`, `approval_status`, `id_users`, `image`) VALUES
(4, 'Giải Bóng Đá Hè 2025', 'Giải phong trào tổ chức cho các đội bóng khu vực nội thành, diễn ra vào tháng 6', 16, 31, 4, 10000, 'active', 'approved', 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886077567gd1.jpg?alt=media&token=51fcb169-9543-41ec-99c0-fac94750b0e3'),
(5, 'Cup Doanh Nghiệp Trẻ', 'Giải đấu dành riêng cho các công ty trẻ tại TP.HCM, tăng cường gắn kết nội bộ.', 12, 22, 3, 15000, 'active', 'approved', 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886116585gd2.webp?alt=media&token=93fd1303-9ed2-44ba-a218-6b61a62626bf'),
(6, 'Giải Sinh Viên Mở Rộng', 'Dành cho các trường đại học và cao đẳng, quy tụ nhiều đội mạnh từ các khối ngành khác nhau.', 24, 47, 6, 20000, 'active', 'approved', 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886155962gd4.jpg?alt=media&token=ec97a19c-fa89-493b-b20b-8df6af07db6f'),
(7, 'Giải Phủi Thành Phố', 'Giải phong trào nổi bật, tổ chức hàng năm, nơi quy tụ các đội bóng phủi mạnh nhất thành phố.', 20, 38, 5, 25000, 'active', 'approved', 6, 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886194769gd5.png?alt=media&token=e22551ca-3523-4821-aef4-54165b358928');

-- --------------------------------------------------------

--
-- Table structure for table `tournament_results`
--

CREATE TABLE `tournament_results` (
  `id` int(11) NOT NULL,
  `tournament_id` int(11) NOT NULL,
  `result_info` text DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tournament_results`
--

INSERT INTO `tournament_results` (`id`, `tournament_id`, `result_info`, `image`) VALUES
(3, 4, 'Trận 1: Đội 1 thắng Đội 2 với tỉ số 2-1 vào ngày 5/6/2025.\n\nTrận 2: Đội 3 và Đội 4 hòa 0-0 ngày 6/6/2025.\n\nTrận 3: Đội 6 đánh bại Đội 5 với tỉ số 3-1.\n\nTrận chung kết: Đội 1 gặp Đội 3 và giành chiến thắng 3-2 ngày 28/6/2025 để lên ngôi vô địch.', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886299107gd1.jpg?alt=media&token=d6259b8a-d714-4deb-88cb-3188cf5d08e1'),
(4, 5, 'Trận khai mạc: Công ty A vượt qua Công ty B với tỉ số sát nút 1-0 ngày 1/7/2025.\n\nTrận 2: Công ty C hòa Công ty D với tỉ số 2-2.\n\nTrận cuối: Công ty C giành chiến thắng trước Công ty A với tỉ số 1-0, trở thành nhà vô địch.', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886319770gd2.webp?alt=media&token=12ac91c2-eaf3-475e-8eab-05c313036904'),
(5, 6, 'Trận mở màn: Đại học A thắng Đại học B 3-1 vào ngày 1/8/2025.\n\nTrận 10: Đại học C thua Đại học D 0-2.\n\nTrận chung kết: Đại học A hòa Đại học D 1-1 và thắng trên loạt đá luân lưu để lên ngôi vô địch.', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886338453gd4.jpg?alt=media&token=5af24576-b16f-474f-91b4-1ed1af40c62d'),
(6, 7, 'Trận 1: FC Phủi 1 và FC Phủi 2 hòa nhau 1-1 ngày 1/9/2025.\nTrận 5: FC Phủi 3 thắng đậm FC Phủi 4 với tỉ số 4-0.\nTrận chung kết: FC Phủi 4 đánh bại FC Phủi 1 với tỉ số 3-0, lên ngôi vô địch.', 'https://firebasestorage.googleapis.com/v0/b/zalo-app-66612.appspot.com/o/1748886367875gd5.png?alt=media&token=15c69342-b64d-4a4d-bd05-58bfa16a4aa5');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'noactive',
  `image` varchar(255) DEFAULT 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `image_qr` varchar(500) DEFAULT 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `phone`, `username`, `password`, `role`, `status`, `image`, `created_at`, `updated_at`, `image_qr`) VALUES
(1, 'levanquang9399@gmail.com', '0938283923', 'Admin', '$2b$10$YXMaxfUoSZhXwfjhyku9befvkdgO/UlSvBJ/ypLdMxE3ewMKAN25C', 'isAdmin', 'actived', 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png', '2024-03-19 06:44:52', '2025-06-02 16:33:37', 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png'),
(6, 'chusan1@gmail.com', '0987654312', 'Chủ sân 1', '$2b$10$vP7pEhhl8mezf0mWVUWLvu585YBUk3RiBZmF8cn7byKI7c9ai4Uli', 'isSeller', 'actived', 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png', '2025-06-02 17:13:55', '2025-06-02 17:13:55', 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png'),
(7, 'chusan2@gmail.com', '0897654231', 'Chủ sân 2', '$2b$10$qwLqqg99maEYRoXj/sTnPOKut3/x5ZnSBtE.uLOI0p0T7Qfd5OIFC', 'isSeller', 'actived', 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png', '2025-06-02 17:15:00', '2025-06-02 17:15:00', 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png'),
(8, 'khachhang1@gmail.com', '0987656312', 'Khách Hàng 1', '$2b$10$JtxYdrolAETG3MfAjDba0eR6p2UIrMvXWxR6qf1YTUkgmckD.68zu', 'isClient', 'actived', 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png', '2025-06-02 17:16:14', '2025-06-02 17:16:14', 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png'),
(9, 'khachhang2@gmail.com', '0987654317', 'Khách Hàng 2', '$2b$10$830s/jBsbyhtZOMJ4sE1kuG1/J/pIxNGsNYDDZdaZdE2wW/cHRRce', 'isClient', 'actived', 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png', '2025-06-02 17:16:44', '2025-06-02 17:16:44', 'https://me-qr.com/data/front/static_preview/651415ebca4c28.80230463.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `court_id` (`court_id`);

--
-- Indexes for table `courts`
--
ALTER TABLE `courts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_areas` (`id_areas`),
  ADD KEY `id_field_types` (`id_field_types`),
  ADD KEY `id_users` (`id_users`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `field_types`
--
ALTER TABLE `field_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_product_type` (`id_product_type`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `residence_rules`
--
ALTER TABLE `residence_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tournaments`
--
ALTER TABLE `tournaments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_users` (`id_users`);

--
-- Indexes for table `tournament_results`
--
ALTER TABLE `tournament_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tournament_id` (`tournament_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `courts`
--
ALTER TABLE `courts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `field_types`
--
ALTER TABLE `field_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `residence_rules`
--
ALTER TABLE `residence_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tournaments`
--
ALTER TABLE `tournaments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tournament_results`
--
ALTER TABLE `tournament_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`court_id`) REFERENCES `courts` (`id`);

--
-- Constraints for table `courts`
--
ALTER TABLE `courts`
  ADD CONSTRAINT `courts_ibfk_1` FOREIGN KEY (`id_areas`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `courts_ibfk_2` FOREIGN KEY (`id_field_types`) REFERENCES `field_types` (`id`),
  ADD CONSTRAINT `courts_ibfk_3` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_product_type`) REFERENCES `product_types` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `tournaments`
--
ALTER TABLE `tournaments`
  ADD CONSTRAINT `tournaments_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`);

--
-- Constraints for table `tournament_results`
--
ALTER TABLE `tournament_results`
  ADD CONSTRAINT `tournament_results_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
