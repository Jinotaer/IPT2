-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 01:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_bnhs`
--

-- --------------------------------------------------------

--
-- Table structure for table `bnhs_admin`
--

CREATE TABLE `bnhs_admin` (
  `admin_id` varchar(15) NOT NULL,
  `admin_name` varchar(255) DEFAULT NULL,
  `admin_email` varchar(255) DEFAULT NULL,
  `admin_password` varchar(255) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE current_timestamp(6),
  `resetcode` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bnhs_admin`
--

INSERT INTO `bnhs_admin` (`admin_id`, `admin_name`, `admin_email`, `admin_password`, `created_at`, `resetcode`) VALUES
('2301105555', 'admin', 'admnstrator23@gmail.com', '5f32e74898dfb34f00e92e7a7dbedf5cad150725', '2025-05-19 23:52:33.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bnhs_staff`
--

CREATE TABLE `bnhs_staff` (
  `staff_id` varchar(15) NOT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `staff_email` varchar(255) DEFAULT NULL,
  `staff_password` varchar(255) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `resetcode` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bnhs_staff`
--

INSERT INTO `bnhs_staff` (`staff_id`, `staff_name`, `staff_email`, `staff_password`, `created_at`, `resetcode`) VALUES
('2301106543', 'User', 'u7382361@gmail.com', '6d52133401ed979376fdf60a8b7c7a461a2188de', '2025-05-20 05:48:38.346013', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `entities`
--

CREATE TABLE `entities` (
  `entity_id` int(11) NOT NULL,
  `entity_name` varchar(100) NOT NULL,
  `fund_cluster` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `entities`
--

INSERT INTO `entities` (`entity_id`, `entity_name`, `fund_cluster`, `created_at`, `updated_at`) VALUES
(32, 'Bukidnon National High School', 'Division', '2025-05-02 14:05:34', '2025-05-02 14:05:34'),
(33, 'Bukidnon National High School', 'MCE', '2025-05-02 14:24:31', '2025-05-02 14:24:31'),
(34, 'Bukidnon National High School', 'MOE', '2025-05-02 14:27:13', '2025-05-02 14:27:13'),
(35, 'Bukidnon National High School', 'Division', '2025-05-16 02:31:32', '2025-05-16 03:24:48');

-- --------------------------------------------------------

--
-- Table structure for table `iar_items`
--

CREATE TABLE `iar_items` (
  `iar_item_id` int(11) NOT NULL,
  `iar_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iar_items`
--

INSERT INTO `iar_items` (`iar_item_id`, `iar_id`, `item_id`, `quantity`, `unit_price`, `total_price`, `remarks`, `created_at`) VALUES
(73, 66, 202, 1, 18000.00, 18000.00, 'Damaged', '2025-05-02 14:48:32'),
(74, 67, 203, 1, 5200.00, 5200.00, 'Non-Consumable', '2025-05-02 14:51:21'),
(75, 67, 204, 1, 650.00, 650.00, 'Consumable', '2025-05-02 14:51:21'),
(76, 68, 205, 2, 650.00, 1300.00, 'Non-Consumable', '2025-05-02 14:53:43'),
(77, 68, 206, 2, 600.00, 1200.00, 'Non-Consumable', '2025-05-02 14:53:43'),
(78, 69, 207, 2, 2800.00, 5600.00, 'Non-Consumable', '2025-05-02 14:56:24'),
(79, 69, 208, 22, 400.00, 8800.00, 'Non-Consumable', '2025-05-02 14:56:24'),
(80, 70, 209, 3, 1300.00, 3900.00, 'Non-consumables', '2025-05-02 14:58:27'),
(81, 70, 210, 4, 950.00, 3800.00, 'Consumable', '2025-05-02 14:58:27'),
(84, 73, 217, 1, 2133.00, 2133.00, 'Non-Consumable', '2025-05-16 03:41:04'),
(85, 74, 218, 2, 23000.00, 46000.00, 'Consumable', '2025-05-16 07:18:43'),
(86, 78, 223, 1, 109990.00, 109990.00, 'Non-Consumable', '2025-05-17 15:06:36'),
(87, 78, 224, 1, 59995.00, 59995.00, 'Non-Consumable', '2025-05-17 15:06:36'),
(88, 79, 225, 1, 500.00, 500.00, 'Non-Consumable', '2025-05-17 15:12:10'),
(89, 79, 226, 1, 950.00, 950.00, 'Non-Consumable', '2025-05-17 15:12:10'),
(90, 81, 227, 1, 280.00, 280.00, 'Consumable', '2025-05-17 15:17:12'),
(91, 81, 228, 1, 250.00, 250.00, 'Consumable', '2025-05-17 15:17:12'),
(92, 82, 229, 1, 109990.00, 109990.00, 'Non-Consumable', '2025-05-17 15:19:48'),
(93, 83, 230, 1, 250.00, 250.00, 'Consumable', '2025-05-17 15:22:39'),
(94, 83, 231, 1, 950.00, 950.00, 'Non-Consumable', '2025-05-17 15:22:39');

-- --------------------------------------------------------

--
-- Table structure for table `ics_items`
--

CREATE TABLE `ics_items` (
  `ics_item_id` int(11) NOT NULL,
  `ics_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `article` varchar(255) NOT NULL,
  `remarks` text NOT NULL,
  `estimated_useful_life` int(11) DEFAULT NULL,
  `inventory_item_no` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ics_items`
--

INSERT INTO `ics_items` (`ics_item_id`, `ics_id`, `item_id`, `quantity`, `article`, `remarks`, `estimated_useful_life`, `inventory_item_no`, `created_at`) VALUES
(56, 59, 176, 1, 'SEMI- EXPENDABLE IT EQUIPMENT', 'Good condition', 10, 'ICS-2025-001', '2025-05-02 14:35:45'),
(57, 59, 182, 1, 'SEMI- EXPENDABLE SCIENCE AND MATH EQUIPMENT', 'Good condition', 10, 'ICS-2025-002', '2025-05-02 14:35:45'),
(58, 60, 195, 1, 'SEMI-EXPENDABLE FURNITURE AND FIXTURES', 'Good condition', 10, 'ICS-2025-003', '2025-05-02 14:37:23'),
(59, 60, 196, 2, 'SEMI-EXPENDABLE FURNITURE AND FIXTURES', 'Good condition', 10, 'ICS-2025-004', '2025-05-02 14:37:23'),
(60, 61, 197, 2, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'Good condition', 10, 'ICS-2025-005', '2025-05-02 14:39:09'),
(61, 61, 198, 10, 'SEMI- EXPENDABLE SCIENCE AND MATH EQUIPMENT', 'Good condition', 10, 'ICS-2025-006', '2025-05-02 14:39:09'),
(66, 64, 213, 2, 'SEMI-EXPENDABLE FURNITURE AND FIXTURES', 'Non-consumable', 6, 'ICS-2025-0020', '2025-05-06 11:52:50'),
(67, 65, 214, 2, 'SEMI- EXPENDABLE SCIENCE AND MATH EQUIPMENT', 'Good condition', 8, 'ICS-2025-0021', '2025-05-16 02:10:18'),
(68, 66, 215, 2, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'sadadsad', 7, 'ICS-2025-00322', '2025-05-16 02:31:32'),
(69, 67, 216, 2, 'SEMI- EXPENDABLE IT EQUIPMENT', 'Good condition', 9, 'ICS-2025-00923', '2025-05-16 03:26:24'),
(71, 69, 222, 2, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'Good condition', 5, 'ICS-2025-007	999', '2025-05-16 16:27:17'),
(72, 70, 225, 1, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'Non-consumable', 5, 'OFF-STAP-BLK2025-002', '2025-05-17 15:28:03'),
(73, 70, 226, 1, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'Non-consumable', 5, 'OFF-FLORG-WM3T-BOX02', '2025-05-17 15:28:03'),
(74, 71, 226, 1, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'Non-consumable', 5, 'OFF-FLORG-WM3T-BOX01', '2025-05-17 15:30:17'),
(75, 72, 225, 1, 'SEMI- EXPENDABLE OFFICE PROPERTY', 'Non-consumable', 5, 'OFF-STAP-BLK2025-001', '2025-05-17 15:31:51'),
(76, 73, 233, 1, 'SEMI- EXPENDABLE IT EQUIPMENT', 'Good condition', 10, 'OFF-STAP-BLK2025-023', '2025-05-19 00:56:04'),
(77, 74, 235, 1, 'SEMI- EXPENDABLE IT EQUIPMENT', 'Good condition', NULL, 'ICS-2025-030', '2025-05-19 09:54:01');

-- --------------------------------------------------------

--
-- Table structure for table `inspection_acceptance_reports`
--

CREATE TABLE `inspection_acceptance_reports` (
  `iar_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `iar_no` varchar(50) NOT NULL,
  `po_no_date` varchar(100) DEFAULT NULL,
  `req_office` varchar(100) DEFAULT NULL,
  `responsibility_center` varchar(100) DEFAULT NULL,
  `iar_date` date NOT NULL,
  `invoice_no_date` varchar(100) DEFAULT NULL,
  `receiver_name` varchar(100) NOT NULL,
  `teacher_id` varchar(50) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `date_inspected` date NOT NULL,
  `inspectors` text DEFAULT NULL,
  `barangay_councilor` varchar(100) DEFAULT NULL,
  `pta_observer` varchar(100) DEFAULT NULL,
  `date_received` date NOT NULL,
  `property_custodian` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inspection_acceptance_reports`
--

INSERT INTO `inspection_acceptance_reports` (`iar_id`, `entity_id`, `supplier_id`, `iar_no`, `po_no_date`, `req_office`, `responsibility_center`, `iar_date`, `invoice_no_date`, `receiver_name`, `teacher_id`, `position`, `date_inspected`, `inspectors`, `barangay_councilor`, `pta_observer`, `date_received`, `property_custodian`, `created_at`, `updated_at`) VALUES
(66, 32, 15, 'IAR-2025-001', 'PO-25-001', 'Accounting Office', '621', '2025-05-02', 'INV-4521', 'Engr. Maria Fe Navarro', 'TID-05230', 'Supply Officer', '2025-05-02', 'Joan Savage', 'Hon. Emily Tan', 'Mr. Roberto Cruz', '2025-05-02', 'Stefany Jane Bernabe', '2025-05-02 14:48:32', '2025-05-17 15:45:02'),
(67, 33, 16, 'IAR-2025-002', 'PO-25-002', 'HUMSS Department', '622', '2025-05-02', 'NV-4522', 'Angelie Cole', 'TID-05229', 'Teacher II', '2025-05-02', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-02', 'Stefany Jane Bernabe', '2025-05-02 14:51:21', '2025-05-17 17:11:32'),
(68, 34, 17, '23-04-003', 'PO-25-003', 'STEM Department', '623', '2025-05-02', 'INV-4523', 'Anthony Black', 'TID-05228', 'Teacher II', '2025-05-02', 'Joan Savaege', 'Hon. Pedro M. Luna', 'Lapids lar', '2025-05-02', 'Stefany Jane Bernabe', '2025-05-02 14:53:43', '2025-05-17 15:44:51'),
(69, 34, 18, 'IAR-2025-004', 'PO-25-004', 'High School Department', '624', '2025-05-02', 'INV-4524', 'Angelie Cole', 'TID-05227', 'Head Teacher III', '2025-05-02', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-02', 'Stefany Jane Bernabe', '2025-05-02 14:56:24', '2025-05-17 15:44:42'),
(70, 33, 16, 'IAR-2025-005', 'PO-25-005', 'ABM Department', '625', '2025-05-02', 'INV-4525', 'Jerome Villanueva', 'TID-42123', 'Teacher III', '2025-05-02', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-02', 'Stefany Jane Bernabe', '2025-05-02 14:58:27', '2025-05-17 15:44:33'),
(73, 33, 19, 'IAR-2025-00102', 'PO-25-006', 'Office of the Principal', '7777', '2025-05-16', 'INV-4526', 'TOfff', 'TID-05223', 'Teacher 2', '2025-05-16', 'Joan Savaege', 'Brain Nelson', 'Mr. Roberto Cruz', '2025-05-16', 'Stefany Jane Bernabe', '2025-05-16 03:41:04', '2025-05-17 15:44:26'),
(74, 34, 18, 'IAR-2025-029', 'PO-25-007', 'High School Department', '630', '2025-05-16', 'INV-4527', 'Rinz Tagalocod', 'TID-12232', 'Teacher II', '2025-05-16', 'Joan Savage', 'Hon. Emily Tan', 'Lapids lar', '2025-05-16', 'Stefany Jane Bernabe', '2025-05-16 07:18:43', '2025-05-17 15:44:19'),
(78, 32, 17, '25-05-005', 'PO-25-008', 'HUMSS Department', '215', '2025-05-10', 'INV-4528', 'Jake Batumbakal', 'TID-98736', 'Teacher II', '2025-05-10', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-10', 'Stefany Jane Bernabe Labadan', '2025-05-17 15:06:36', '2025-05-17 15:44:08'),
(79, 32, 17, 'none', 'PO-25-009', 'GAS Department', '213', '2025-05-11', 'INV-4529', 'John Cena', 'TID-63728', 'Teacher II', '2025-05-11', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-11', 'Stefany Jane Bernabe', '2025-05-17 15:12:10', '2025-05-17 15:43:23'),
(81, 32, 17, '25-05-004', 'PO-25-010', 'GAS Department', 'none', '2025-05-11', 'INV-4530', 'John Cena', 'TID-63728', 'Teacher II', '2025-05-11', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-11', 'Stefany Jane Bernabe', '2025-05-17 15:17:12', '2025-05-17 15:43:29'),
(82, 32, 17, '25-05-003', 'PO-25-011', 'ABM Department', 'none', '2025-05-12', 'INV-4531', 'Jino Taer', 'TID-52672', 'Teacher II', '2025-05-12', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-12', 'Stefany Jane Bernabe', '2025-05-17 15:19:48', '2025-05-17 15:43:34'),
(83, 34, 20, '25-05-002', 'PO-25-012', 'STEM Department', 'none', '2025-05-13', 'INV-4532', 'John Pruds Colot', 'TID-74545', 'Teacher II', '2025-05-13', 'Joan Savaege', 'Brain Nelson', 'Lapids lar', '2025-05-13', 'Stefany Jane Bernabe', '2025-05-17 15:22:39', '2025-05-17 15:43:41'),
(84, 33, 18, 'IAR-2025-022', 'PO-25-022', 'Office of the Principal', '631', '2025-05-14', 'INV-4533', 'Angelie Cole', 'TID-2218', 'Teacher II', '2025-05-19', 'Joan Savage', 'Brain Nelson', 'Lapids lar', '2025-05-19', 'Stefany Jane Bernabe', '2025-05-19 00:52:06', '2025-05-19 00:52:06');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_custodian_slips`
--

CREATE TABLE `inventory_custodian_slips` (
  `ics_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `ics_no` varchar(50) NOT NULL,
  `end_user_name` varchar(100) NOT NULL,
  `end_user_position` varchar(100) DEFAULT NULL,
  `end_user_date` date DEFAULT NULL,
  `custodian_name` varchar(100) NOT NULL,
  `custodian_position` varchar(100) DEFAULT NULL,
  `custodian_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory_custodian_slips`
--

INSERT INTO `inventory_custodian_slips` (`ics_id`, `entity_id`, `ics_no`, `end_user_name`, `end_user_position`, `end_user_date`, `custodian_name`, `custodian_position`, `custodian_date`, `created_at`, `updated_at`) VALUES
(59, 33, 'ICS-2025-001', 'Claude vergara', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-02 14:35:45', '2025-05-16 05:07:28'),
(60, 34, 'ICS-2025-002', 'Alexis Barber', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-02 14:37:23', '2025-05-16 05:07:58'),
(61, 32, 'ICS-2025-003', 'Vincent tinggoy', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-02 14:39:09', '2025-05-16 05:08:03'),
(64, 35, 'ICS-2025-0020', 'toff tinggoy', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-06 11:52:50', '2025-05-16 03:16:12'),
(65, 34, 'ICS-2025-0021', 'Steven sshu', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-16 02:10:17', '2025-05-16 05:08:40'),
(66, 35, 'ICS-2025-0022', 'Toff Vergara', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-16 02:31:32', '2025-05-16 03:16:50'),
(67, 34, 'ICS-2025-0023', 'Camille Navarro', 'TLE Instructor', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-16 03:26:24', '2025-05-16 03:26:24'),
(69, 32, 'ICS-2025-00222', 'Anthony Black', 'Teacher II', '2025-05-17', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-17', '2025-05-16 16:27:17', '2025-05-16 16:27:17'),
(70, 32, 'ICS-25-05-003', 'John Cena', 'TEACHER II', '2025-05-10', 'Stefany Jane Bernabe Labadan', 'Administrative Office II', '2025-05-10', '2025-05-17 15:28:03', '2025-05-17 15:28:03'),
(71, 34, 'ICS-25-05-002', 'John Pruds Colot', 'TEACHER II', '2025-05-11', 'STEFANY JANE B. LABADAN', 'Administrative Office II', '2025-05-11', '2025-05-17 15:30:17', '2025-05-17 15:30:17'),
(72, 32, 'ICS-25-05-001', 'Steven Benedict Tado Bernabe', 'Teacher II', '2025-05-13', 'Stefany Jane Bernabe Labadan', 'Administrative Office II', '2025-05-13', '2025-05-17 15:31:51', '2025-05-17 15:31:51'),
(73, 33, 'ICS-2025-023', 'Samantha Boone', 'Teacher II', '2025-05-19', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-19', '2025-05-19 00:56:04', '2025-05-19 00:56:04'),
(74, 33, 'ICS-2025-0030', 'Pj Colot', 'Teacher II', '2025-05-19', 'Stefany Jane Bernabe Labadan', 'Property Custodian', '2025-05-19', '2025-05-19 09:54:01', '2025-05-19 09:54:01');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `stock_no` varchar(50) DEFAULT NULL,
  `item_description` text NOT NULL,
  `unit` varchar(20) NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `stock_no`, `item_description`, `unit`, `unit_cost`, `created_at`, `updated_at`) VALUES
(176, NULL, 'Laptop (Intel i5, 8GB RAM)', 'pieces', 32000.00, '2025-05-02 14:05:34', NULL),
(177, NULL, 'Electric Fan (Stand Type)', 'pieces', 6500.00, '2025-05-02 14:05:34', NULL),
(178, NULL, 'Filing Cabinet (4-layer)', 'pieces', 5200.00, '2025-05-02 14:12:09', NULL),
(179, NULL, 'Printer (LaserJet)', 'pieces', 12000.00, '2025-05-02 14:12:09', NULL),
(180, NULL, 'Extension Wire (10m)', 'pieces', 6650.00, '2025-05-02 14:13:48', NULL),
(181, NULL, 'Monoblock Chairs (White)', 'pieces', 7000.00, '2025-05-02 14:13:48', NULL),
(182, NULL, 'LED Projector', 'pieces', 18000.00, '2025-05-02 14:16:00', '2025-05-16 08:10:26'),
(183, NULL, 'Wi-Fi Router', 'pieces', 7800.00, '2025-05-02 14:16:00', NULL),
(184, NULL, 'Digital Multimeter', 'pieces', 69000.00, '2025-05-02 14:17:35', '2025-05-16 16:58:27'),
(185, NULL, 'Rechargeable Flashlight', 'pieces', 50000.00, '2025-05-02 14:17:36', '2025-05-06 11:59:22'),
(186, 'OFF-FLORG-ZN6L-BND11', 'Bond Paper (A4)', '', 0.00, '2025-05-02 14:22:06', '2025-05-17 15:53:35'),
(187, 'OFF-HILIT-QW033-CSE', 'Whiteboard Markers', 'box', 0.00, '2025-05-02 14:22:06', '2025-05-17 15:53:22'),
(188, 'OFF-FLORG-LP2X-BOX31', 'Long Folders (Kraft)', 'pieces', 0.00, '2025-05-02 14:24:31', '2025-05-17 15:53:13'),
(189, 'OFF-HILIT-YJ981-CVR', 'Stapler w/ Pins', 'pieces', 0.00, '2025-05-02 14:24:31', '2025-05-17 15:53:10'),
(190, 'OFF-FLORG-WE5M-KIT44', 'Correction Tape', 'pieces', 0.00, '2025-05-02 14:27:13', '2025-05-17 15:52:55'),
(191, 'OFF-FLORG-NP4C-BOX17', 'Manila Paper', 'pieces', 0.00, '2025-05-02 14:27:13', '2025-05-17 15:51:36'),
(192, 'OFF-HILIT-UV992-SET', 'Electrical Tape', 'pieces', 0.00, '2025-05-02 14:30:28', '2025-05-17 15:51:27'),
(193, 'OFF-FLORG-QR5V-KIT22', 'USB Flash Drive (32GB)', 'pieces', 0.00, '2025-05-02 14:32:51', '2025-05-17 15:51:18'),
(194, 'OFF-HILIT-LX310-PAD', 'Mouse (Optical)', 'pieces', 0.00, '2025-05-02 14:32:51', '2025-05-17 15:51:09'),
(195, NULL, 'Filing Cabinet (4-drawer)', 'pieces', 5200.00, '2025-05-02 14:37:23', NULL),
(196, NULL, 'Stapler (Heavy Duty)', 'pieces', 650.00, '2025-05-02 14:37:23', NULL),
(197, NULL, 'Monoblock Chair (White)', 'pieces', 350.00, '2025-05-02 14:39:09', NULL),
(198, NULL, 'Monoblock Chair (White)', 'pieces', 600.00, '2025-05-02 14:39:09', NULL),
(199, NULL, 'Optical Mouse', 'pieces', 400.00, '2025-05-02 14:40:36', NULL),
(200, NULL, 'Flashlight (Rechargeable)', 'pieces', 950.00, '2025-05-02 14:43:02', NULL),
(201, 'OFF-FLORG-KD7B-BND05', 'Laptop (Intel i5, 8GB RAM)', 'pieces', 32000.00, '2025-05-02 14:48:32', '2025-05-17 15:51:02'),
(202, 'OFF-HILIT-JQ007-CVR', 'LED Projector', 'pieces', 18000.00, '2025-05-02 14:48:32', '2025-05-17 15:50:53'),
(203, 'OFF-FLORG-WM2Y-BOX13', 'Filing Cabinet (4-drawer)', 'pieces', 5200.00, '2025-05-02 14:51:21', '2025-05-17 15:50:48'),
(204, 'OFF-HILIT-ZR890-FAB', 'Heavy-Duty Stapler', 'pieces', 650.00, '2025-05-02 14:51:21', '2025-05-17 15:50:35'),
(205, 'OFF-FLORG-MN1X-PCK01', 'Monoblock Chair (White)', 'pieces', 650.00, '2025-05-02 14:53:43', '2025-05-17 15:50:22'),
(206, 'OFF-HILIT-XD204-CSE', 'Extension Cord (10 meters)', 'pieces', 600.00, '2025-05-02 14:53:43', '2025-05-17 15:50:20'),
(207, 'ITM-LTOP-MBP14M3-2025-990,OFF-MARK-BLKEXPO-990', 'Wi-Fi Router', 'pieces', 2800.00, '2025-05-02 14:56:24', '2025-05-17 15:49:21'),
(208, 'ITM-LTOP-MBP14M3-2025-904,OFF-MARK-BLKEXPO-904', 'Optical Mouse', 'pieces', 400.00, '2025-05-02 14:56:24', '2025-05-17 15:49:11'),
(209, 'ITM-LTOP-MBP14M3-2025-839,OFF-MARK-BLKEXPO-839', 'Digital Multimeter', 'pieces', 1300.00, '2025-05-02 14:58:27', '2025-05-17 15:49:03'),
(210, 'ITM-LTOP-MBP14M3-2025-725,OFF-MARK-BLKEXPO-725', 'Rechargeable Flashlight', 'pieces', 950.00, '2025-05-02 14:58:27', '2025-05-17 15:48:53'),
(211, 'ITM-LTOP-MBP14M3-2025-678,OFF-MARK-BLKEXPO-678', 'Office Table', 'pieces', 2000.00, '2025-05-03 16:00:51', '2025-05-17 15:48:47'),
(212, 'ITM-LTOP-MBP14M3-2025-554,OFF-MARK-BLKEXPO-554', 'Acer Laptop, i5 12th Gen 8gb', 'box', 51000.00, '2025-05-06 10:40:04', '2025-05-19 02:59:17'),
(213, NULL, 'blue ballpen', 'box', 76.00, '2025-05-06 11:52:50', '2025-05-16 03:22:50'),
(214, NULL, 'Laptop (Intel i5, 8GB RAM)', 'pieces', 21000.00, '2025-05-16 02:10:18', '2025-05-16 03:21:26'),
(215, NULL, 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 22000.00, '2025-05-16 02:31:32', '2025-05-16 03:17:43'),
(216, NULL, 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 23300.00, '2025-05-16 03:26:24', NULL),
(217, 'ITM-LTOP-MBP14M3-2025-447,OFF-MARK-BLKEXPO-447', 'Acer Laptop, i5 12th Gen 8gb', 'box', 2133.00, '2025-05-16 03:41:04', '2025-05-17 15:48:18'),
(218, 'ITM-LTOP-MBP14M3-2025-329,OFF-MARK-BLKEXPO-329', 'Laptop (Intel i5, 8GB RAM)', 'pieces', 23000.00, '2025-05-16 07:18:43', '2025-05-17 15:48:13'),
(219, NULL, 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 22222.00, '2025-05-16 07:41:00', '2025-05-16 08:09:14'),
(220, 'ITM-LTOP-MBP14M3-2025-218,OFF-MARK-BLKEXPO-218', 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 0.00, '2025-05-16 07:50:37', '2025-05-17 15:48:00'),
(221, 'ITM-LTOP-MBP14M3-2025-103,OFF-MARK-BLKEXPO-103', 'Laptop (Intel i5, 8GB RAM)', 'pieces', 0.00, '2025-05-16 07:50:37', '2025-05-17 15:47:34'),
(222, NULL, 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 2222.00, '2025-05-16 16:27:17', NULL),
(223, 'ITM-LTOP-MBP14M3-2023-002', 'Laptop – Apple MacBook Pro 14 M3 Chip (2023)', 'pieces', 109990.00, '2025-05-17 15:06:36', NULL),
(224, 'ITM-PRNT-ECO16600-A3-001', 'Printer – Epson EcoTank Pro ET-16600 A3 Wireless All-in-One', 'pieces', 59995.00, '2025-05-17 15:06:36', NULL),
(225, 'OFF-STAP-BLK2025-002', 'Heavy-Duty Office Stapler', 'pieces', 500.00, '2025-05-17 15:12:10', NULL),
(226, 'OFF-FLORG-WM3T-BOX02', 'Wall-Mount File Organizer – 3 Tier', 'box', 950.00, '2025-05-17 15:12:10', NULL),
(227, 'OFF-MARK-BLKEXPO-002', 'Whiteboard Marker – Black', 'box', 280.00, '2025-05-17 15:17:12', NULL),
(228, 'OFF-HILIT-ST006-FAB', 'Highlighter Pen Set – 5 Colors', 'box', 250.00, '2025-05-17 15:17:12', NULL),
(229, 'ITM-LTOP-MBP14M3-2023-001', 'Laptop – Apple MacBook Pro 14 M3 Chip (2023)', 'pieces', 109990.00, '2025-05-17 15:19:48', NULL),
(230, 'OFF-HILIT-ST005-FAB', 'Highlighter Pen Set – 5 Colors', 'pieces', 250.00, '2025-05-17 15:22:39', '2025-05-19 03:44:35'),
(231, 'OFF-FLORG-WM3T-BOX01', 'Wall-Mount File Organizer – 3 Tier', 'box', 950.00, '2025-05-17 15:22:39', NULL),
(232, 'OFF-HILIT-ST009-FAB', 'Laptop – Apple MacBook Pro 14 M3 Chip (2023)', 'pieces', 60000.00, '2025-05-19 00:52:07', '2025-05-19 01:11:44'),
(233, NULL, 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 42000.00, '2025-05-19 00:56:04', '2025-05-19 01:15:05'),
(234, 'OFF-HILIT-QW043-CSE', 'blue ballpen', 'box', 0.00, '2025-05-19 01:02:09', NULL),
(235, NULL, 'Acer Laptop, i5 12th Gen 8gb', 'pieces', 55000.00, '2025-05-19 09:54:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `par_items`
--

CREATE TABLE `par_items` (
  `par_item_id` int(11) NOT NULL,
  `par_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `article` varchar(255) NOT NULL,
  `remarks` text NOT NULL,
  `property_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `par_items`
--

INSERT INTO `par_items` (`par_item_id`, `par_id`, `item_id`, `quantity`, `article`, `remarks`, `property_number`, `created_at`) VALUES
(34, 18, 176, 2, 'IT EQUIPMENT', 'Good condition', 'ITM-PRNT-EPSC3250-A3-013', '2025-05-02 14:05:34'),
(35, 18, 177, 10, 'IT EQUIPMENT', 'Good condition', 'ITM-LTOP-DELLXPS13-2025-012', '2025-05-02 14:05:34'),
(36, 19, 178, 20, 'IT EQUIPMENT', 'Good condition', 'ITM-MNTR-LG24BLK-HD-011', '2025-05-02 14:12:09'),
(37, 19, 179, 25, 'IT EQUIPMENT', 'Good condition', 'ITM-LTOP-MBP14M3-2025-010', '2025-05-02 14:12:09'),
(38, 20, 180, 10, 'IT EQUIPMENT', 'Good condition', 'ITM-PRNT-BRO510W-A3-009', '2025-05-02 14:13:48'),
(39, 20, 181, 100, 'IT EQUIPMENT', 'Good condition', 'ITM-LTOP-ASUSVIVO-2025-008', '2025-05-02 14:13:48'),
(40, 21, 182, 5, 'IT EQUIPMENT', 'Damaged', 'ITM-PRNT-HP425DN-A4-007', '2025-05-02 14:16:00'),
(42, 22, 184, 2, 'IT EQUIPMENT', 'Good condition', 'ITM-LTOP-LNVY740G-2025-005', '2025-05-02 14:17:35'),
(43, 22, 185, 4, 'IT EQUIPMENT', 'Damaged', 'ITM-DESK-DTK3090-XL-001', '2025-05-02 14:17:36'),
(44, 23, 212, 1, 'IT EQUIPMENT', 'Good condition', 'ITM-PRNT-ECO16600-A3-004', '2025-05-16 08:07:03'),
(45, 23, 184, 3, 'IT EQUIPMENT', 'Good condition', 'ITM-LTOP-MBP14M3-2025-003', '2025-05-16 08:07:03'),
(46, 24, 223, 1, 'IT EQUIPMENT', 'Non-consumable', 'ITM-LTOP-MBP14M3-2023-002', '2025-05-17 15:36:26'),
(47, 24, 224, 1, 'IT EQUIPMENT', 'Non-consumable', 'ITM-PRNT-ECO16600-A3-001', '2025-05-17 15:36:26'),
(48, 25, 223, 1, 'IT EQUIPMENT', 'Non-consumable', 'ITM-LTOP-MBP14M3-2023-001', '2025-05-17 15:38:13');

-- --------------------------------------------------------

--
-- Table structure for table `property_acknowledgment_receipts`
--

CREATE TABLE `property_acknowledgment_receipts` (
  `par_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `par_no` varchar(50) NOT NULL,
  `date_acquired` date NOT NULL,
  `end_user_name` varchar(100) NOT NULL,
  `receiver_position` varchar(100) DEFAULT NULL,
  `receiver_date` date DEFAULT NULL,
  `custodian_name` varchar(100) NOT NULL,
  `custodian_position` varchar(100) DEFAULT NULL,
  `custodian_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_acknowledgment_receipts`
--

INSERT INTO `property_acknowledgment_receipts` (`par_id`, `entity_id`, `par_no`, `date_acquired`, `end_user_name`, `receiver_position`, `receiver_date`, `custodian_name`, `custodian_position`, `custodian_date`, `created_at`, `updated_at`) VALUES
(18, 32, 'PAR-2025-001', '2025-04-02', 'Angela Reyes', 'ICT Department', '2025-04-27', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-02', '2025-05-02 14:05:34', '2025-05-02 14:05:34'),
(19, 32, 'PAR-2025-002', '2025-04-14', 'Jonathan Cruz', 'Teacher I', '2025-05-02', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-02', '2025-05-02 14:12:09', '2025-05-02 14:12:09'),
(20, 32, 'PAR-2025-003', '2025-04-06', 'Maricel L. Gomez', 'Teacher II', '2025-04-28', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-04-28', '2025-05-02 14:13:48', '2025-05-02 14:13:48'),
(21, 32, 'PAR-2025-004', '2025-05-02', 'Elmer Santos', 'ICT Coordinator / Computer Lab', '2025-04-23', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-04-23', '2025-05-02 14:16:00', '2025-05-02 14:16:00'),
(22, 32, 'PAR-2025-005', '2025-04-22', 'Camille Navarro', 'TLE Teacher', '2025-04-28', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-04-28', '2025-05-02 14:17:35', '2025-05-02 14:17:35'),
(23, 32, 'PAR-2025-0029', '2025-05-16', 'Steven Tinggoy', 'Teacher II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Property Custodian', '2025-05-16', '2025-05-16 08:07:03', '2025-05-16 08:07:03'),
(24, 32, 'PAR-25-05-002', '2025-05-14', 'Jake Batumbakal', 'Teacher II', '2025-05-14', 'Stefany Jane Bernabe Labadan', 'Administrative Office II', '2025-05-14', '2025-05-17 15:36:26', '2025-05-17 15:36:26'),
(25, 32, 'PAR-25-05-001', '2025-05-15', 'Jino Taer', 'Teacher II', '2025-05-15', 'Stefany Jane Bernabe Labadan', 'Administrative Office II', '2025-05-15', '2025-05-17 15:38:13', '2025-05-17 15:38:13');

-- --------------------------------------------------------

--
-- Table structure for table `requisition_and_issue_slips`
--

CREATE TABLE `requisition_and_issue_slips` (
  `ris_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `division` varchar(100) DEFAULT NULL,
  `office` varchar(100) DEFAULT NULL,
  `responsibility_code` varchar(50) DEFAULT NULL,
  `ris_no` varchar(50) NOT NULL,
  `purpose` text DEFAULT NULL,
  `requested_by_name` varchar(100) NOT NULL,
  `requested_by_designation` varchar(100) DEFAULT NULL,
  `requested_by_date` date DEFAULT NULL,
  `approved_by_name` varchar(100) DEFAULT NULL,
  `approved_by_designation` varchar(100) DEFAULT NULL,
  `approved_by_date` date DEFAULT NULL,
  `issued_by_name` varchar(100) DEFAULT NULL,
  `issued_by_designation` varchar(100) DEFAULT NULL,
  `issued_by_date` date DEFAULT NULL,
  `received_by_name` varchar(100) DEFAULT NULL,
  `received_by_designation` varchar(100) DEFAULT NULL,
  `received_by_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requisition_and_issue_slips`
--

INSERT INTO `requisition_and_issue_slips` (`ris_id`, `entity_id`, `division`, `office`, `responsibility_code`, `ris_no`, `purpose`, `requested_by_name`, `requested_by_designation`, `requested_by_date`, `approved_by_name`, `approved_by_designation`, `approved_by_date`, `issued_by_name`, `issued_by_designation`, `issued_by_date`, `received_by_name`, `received_by_designation`, `received_by_date`, `created_at`, `updated_at`) VALUES
(26, 32, 'Malaybalay', 'High School Department', '101-4580-SCI', 'RIS-2025-001', 'Final Exam', 'Angela Reyes', 'Science Teacher', '2025-04-21', 'Dr. Manuel Ortega', 'Principal III', '2025-04-21', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-04-21', 'Angela Reyes', 'Science Teacher', '2025-04-22', '2025-05-02 14:22:06', '2025-05-02 14:22:06'),
(27, 33, 'Malaybalay', 'HUMSS Department', '101-4599-REC', 'RIS-2025-002', 'EXPO', 'Jonathan Cruz', 'Admin Aide', '2025-04-29', 'Atty. Regina P. Salcedo', 'Admin Head', '2025-05-28', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-04-30', 'Jonathan Cruz', 'Admin Aide', '2025-04-30', '2025-05-02 14:24:31', '2025-05-02 14:24:31'),
(28, 34, 'Malaybalay', 'GAS Department', '101-4620-REG', 'RIS-2025-003', 'GAD Assembly', 'Maricel Gomez', 'Teacher II', '2025-04-27', 'Dr. Joanna May Escobar', 'Registrar Head', '2025-05-02', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-05-02', 'Maricel Gomez', 'Teacher II', '2025-05-02', '2025-05-02 14:27:13', '2025-05-02 14:27:13'),
(29, 34, 'Malaybalay', 'STEM Department', '101-4633-TLE', 'RIS-2025-004', 'Stem days', 'Camille Navarro', 'Science Teacher', '2025-04-29', 'Engr. Victor Z. Javier', 'Senior High School Principal II', '2025-04-29', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-05-02', 'Camille Navarro', 'Science Teacher', '2025-05-02', '2025-05-02 14:30:28', '2025-05-02 14:30:28'),
(30, 32, 'Malaybalay', 'TVL Department', '101-4650-ICT', 'RIS-2025-005', 'Comlab Equipment', 'Elmer Santos', 'ICT Coordinator', '2025-04-27', 'Liza Montano', 'ICT Supervisor', '2025-05-02', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-05-02', 'Elmer Santos', 'ICT Coordinator', '2025-05-02', '2025-05-02 14:32:51', '2025-05-02 14:32:51'),
(31, 34, 'Malaybalay', 'High School Department', '122-4650-ICT', 'RIS-2025-029', 'ICT day', 'Emmanuel Canete', 'Teacher II', '2025-05-16', 'Jannacole Macapuno', 'Secondary School Principal II', '2025-05-16', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-05-16', 'Emmanuel Canete', 'Teacher II', '2025-05-16', '2025-05-16 07:50:37', '2025-05-16 07:50:37'),
(32, 32, 'Malaybalay', 'High School Department', '111-4650-ICT', 'RIS-2025-0010', 'Comlab Equipment', 'Samantha Boone', 'Teacher II', '2025-05-18', 'Jannacole Macapuno', 'Secondary School Principal II', '2025-05-18', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-05-18', 'Samantha Boone', 'Teacher II', '2025-05-18', '2025-05-17 16:01:00', '2025-05-17 16:40:32'),
(33, 33, 'Malaybalay', 'HUMSS Department', '121-4580-SCI', 'RIS-2025-030', 'Final Exam', 'Angela Reyes', 'Teacher II', '2025-05-19', 'Jannacole Macapuno', 'Secondary School Principal II', '2025-05-19', 'STEFANY JANE B. LABADAN', 'Administrative Officer II', '2025-05-19', 'Angela Reyes', 'Teacher II', '2025-05-19', '2025-05-19 01:02:09', '2025-05-19 01:02:09');

-- --------------------------------------------------------

--
-- Table structure for table `ris_items`
--

CREATE TABLE `ris_items` (
  `ris_item_id` int(11) NOT NULL,
  `ris_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `requested_qty` int(11) NOT NULL,
  `stock_available` varchar(11) DEFAULT NULL,
  `issued_qty` int(11) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ris_items`
--

INSERT INTO `ris_items` (`ris_item_id`, `ris_id`, `item_id`, `requested_qty`, `stock_available`, `issued_qty`, `remarks`, `created_at`) VALUES
(35, 26, 186, 10, 'Yes', 10, 'Consumable', '2025-05-02 14:22:06'),
(36, 26, 187, 5, 'Yes', 5, 'Consumable', '2025-05-02 14:22:06'),
(37, 27, 188, 50, 'Yes', 50, 'Consumable', '2025-05-02 14:24:31'),
(38, 27, 189, 2, 'Yes', 2, 'Consumable', '2025-05-02 14:24:31'),
(39, 28, 190, 5, 'Yes', 5, 'Consumable', '2025-05-02 14:27:13'),
(40, 28, 191, 10, 'Yes', 10, 'Consumable', '2025-05-02 14:27:13'),
(41, 29, 192, 3, 'Yes', 3, 'Consumable', '2025-05-02 14:30:28'),
(42, 29, 192, 3, 'Yes', 3, 'Consumable', '2025-05-02 14:30:28'),
(43, 30, 193, 5, 'Yes', 5, 'Non-consumable', '2025-05-02 14:32:51'),
(44, 30, 194, 5, 'Yes', 5, 'Non-consumable', '2025-05-02 14:32:51'),
(45, 31, 220, 2, 'Yes', 2, 'Non-consumable', '2025-05-16 07:50:37'),
(46, 31, 221, 1, 'Yes', 1, 'Non-consumable', '2025-05-16 07:50:37'),
(47, 32, 223, 2, 'yes', 2, 'Non-Consumable', '2025-05-17 16:37:13'),
(48, 33, 234, 20, 'yes', 20, 'Consumable', '2025-05-19 01:02:09');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `created_at`, `updated_at`) VALUES
(15, 'EduTech Supplies Inc.', '2025-05-02 14:48:32', '2025-05-02 14:48:32'),
(16, 'ML store', '2025-05-02 14:51:21', '2025-05-02 14:51:21'),
(17, 'Division', '2025-05-02 14:53:43', '2025-05-02 14:53:43'),
(18, 'Shopinas', '2025-05-02 14:56:24', '2025-05-02 14:56:24'),
(19, 'qweqwe', '2025-05-16 03:41:04', '2025-05-16 03:41:04'),
(20, 'PJ Store', '2025-05-17 15:22:39', '2025-05-17 15:22:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bnhs_admin`
--
ALTER TABLE `bnhs_admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_email` (`admin_email`);

--
-- Indexes for table `bnhs_staff`
--
ALTER TABLE `bnhs_staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `staff_email` (`staff_email`);

--
-- Indexes for table `entities`
--
ALTER TABLE `entities`
  ADD PRIMARY KEY (`entity_id`);

--
-- Indexes for table `iar_items`
--
ALTER TABLE `iar_items`
  ADD PRIMARY KEY (`iar_item_id`),
  ADD KEY `iar_id` (`iar_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `ics_items`
--
ALTER TABLE `ics_items`
  ADD PRIMARY KEY (`ics_item_id`),
  ADD UNIQUE KEY `inventory_item_no` (`inventory_item_no`),
  ADD KEY `ics_id` (`ics_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `idx_inventory_item_no` (`inventory_item_no`);

--
-- Indexes for table `inspection_acceptance_reports`
--
ALTER TABLE `inspection_acceptance_reports`
  ADD PRIMARY KEY (`iar_id`),
  ADD UNIQUE KEY `iar_no` (`iar_no`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `idx_iar_no` (`iar_no`);

--
-- Indexes for table `inventory_custodian_slips`
--
ALTER TABLE `inventory_custodian_slips`
  ADD PRIMARY KEY (`ics_id`),
  ADD UNIQUE KEY `ics_no` (`ics_no`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `idx_ics_no` (`ics_no`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`),
  ADD UNIQUE KEY `stock_no` (`stock_no`),
  ADD KEY `idx_stock_no` (`stock_no`);

--
-- Indexes for table `par_items`
--
ALTER TABLE `par_items`
  ADD PRIMARY KEY (`par_item_id`),
  ADD UNIQUE KEY `property_number` (`property_number`),
  ADD KEY `par_id` (`par_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `idx_property_number` (`property_number`);

--
-- Indexes for table `property_acknowledgment_receipts`
--
ALTER TABLE `property_acknowledgment_receipts`
  ADD PRIMARY KEY (`par_id`),
  ADD UNIQUE KEY `par_no` (`par_no`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `idx_par_no` (`par_no`);

--
-- Indexes for table `requisition_and_issue_slips`
--
ALTER TABLE `requisition_and_issue_slips`
  ADD PRIMARY KEY (`ris_id`),
  ADD UNIQUE KEY `ris_no` (`ris_no`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `idx_ris_no` (`ris_no`);

--
-- Indexes for table `ris_items`
--
ALTER TABLE `ris_items`
  ADD PRIMARY KEY (`ris_item_id`),
  ADD KEY `ris_id` (`ris_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entities`
--
ALTER TABLE `entities`
  MODIFY `entity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `iar_items`
--
ALTER TABLE `iar_items`
  MODIFY `iar_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `ics_items`
--
ALTER TABLE `ics_items`
  MODIFY `ics_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `inspection_acceptance_reports`
--
ALTER TABLE `inspection_acceptance_reports`
  MODIFY `iar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `inventory_custodian_slips`
--
ALTER TABLE `inventory_custodian_slips`
  MODIFY `ics_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;

--
-- AUTO_INCREMENT for table `par_items`
--
ALTER TABLE `par_items`
  MODIFY `par_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `property_acknowledgment_receipts`
--
ALTER TABLE `property_acknowledgment_receipts`
  MODIFY `par_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `requisition_and_issue_slips`
--
ALTER TABLE `requisition_and_issue_slips`
  MODIFY `ris_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `ris_items`
--
ALTER TABLE `ris_items`
  MODIFY `ris_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `iar_items`
--
ALTER TABLE `iar_items`
  ADD CONSTRAINT `iar_items_ibfk_1` FOREIGN KEY (`iar_id`) REFERENCES `inspection_acceptance_reports` (`iar_id`),
  ADD CONSTRAINT `iar_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`);

--
-- Constraints for table `ics_items`
--
ALTER TABLE `ics_items`
  ADD CONSTRAINT `ics_items_ibfk_1` FOREIGN KEY (`ics_id`) REFERENCES `inventory_custodian_slips` (`ics_id`),
  ADD CONSTRAINT `ics_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`);

--
-- Constraints for table `inspection_acceptance_reports`
--
ALTER TABLE `inspection_acceptance_reports`
  ADD CONSTRAINT `inspection_acceptance_reports_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`),
  ADD CONSTRAINT `inspection_acceptance_reports_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `inventory_custodian_slips`
--
ALTER TABLE `inventory_custodian_slips`
  ADD CONSTRAINT `inventory_custodian_slips_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`);

--
-- Constraints for table `par_items`
--
ALTER TABLE `par_items`
  ADD CONSTRAINT `par_items_ibfk_1` FOREIGN KEY (`par_id`) REFERENCES `property_acknowledgment_receipts` (`par_id`),
  ADD CONSTRAINT `par_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`);

--
-- Constraints for table `property_acknowledgment_receipts`
--
ALTER TABLE `property_acknowledgment_receipts`
  ADD CONSTRAINT `property_acknowledgment_receipts_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`);

--
-- Constraints for table `requisition_and_issue_slips`
--
ALTER TABLE `requisition_and_issue_slips`
  ADD CONSTRAINT `requisition_and_issue_slips_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`entity_id`);

--
-- Constraints for table `ris_items`
--
ALTER TABLE `ris_items`
  ADD CONSTRAINT `ris_items_ibfk_1` FOREIGN KEY (`ris_id`) REFERENCES `requisition_and_issue_slips` (`ris_id`),
  ADD CONSTRAINT `ris_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
