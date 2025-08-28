<?php
require_once __DIR__ . "/config/config.php";

// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

try {
    // Check if the connection is successful
    if ($mysqli->connect_error) {
        throw new Exception("Connection failed: " . $mysqli->connect_error);
    }
    
    echo "Connected to database successfully.<br>";
    
    // Get current column type
    $checkQuery = "SHOW COLUMNS FROM bnhs_staff WHERE Field = 'staff_id'";
    $result = $mysqli->query($checkQuery);
    
    if (!$result) {
        throw new Exception("Error checking column: " . $mysqli->error);
    }
    
    $column = $result->fetch_assoc();
    echo "Current staff_id column type: " . $column['Type'] . "<br>";
    
    // Alter the table to change staff_id to BIGINT
    $alterQuery = "ALTER TABLE bnhs_staff MODIFY staff_id BIGINT NOT NULL";
    
    if ($mysqli->query($alterQuery)) {
        echo "Successfully changed staff_id column to BIGINT.<br>";
        
        // Verify the change
        $verifyResult = $mysqli->query($checkQuery);
        $updatedColumn = $verifyResult->fetch_assoc();
        echo "Updated staff_id column type: " . $updatedColumn['Type'] . "<br>";
        
        echo "Now you can use IDs larger than 2147483647.<br>";
    } else {
        throw new Exception("Error altering table: " . $mysqli->error);
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?> 