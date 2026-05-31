-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2026 at 12:25 PM
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
-- Database: `carnest`
--

-- --------------------------------------------------------

--
-- Table structure for table `evaluate`
--

CREATE TABLE `evaluate` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `type` text DEFAULT NULL,
  `year` text DEFAULT NULL,
  `km` text DEFAULT NULL,
  `fuel` text DEFAULT NULL,
  `price` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `seller_email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluate`
--

INSERT INTO `evaluate` (`id`, `name`, `location`, `type`, `year`, `km`, `fuel`, `price`, `user_id`, `seller_email`) VALUES
(2, 'TATA Nexon', 'Chennai', 'Manual', '2024', '0 - 10,000 km', 'Petrol', '₹ 8.55 L - ₹ 9.45 L', NULL, 'sai@gmail.com'),
(3, 'HONDA City', 'Agra', 'Manual', '2024', '30,000 - 40,000 km', 'Diesel', '₹ 10.24 L - ₹ 11.32 L', NULL, 'sai@gmail.com'),
(9, 'HYUNDAI Creta', 'Bhopal', 'Automatic', '2023', '20,000 - 30,000 km', 'Electric', '₹ 8.44 L - ₹ 9.32 L', NULL, 'sai@gmail.com'),
(12, 'SUZUKI Swift', 'Mumbai', 'Manual', '2021', '30,000 - 40,000 km', 'Petrol', '₹ 6.04 L - ₹ 6.68 L', NULL, 'jazimj77@gmail.com'),
(17, 'HYUNDAI Creta', 'Agra', 'Automatic', '2023', '10,000 - 20,000 km', 'Petrol', '₹ 9.01 L - ₹ 9.95 L', NULL, 'jazimj77@gmail.com'),
(18, 'SUZUKI Swift', 'Chennai', 'Manual', '2022', '20,000 - 30,000 km', 'Petrol', '₹ 7.52 L - ₹ 8.32 L', NULL, 'jazimj77@gmail.com'),
(19, 'HYUNDAI Creta', 'Chennai', 'Manual', '2023', '20,000 - 30,000 km', 'Diesel', '₹ 8.44 L - ₹ 9.32 L', NULL, 'jazimj77@gmail.com'),
(21, 'TOYOTA Innova Crysta', 'Agra', 'Manual', '2023', '10,000 - 20,000 km', 'Petrol', '₹ 12.01 L - ₹ 13.27 L', NULL, 'sam@gmail.com'),
(22, 'HYUNDAI Creta', 'Chennai', 'Manual', '2024', '0 - 10,000 km', 'Petrol', '₹ 10.49 L - ₹ 11.59 L', NULL, 'jazimj77@gmail.com'),
(23, 'HYUNDAI Venue', 'Agra', 'Manual', '2021', '0 - 10,000 km', 'Petrol', '₹ 7.75 L - ₹ 8.57 L', NULL, 'jazimj77@gmail.com'),
(25, 'TOYOTA Innova Crysta', 'Chennai', 'Automatic', '2021', '50,000 - 60,000 km', 'Petrol', '₹ 5.32 L - ₹ 5.88 L', 9, 'jazzy27247@gmail.com'),
(28, 'HYUNDAI Creta', 'Chandigarh', 'Manual', '2024', '20,000 - 30,000 km', 'Diesel', '₹ 8.44 L - ₹ 9.32 L', NULL, 'jazzy27247@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `recent`
--

CREATE TABLE `recent` (
  `email` text DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recent`
--

INSERT INTO `recent` (`email`, `id`) VALUES
('sai@gmail.com', 5),
('sai@gmail.com', 6),
('jazimj77@gmail.com', 7),
('jazimj77@gmail.com', 8),
('jazimj77@gmail.com', 9),
('jazimj77@gmail.com', 10),
('jazimj77@gmail.com', 11),
('jazimj77@gmail.com', 12),
('jazimj77@gmail.com', 13),
('jazimj77@gmail.com', 14),
('jazimj77@gmail.com', 15),
('jazimj77@gmail.com', 16),
('jazimj77@gmail.com', 17),
('jazimj77@gmail.com', 18),
('jazimj77@gmail.com', 19),
('jazimj77@gmail.com', 20),
('jazimj77@gmail.com', 21),
('jazimj77@gmail.com', 22),
('jazimj77@gmail.com', 23),
('jazimj77@gmail.com', 24),
('jazimj77@gmail.com', 25),
('jazimj77@gmail.com', 26),
('sam@gmail.com', 28),
('sam@gmail.com', 29),
('jazimj77@gmail.com', 30),
('jazimj77@gmail.com', 31),
('jazimj77@gmail.com', 32),
('jazimj77@gmail.com', 33),
('jazimj77@gmail.com', 34),
('jazimj77@gmail.com', 35),
('jazimj77@gmail.com', 36),
('jazimj77@gmail.com', 37),
('sam@gmail.com', 38),
('jazimj77@gmail.com', 39),
('sam@gmail.com', 40),
('jazimj77@gmail.com', 41),
('jazimj77@gmail.com', 42),
('jazimj77@gmail.com', 43),
('jazimj77@gmail.com', 44),
('jazzy27247@gmail.com', 45),
('jazzy27247@gmail.com', 46),
('jazzy27247@gmail.com', 47),
('jazzy27247@gmail.com', 48),
('jazzy27247@gmail.com', 49);

-- --------------------------------------------------------

--
-- Table structure for table `userdetails`
--

CREATE TABLE `userdetails` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `mobilenumber` text DEFAULT NULL,
  `location` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userdetails`
--

INSERT INTO `userdetails` (`id`, `name`, `email`, `password`, `mobilenumber`, `location`) VALUES
(3, 'sai', 'sai@gmail.com', '$2b$12$OvnLVNdV7OAFjn3IdifkH.SoqrP1usFU/G3EixeN5921Fa8toffAm', '9840310764', 'Chennai'),
(7, 'Jazim', 'jazimj77@gmail.com', '$2b$12$dsz.hAUzUXMSZM0iEKmMAeBqP.28g.6hBOXDGKWigBEXPatluLyUO', '9566086954', 'Chennai'),
(8, 'Sam S', 'sam@gmail.com', '$2b$12$35v2Jt2ahqvCOR8E4jCl/ekB9Y.fsEYPCN1ZTMiaLVklXJZF/DF7W', '8148377003', 'Chennai'),
(9, 'Jerina', 'jazzy27247@gmail.com', '$2b$12$t8GI.2A7Ta3ATJr7l7Ih9eRQB66gtQYnPHu2OTnqtriu96HWWMuIa', '8148377003', 'Chennai');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `evaluate`
--
ALTER TABLE `evaluate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recent`
--
ALTER TABLE `recent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userdetails`
--
ALTER TABLE `userdetails`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `evaluate`
--
ALTER TABLE `evaluate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `recent`
--
ALTER TABLE `recent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `userdetails`
--
ALTER TABLE `userdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `evaluate`
--
ALTER TABLE `evaluate`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `userdetails` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
