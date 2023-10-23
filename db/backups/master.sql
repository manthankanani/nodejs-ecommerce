-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 17, 2022 at 03:27 PM
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_marketing_emails`
--
ALTER TABLE `qt_marketing_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_partner`
--
ALTER TABLE `qt_partner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_partnermeta`
--
ALTER TABLE `qt_partnermeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_partners_address`
--
ALTER TABLE `qt_partners_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_store`
--
ALTER TABLE `qt_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_storemeta`
--
ALTER TABLE `qt_storemeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
