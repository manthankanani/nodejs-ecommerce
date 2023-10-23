-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2023 at 07:27 AM
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
-- Database: `qt_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `qt_categories`
--

CREATE TABLE `qt_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category_type` varchar(100) NOT NULL COMMENT 'blog, news',
  `author_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_categorymeta`
--

CREATE TABLE `qt_categorymeta` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_ordermeta`
--

CREATE TABLE `qt_ordermeta` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_orders`
--

CREATE TABLE `qt_orders` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `total` decimal(10,3) NOT NULL,
  `coupon_ids` mediumtext NOT NULL COMMENT 'CSVs',
  `user_id` int(11) NOT NULL,
  `billing_id` varchar(100) NOT NULL,
  `shippingaddress_id` int(11) NOT NULL,
  `billingaddress_id` int(11) NOT NULL,
  `shipping_status` int(1) NOT NULL COMMENT '0:draft\r\n1:processing\r\n2:onhold\r\n4:dispatched\r\n6:clearance\r\n7:in-transit\r\n8:delivered\r\n9:rejected',
  `return_status` int(1) NOT NULL COMMENT '1:normal\r\n2:return\r\n3:replacement',
  `payment_status` int(1) NOT NULL COMMENT '0:rejected\r\n1:processing\r\n2:pending\r\n3:recieved\r\n4:refunded',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_order_billingmeta`
--

CREATE TABLE `qt_order_billingmeta` (
  `id` int(11) NOT NULL,
  `billing_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_order_billings`
--

CREATE TABLE `qt_order_billings` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `ref_id` varchar(255) NOT NULL,
  `total` decimal(10,3) NOT NULL COMMENT 'including taxes',
  `billing_method` varchar(15) NOT NULL,
  `payment_provider` varchar(255) NOT NULL COMMENT 'https://en.wikipedia.org/wiki/List_of_online_payment_service_providers',
  `customer_ip` varchar(40) NOT NULL COMMENT 'ipv4:15\r\nipv6:39',
  `customer_useragent` varchar(255) NOT NULL,
  `created_at` int(16) NOT NULL,
  `modified_at` int(16) NOT NULL,
  `deleted_at` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_order_itemmeta`
--

CREATE TABLE `qt_order_itemmeta` (
  `id` int(11) NOT NULL,
  `orderitem_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_order_items`
--

CREATE TABLE `qt_order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `total` decimal(10,3) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_order_notes`
--

CREATE TABLE `qt_order_notes` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `is_adminnote` int(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `privacy` int(1) NOT NULL COMMENT '1:public\r\n2:private',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_postmeta`
--

CREATE TABLE `qt_postmeta` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_posts`
--

CREATE TABLE `qt_posts` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `short_description` text NOT NULL,
  `content` longtext NOT NULL COMMENT 'dynamic in html',
  `post_type` int(1) NOT NULL COMMENT '1:blog\r\n2:news',
  `comment_status` int(1) NOT NULL COMMENT '0:disabled\r\n1:enabled',
  `parent_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `status` int(1) NOT NULL COMMENT '0:draft\r\n1:published\r\n2:scheduled\r\n3:\r\n4:trashed',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_post_commentmeta`
--

CREATE TABLE `qt_post_commentmeta` (
  `id` int(11) NOT NULL,
  `post_comment_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_post_comments`
--

CREATE TABLE `qt_post_comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_email` varchar(255) NOT NULL,
  `author_ip` varchar(40) NOT NULL COMMENT 'ipv4:15\r\nipv6:39',
  `content` text NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `status` int(1) NOT NULL COMMENT '1:new\r\n2:approved\r\n3:rejected\r\n4:trashed',
  `parent_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_productmeta`
--

CREATE TABLE `qt_productmeta` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_products`
--

CREATE TABLE `qt_products` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sku` varchar(30) NOT NULL,
  `price` decimal(10,3) NOT NULL,
  `content` text NOT NULL COMMENT 'dynamic in html',
  `physical_type` int(1) NOT NULL COMMENT '1-virtual\r\n2-downloadable',
  `product_type` int(1) NOT NULL COMMENT '1:simple,\r\n2:variable,\r\n3:grouped,\r\n4:affiliated,\r\n5:learnpress',
  `review_status` int(1) NOT NULL COMMENT '0:disabled\r\n1:enabled',
  `parent_id` int(11) NOT NULL COMMENT 'for all variants',
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL,
  `status` int(1) NOT NULL COMMENT '0:draft\r\n1:published\r\n2:scheduled\r\n3:\r\n4:trashed',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_attributes`
--

CREATE TABLE `qt_product_attributes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `parent_id` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_cart`
--

CREATE TABLE `qt_product_cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL COMMENT 'product_aa*4=4,\r\nproduct_b*3=3.\r\nbut counted as number_products 2',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_cart_lineitemmeta`
--

CREATE TABLE `qt_product_cart_lineitemmeta` (
  `id` int(11) NOT NULL,
  `cart_lineitem_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_cart_lineitems`
--

CREATE TABLE `qt_product_cart_lineitems` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL COMMENT 'normally variation id',
  `qty` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_categories`
--

CREATE TABLE `qt_product_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category_type` varchar(100) NOT NULL COMMENT 'collections,tags,',
  `author_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_categorymeta`
--

CREATE TABLE `qt_product_categorymeta` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_couponmeta`
--

CREATE TABLE `qt_product_couponmeta` (
  `id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_coupons`
--

CREATE TABLE `qt_product_coupons` (
  `id` int(11) NOT NULL,
  `coupon_code` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `coupon_type` int(1) NOT NULL COMMENT '1:percent\r\n2:fixed_cart\r\n3:fixed_product',
  `coupon_amount` decimal(10,3) NOT NULL,
  `free_shipping` int(1) NOT NULL COMMENT 'if coupon grants free shipping',
  `expiry_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'YYYY-MM-DD',
  `min_spend` decimal(10,3) NOT NULL,
  `max_spend` decimal(10,3) NOT NULL,
  `individual_use` int(1) NOT NULL COMMENT 'if coupon cannot be used with other coupons',
  `exclude_sale_items` int(1) NOT NULL COMMENT 'if the coupon should not apply on sale items.',
  `include_products` text NOT NULL,
  `exclude_products` text NOT NULL,
  `product_category` text NOT NULL,
  `exclude_category` text NOT NULL,
  `allowed_emails` text NOT NULL COMMENT 'allowed emails to checkwhen an order is placed. Separate email addresses with commas. You can also use an asterisk (*) to match parts of an email. For example "*@gmail.com" would match all gmail addresses.',
  `is_used` int(1) NOT NULL COMMENT 'change this flag to 1 if coupon used limit reached',
  `usage_limit` int(11) NOT NULL COMMENT 'Times this coupon can be used before it is void',
  `applied_max_products` int(11) NOT NULL COMMENT 'Maximum number of individual items this coupon can apply to when using product discounts. Leave blank to apply to all qualifying items in cart',
  `per_user_limit` int(11) NOT NULL COMMENT 'How many times this coupon can be used by an individual user. Uses billing email for guests, and user ID for logged in users',
  `status` int(1) NOT NULL COMMENT '0:draft \r\n1:published 2:scheduled \r\n3: \r\n4:trashed',
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_inventory`
--

CREATE TABLE `qt_product_inventory` (
  `id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` text NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_inventorymeta`
--

CREATE TABLE `qt_product_inventorymeta` (
  `id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_reviewmeta`
--

CREATE TABLE `qt_product_reviewmeta` (
  `id` int(11) NOT NULL,
  `product_review_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_reviews`
--

CREATE TABLE `qt_product_reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_email` varchar(255) NOT NULL,
  `author_ip` varchar(40) NOT NULL COMMENT 'ipv4:15\r\nipv6:39',
  `content` text NOT NULL,
  `rating` int(3) NOT NULL COMMENT 'out of 10',
  `user_agent` varchar(255) NOT NULL,
  `status` int(1) NOT NULL COMMENT '1:new\r\n2:approved\r\n3:rejected\r\n4:trashed',
  `parent_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_warehouses`
--

CREATE TABLE `qt_product_warehouses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postal_code` varchar(15) NOT NULL,
  `country` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `status` int(1) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_product_warehousesmeta`
--

CREATE TABLE `qt_product_warehousesmeta` (
  `id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_savedcards`
--

CREATE TABLE `qt_savedcards` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_type` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL COMMENT 'https://en.wikipedia.org/wiki/List_of_online_payment_service_providers',
  `name_on_card` varchar(100) NOT NULL,
  `card_no` int(20) NOT NULL COMMENT '8-19 digits',
  `expiry` varchar(7) NOT NULL COMMENT 'm-Y',
  `status` int(1) NOT NULL DEFAULT 1,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_settings`
--

CREATE TABLE `qt_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` longtext NOT NULL,
  `global` int(1) NOT NULL COMMENT 'check if to load globally'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_usermeta`
--

CREATE TABLE `qt_usermeta` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `meta_key` varchar(20) NOT NULL,
  `meta_value` longtext NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'useless here',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'useless here'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_users`
--

CREATE TABLE `qt_users` (
  `id` int(11) NOT NULL,
  `username` varchar(60) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `capability` int(3) NOT NULL DEFAULT 99 COMMENT '1=admin,\r\n2=subadmin,\r\n3=shopowner,\r\n4=shopmanager,\r\n5=productmanager,\r\n6=inventorymanager,\r\n\r\n19=customer,\r\n99=subscriber',
  `nickname` varchar(250) NOT NULL DEFAULT 'User',
  `activation_key` varchar(255) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 0,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qt_users_address`
--

CREATE TABLE `qt_users_address` (
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
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `qt_categories`
--
ALTER TABLE `qt_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `category_type` (`category_type`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `qt_categorymeta`
--
ALTER TABLE `qt_categorymeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_ordermeta`
--
ALTER TABLE `qt_ordermeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_orders`
--
ALTER TABLE `qt_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `payment_id` (`billing_id`),
  ADD KEY `useraddress_id` (`shippingaddress_id`),
  ADD KEY `billingaddress_id` (`billingaddress_id`);

--
-- Indexes for table `qt_order_billingmeta`
--
ALTER TABLE `qt_order_billingmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billing_id` (`billing_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_order_billings`
--
ALTER TABLE `qt_order_billings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `txn_id` (`txn_id`,`payment_id`,`ref_id`);

--
-- Indexes for table `qt_order_itemmeta`
--
ALTER TABLE `qt_order_itemmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderitem_id` (`orderitem_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_order_items`
--
ALTER TABLE `qt_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `qt_order_notes`
--
ALTER TABLE `qt_order_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `qt_postmeta`
--
ALTER TABLE `qt_postmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_posts`
--
ALTER TABLE `qt_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_type` (`post_type`),
  ADD KEY `parent_id` (`parent_id`,`author_id`,`category_id`,`status`);

--
-- Indexes for table `qt_post_commentmeta`
--
ALTER TABLE `qt_post_commentmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_comment_id` (`post_comment_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_post_comments`
--
ALTER TABLE `qt_post_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`post_id`);

--
-- Indexes for table `qt_productmeta`
--
ALTER TABLE `qt_productmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_products`
--
ALTER TABLE `qt_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `inventory_id` (`inventory_id`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `discount_id` (`discount_id`),
  ADD KEY `status` (`status`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `qt_product_attributes`
--
ALTER TABLE `qt_product_attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `qt_product_cart`
--
ALTER TABLE `qt_product_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `qt_product_cart_lineitemmeta`
--
ALTER TABLE `qt_product_cart_lineitemmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_lineitem_id` (`cart_lineitem_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_product_cart_lineitems`
--
ALTER TABLE `qt_product_cart_lineitems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qt_product_categories`
--
ALTER TABLE `qt_product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `category_type` (`category_type`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `qt_product_categorymeta`
--
ALTER TABLE `qt_product_categorymeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_product_couponmeta`
--
ALTER TABLE `qt_product_couponmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupon_id` (`coupon_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_product_coupons`
--
ALTER TABLE `qt_product_coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupon_code` (`coupon_code`);

--
-- Indexes for table `qt_product_inventory`
--
ALTER TABLE `qt_product_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `location_id` (`warehouse_id`);

--
-- Indexes for table `qt_product_inventorymeta`
--
ALTER TABLE `qt_product_inventorymeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_id` (`inventory_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_product_reviewmeta`
--
ALTER TABLE `qt_product_reviewmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_review_id` (`product_review_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_product_reviews`
--
ALTER TABLE `qt_product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `qt_product_warehouses`
--
ALTER TABLE `qt_product_warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `qt_product_warehousesmeta`
--
ALTER TABLE `qt_product_warehousesmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_id` (`warehouse_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_savedcards`
--
ALTER TABLE `qt_savedcards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `qt_settings`
--
ALTER TABLE `qt_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `global` (`global`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `qt_usermeta`
--
ALTER TABLE `qt_usermeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `qt_users`
--
ALTER TABLE `qt_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`email`),
  ADD KEY `capability` (`capability`);

--
-- Indexes for table `qt_users_address`
--
ALTER TABLE `qt_users_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `qt_categories`
--
ALTER TABLE `qt_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_categorymeta`
--
ALTER TABLE `qt_categorymeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_ordermeta`
--
ALTER TABLE `qt_ordermeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_orders`
--
ALTER TABLE `qt_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_order_billingmeta`
--
ALTER TABLE `qt_order_billingmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_order_billings`
--
ALTER TABLE `qt_order_billings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_order_itemmeta`
--
ALTER TABLE `qt_order_itemmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_order_items`
--
ALTER TABLE `qt_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_order_notes`
--
ALTER TABLE `qt_order_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_postmeta`
--
ALTER TABLE `qt_postmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_posts`
--
ALTER TABLE `qt_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_post_commentmeta`
--
ALTER TABLE `qt_post_commentmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_post_comments`
--
ALTER TABLE `qt_post_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_productmeta`
--
ALTER TABLE `qt_productmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_products`
--
ALTER TABLE `qt_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_attributes`
--
ALTER TABLE `qt_product_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_cart`
--
ALTER TABLE `qt_product_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_cart_lineitemmeta`
--
ALTER TABLE `qt_product_cart_lineitemmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_cart_lineitems`
--
ALTER TABLE `qt_product_cart_lineitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_categories`
--
ALTER TABLE `qt_product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_categorymeta`
--
ALTER TABLE `qt_product_categorymeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_couponmeta`
--
ALTER TABLE `qt_product_couponmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_coupons`
--
ALTER TABLE `qt_product_coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_inventory`
--
ALTER TABLE `qt_product_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_inventorymeta`
--
ALTER TABLE `qt_product_inventorymeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_reviewmeta`
--
ALTER TABLE `qt_product_reviewmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_reviews`
--
ALTER TABLE `qt_product_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_warehouses`
--
ALTER TABLE `qt_product_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_product_warehousesmeta`
--
ALTER TABLE `qt_product_warehousesmeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_savedcards`
--
ALTER TABLE `qt_savedcards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_settings`
--
ALTER TABLE `qt_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_usermeta`
--
ALTER TABLE `qt_usermeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_users`
--
ALTER TABLE `qt_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qt_users_address`
--
ALTER TABLE `qt_users_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
