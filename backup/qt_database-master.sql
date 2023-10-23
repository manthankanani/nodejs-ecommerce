-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2023 at 07:28 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qt_database-master`
--

-- --------------------------------------------------------

--
-- Table structure for table `qt_database`
--

CREATE TABLE `qt_database` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `dbhost` char(32) NOT NULL,
  `dbuser` char(32) NOT NULL,
  `dbpass` char(255) NOT NULL,
  `dbname` char(32) NOT NULL,
  `dbprefix` char(10) NOT NULL COMMENT 'text will be added before all database table',
  `is_master` tinyint(1) NOT NULL COMMENT 'check whether the table is for master',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qt_database`
--

INSERT INTO `qt_database` (`id`, `partner_id`, `store_id`, `dbhost`, `dbuser`, `dbpass`, `dbname`, `dbprefix`, `is_master`, `modified_at`, `created_at`) VALUES
(15, 56, 29, 'localhost', 'YAzlTDnneM1nyJHP', 'phtth8Xq80sosIyu', 'javelin rods', 'qt-', 0, '2022-12-23 05:35:25', '2022-12-23 05:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `qt_marketing_emails`
--

CREATE TABLE `qt_marketing_emails` (
  `id` int(11) NOT NULL,
  `type` char(255) NOT NULL COMMENT 'template_type',
  `template_data` tinytext NOT NULL,
  `to_email` char(255) NOT NULL,
  `from_email` char(255) NOT NULL,
  `isread` tinyint(1) NOT NULL DEFAULT 0,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qt_marketing_emails`
--

INSERT INTO `qt_marketing_emails` (`id`, `type`, `template_data`, `to_email`, `from_email`, `isread`, `modified_at`, `created_at`) VALUES
(1, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:17:31', '2022-11-14 07:17:31'),
(2, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:26:32', '2022-11-14 07:26:32'),
(3, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:26:45', '2022-11-14 07:26:45'),
(4, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:31:03', '2022-11-14 07:31:03'),
(5, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:31:33', '2022-11-14 07:31:33'),
(6, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:31:56', '2022-11-14 07:31:56'),
(7, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:32:35', '2022-11-14 07:32:35'),
(8, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:33:11', '2022-11-14 07:33:11'),
(9, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:33:40', '2022-11-14 07:33:40'),
(10, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:35:36', '2022-11-14 07:35:36'),
(11, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:35:54', '2022-11-14 07:35:54'),
(12, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:36:04', '2022-11-14 07:36:04'),
(13, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:36:46', '2022-11-14 07:36:46'),
(14, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:37:00', '2022-11-14 07:37:00'),
(15, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:37:59', '2022-11-14 07:37:59'),
(16, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:38:26', '2022-11-14 07:38:26'),
(17, 'email', 'data', 'to', 'from', 0, '2022-11-14 07:39:05', '2022-11-14 07:39:05'),
(18, 'email', 'data', 'to', 'from', 0, '2022-11-14 09:02:08', '2022-11-14 09:02:08'),
(19, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:37:55', '2022-11-19 10:37:55'),
(20, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:38:47', '2022-11-19 10:38:47'),
(21, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:39:33', '2022-11-19 10:39:33'),
(22, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:40:28', '2022-11-19 10:40:28'),
(23, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:41:28', '2022-11-19 10:41:28'),
(24, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:43:39', '2022-11-19 10:43:39'),
(25, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:44:06', '2022-11-19 10:44:06'),
(26, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:54:11', '2022-11-19 10:54:11'),
(27, 'email', 'data', 'to', 'from', 0, '2022-11-19 10:55:51', '2022-11-19 10:55:51'),
(28, 'email', 'data', 'to', 'from', 0, '2022-11-19 11:09:23', '2022-11-19 11:09:23'),
(29, 'email', 'data', 'to', 'from', 0, '2022-11-19 11:10:23', '2022-11-19 11:10:23'),
(30, 'email', 'data', 'to', 'from', 0, '2022-11-19 11:33:00', '2022-11-19 11:33:00'),
(31, 'email', 'data', 'to', 'from', 0, '2022-11-19 11:33:35', '2022-11-19 11:33:35'),
(32, 'email', 'data', 'to', 'from', 0, '2022-11-19 11:35:19', '2022-11-19 11:35:19'),
(33, 'email', 'data', 'to', 'from', 0, '2022-11-19 11:35:40', '2022-11-19 11:35:40'),
(34, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:01:09', '2022-11-19 12:01:09'),
(35, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:01:42', '2022-11-19 12:01:42'),
(36, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:02:17', '2022-11-19 12:02:17'),
(37, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:07:05', '2022-11-19 12:07:05'),
(38, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:08:51', '2022-11-19 12:08:51'),
(39, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:11:33', '2022-11-19 12:11:33'),
(40, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:17:05', '2022-11-19 12:17:05'),
(41, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:23:19', '2022-11-19 12:23:19'),
(42, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:26:26', '2022-11-19 12:26:26'),
(43, 'email', 'data', 'to', 'from', 0, '2022-11-19 12:28:12', '2022-11-19 12:28:12'),
(44, 'email', 'data', 'to', 'from', 0, '2022-12-23 05:35:25', '2022-12-23 05:35:25'),
(45, 'email', 'data', 'to', 'from', 0, '2023-07-18 08:23:59', '2023-07-18 08:23:59');

-- --------------------------------------------------------

--
-- Table structure for table `qt_partner`
--

CREATE TABLE `qt_partner` (
  `id` int(11) NOT NULL,
  `username` varchar(60) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `capability` int(3) NOT NULL DEFAULT 99 COMMENT '1:superuser,\r\n2:admin,\r\n3:subadmin,\r\n99:custom',
  `nickname` varchar(250) NOT NULL DEFAULT 'User',
  `activation_key` varchar(255) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1:active,\r\n2:blocked,\r\n3:unverified\r\n',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qt_partner`
--

INSERT INTO `qt_partner` (`id`, `username`, `password`, `email`, `capability`, `nickname`, `activation_key`, `status`, `modified_at`, `created_at`) VALUES
(1, 'manthan', '$2a$08$XC2rAUHnwBVI4fszKsTjYufmWlPXTtuV/Hvfk0dCYvPv4RwGH2ufG', 'manthan@qwerytechnolabs.com', 1, 'Manthan ', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1hbnRoYW5AcmVudGVjaGRpZ2l0YWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjY3OTA3MTA0LCJleHAiOjE2Njc5OTM1MDR9.Et-fhUKfE1gLNf3nASQ3CzCX3vhyQMt-tHEHSAMB8n4', 1, '2022-11-08 11:31:44', '2022-11-08 11:31:44'),
(56, 'manthan1', '$2a$08$Cyu1dhH4bSYrbK755cHOguz0lXnoJnoDbA3rmUcdr2ikOLDzXgTb2', 'manthan1@qwerytechnolabs.com', 1, 'Manthan', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1hbnRoYW4xQHJlbnRlY2hkaWdpdGFsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2Nzk4NjYzMCwiZXhwIjoxNjY4MDczMDMwfQ.S0gRFo5hoGYOpe_SKl4RDKu3xigHQnZJoCXZJzV-FnY', 1, '2022-11-09 09:37:10', '2022-11-09 09:37:10'),
(57, 'manthan2', '$2a$08$wmfvNWywslS7IeEdBLWQte1SN/iUlgdVMamr3GNzHq8HxygWVPP7K', 'manthan2@qwerytechnolabs.com', 1, 'Manthan', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1hbnRoYW4yQHJlbnRlY2hkaWdpdGFsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2Nzk4NjczMiwiZXhwIjoxNjY4MDczMTMyfQ.8bXjY390oy00KzHNlL7o6ZOcdk6M9wTX5yYC_5Rp9Kg', 1, '2022-11-09 09:38:52', '2022-11-09 09:38:52'),
(58, 'manthan33', '$2a$08$wmfvNWywslS7IeEdBLWQte1SN/iUlgdVMamr3GNzHq8HxygWVPP7K', 'manthan33@qwerytechnolabs.com', 1, 'Hello Dear', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1hbnRoYW4yQHJlbnRlY2hkaWdpdGFsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2Nzk4NjczMiwiZXhwIjoxNjY4MDczMTMyfQ.8bXjY390oy00KzHNlL7o6ZOcdk6M9wTX5yYC_5Rp9Kg', 1, '2022-11-11 13:30:26', '2022-11-09 09:40:13'),
(65, 'manthan34', '$2a$08$5alWrNjvrpj9sl4HBh3lM.6qeCfmJWEtKKm4oHxENry1AgiQHgo3O', 'manthan34@qwerytechnolabs.com', 1, 'Manthan Bla', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1hbnRoYW4zNEByZW50ZWNoZGlnaXRhbC5jb20iLCJyb2xlX2lkIjoxLCJpYXQiOjE2Njg0MTAyNTEsImV4cCI6MTY2ODQ5NjY1MX0.AA7grFpKEa_qh48FAojO5Cwzdvhe_UrLiUIKtWBYD_I', 3, '2022-11-14 07:17:31', '2022-11-14 07:17:31');

-- --------------------------------------------------------

--
-- Table structure for table `qt_partnermeta`
--

CREATE TABLE `qt_partnermeta` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qt_partnermeta`
--

INSERT INTO `qt_partnermeta` (`id`, `partner_id`, `meta_key`, `meta_value`, `modified_at`, `created_at`) VALUES
(1, 1, 'abc', 'Hello meta abc for user 1', '2022-11-09 06:29:16', '2022-11-09 06:28:25'),
(3, 1, 'bcd', 'Hello meta bcd for user 1', '2022-11-09 06:29:01', '2022-11-09 06:29:01'),
(8, 56, 'fname', 'Manthan', '2022-11-09 09:37:10', '2022-11-09 09:37:10'),
(9, 57, 'fname', 'Manthan', '2022-11-09 09:38:52', '2022-11-09 09:38:52'),
(10, 57, 'lname', '', '2022-11-09 09:38:52', '2022-11-09 09:38:52'),
(11, 58, 'fname', 'Hello', '2022-11-09 13:38:21', '2022-11-09 09:40:13'),
(12, 58, 'lname', 'Dears', '2022-11-09 13:38:43', '2022-11-09 09:40:13'),
(17, 65, 'fname', 'Manthan', '2022-11-14 07:17:31', '2022-11-14 07:17:31'),
(18, 65, 'lname', 'Bla', '2022-11-14 07:17:31', '2022-11-14 07:17:31');

-- --------------------------------------------------------

--
-- Table structure for table `qt_partners_address`
--

CREATE TABLE `qt_partners_address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postal_code` varchar(15) NOT NULL,
  `country` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0:temporary\r\n1:stored',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_store`
--

CREATE TABLE `qt_store` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  `slug` tinytext NOT NULL,
  `status` int(1) NOT NULL COMMENT '1:active,\r\n2:pending,\r\n3:scheduled,\r\n4:rejected,\r\n5:blocked',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qt_store`
--

INSERT INTO `qt_store` (`id`, `partner_id`, `name`, `slug`, `status`, `modified_at`, `created_at`) VALUES
(29, 56, 'Javelin Rods', 'javelin-rods', 1, '2022-12-23 05:35:25', '2022-12-23 05:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `qt_storemeta`
--

CREATE TABLE `qt_storemeta` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `qt_database`
--
ALTER TABLE `qt_database`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dbname` (`dbname`),
  ADD UNIQUE KEY `dbuser` (`dbuser`),
  ADD KEY `partner_id` (`partner_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `qt_marketing_emails`
--
ALTER TABLE `qt_marketing_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qt_partner`
--
ALTER TABLE `qt_partner`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `capability` (`capability`);

--
-- Indexes for table `qt_partnermeta`
--
ALTER TABLE `qt_partnermeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`partner_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_partners_address`
--
ALTER TABLE `qt_partners_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `qt_store`
--
ALTER TABLE `qt_store`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`) USING HASH,
  ADD KEY `user_id` (`partner_id`);

--
-- Indexes for table `qt_storemeta`
--
ALTER TABLE `qt_storemeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `qt_database`
--
ALTER TABLE `qt_database`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `qt_marketing_emails`
--
ALTER TABLE `qt_marketing_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `qt_partner`
--
ALTER TABLE `qt_partner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `qt_partnermeta`
--
ALTER TABLE `qt_partnermeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `qt_partners_address`
--
ALTER TABLE `qt_partners_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_store`
--
ALTER TABLE `qt_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `qt_storemeta`
--
ALTER TABLE `qt_storemeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
