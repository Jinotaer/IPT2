<?php
session_start();
require_once __DIR__ . "/../assets/vendor/autoload.php";
require_once __DIR__ . "/../config/config.php"; // Add config to access database

// Import Google OAuth2 Service
use Google\Service\Oauth2;

// Enable error logging
error_reporting(E_ALL);
ini_set('display_errors', 1);
error_log("Starting Google authentication process");

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . "/../assets");
$dotenv->load();

$client = new Google_Client();
$client->setClientId($_ENV['GOOGLE_CLIENT_ID']);
$client->setClientSecret($_ENV['GOOGLE_CLIENT_SECRET']);
$client->setRedirectUri($_ENV['GOOGLE_REDIRECT']);

if (isset($_GET['code'])) {
    error_log("Received authorization code from Google");
    $token = $client->fetchAccessTokenWithAuthCode($_GET['code']);

    if (!isset($token['error'])) {
        $client->setAccessToken($token);
        error_log("Successfully retrieved access token from Google");

        $oauth2 = new Google\Service\Oauth2($client);
        $user_info = $oauth2->userinfo->get();

        error_log("Google user info: Email = " . $user_info->email . ", Name = " . $user_info->name);

        $_SESSION['user_type'] = 'google';
        $_SESSION['user_email'] = $user_info->email;
        $_SESSION['user_name'] = $user_info->name;
        $_SESSION['user_image'] = $user_info->picture;
        
        // Find or create a staff account for this Google user
        $email = $user_info->email;
        
        try {
            // Check if user exists
            error_log("Checking if user exists with email: " . $email);
            $stmt = $mysqli->prepare("SELECT staff_id FROM bnhs_staff WHERE staff_email = ?");
            if (!$stmt) {
                throw new Exception("Failed to prepare statement: " . $mysqli->error);
            }
            
            $stmt->bind_param('s', $email);
            if (!$stmt->execute()) {
                throw new Exception("Failed to execute statement: " . $stmt->error);
            }
            
            $result = $stmt->get_result();
            
            if ($result->num_rows > 0) {
                // User exists
                $row = $result->fetch_assoc();
                $_SESSION['staff_id'] = $row['staff_id'];
                error_log("Existing user found. Set staff_id = " . $row['staff_id']);
                
                $success = 'Login successful with Google';
                header('Location: ../dashboard.php?success=' . $success);
                exit;
            } else {
                error_log("No existing user found. Creating new account");
                
                // Generate sequential ID starting from 1000000000
                try {
                    // Begin transaction to ensure ID consistency
                    $mysqli->begin_transaction();
                    
                    // Get the current maximum staff_id
                    $maxIdStmt = $mysqli->prepare("SELECT MAX(staff_id) AS max_id FROM bnhs_staff");
                    if (!$maxIdStmt) {
                        throw new Exception("Failed to prepare max ID statement: " . $mysqli->error);
                    }
                    
                    if (!$maxIdStmt->execute()) {
                        throw new Exception("Failed to execute max ID statement: " . $maxIdStmt->error);
                    }
                    
                    $maxIdResult = $maxIdStmt->get_result();
                    $maxIdRow = $maxIdResult->fetch_assoc();
                    $maxId = $maxIdRow['max_id'];
                    
                    // If no records exist yet, start with base ID 1000000000
                    // Otherwise, increment the highest existing ID by 1
                    $nextId = ($maxId === null || $maxId < 2301106000) ? 2301106000 : ($maxId + 1);
                    
                    error_log("Generated sequential ID: $nextId");
                    
                    // Insert the new user with the sequential ID
                    $name = $user_info->name;
                    $defaultPassword = sha1(md5(bin2hex(random_bytes(16)))); // Random secure password
                    
                    error_log("Attempting to insert new user with ID: $nextId, Name: $name, Email: $email");
                    $insertStmt = $mysqli->prepare("INSERT INTO bnhs_staff (staff_id, staff_name, staff_email, staff_password) VALUES (?, ?, ?, ?)");
                    if (!$insertStmt) {
                        throw new Exception("Insert statement preparation failed: " . $mysqli->error);
                    }   
                    
                    $insertStmt->bind_param('ssss', $nextId, $name, $email, $defaultPassword);
                    if (!$insertStmt->execute()) {
                        throw new Exception("Insert statement execution failed: " . $insertStmt->error);
                    }
                    
                    // Commit transaction
                    $mysqli->commit();
                    
                    $_SESSION['staff_id'] = $nextId;
                    // Store success message in session to display alert on dashboard
                    $_SESSION['alert_message'] = "New account created successfully with staff_id: $nextId";
                    
                    $success = 'Login successful with Google';
                    header('Location: ../dashboard.php?success=' . $success);
                    exit;
                    
                } catch (Exception $e) {
                    // Rollback transaction if active
                    try {
                        $mysqli->rollback();
                    } catch (Exception $rollbackEx) {
                        error_log("Rollback failed: " . $rollbackEx->getMessage());
                    }
                    error_log("Error creating account with sequential ID: " . $e->getMessage());
                    
                    // If this is a duplicate key error for email, handle it specially
                    if (strpos($e->getMessage(), 'Duplicate entry') !== false && 
                        strpos($e->getMessage(), 'staff_email') !== false) {
                        // Email constraint violation - handle as if user exists
                        error_log("Duplicate email constraint detected. Fetching existing account.");
                        $findStmt = $mysqli->prepare("SELECT staff_id FROM bnhs_staff WHERE staff_email = ?");
                        $findStmt->bind_param('s', $email);
                        $findStmt->execute();
                        $findResult = $findStmt->get_result();
                        
                        if ($findResult->num_rows > 0) {
                            $findRow = $findResult->fetch_assoc();
                            $_SESSION['staff_id'] = $findRow['staff_id'];
                            error_log("Found existing account on retry. Set staff_id = " . $findRow['staff_id']);
                            
                            $success = 'Login successful with Google';
                            header('Location: ../dashboard.php?success=' . $success);
                            exit;
                        }
                    }
                    
                    throw $e; // Re-throw to be caught by the outer catch block
                }
            }
        } catch (Exception $e) {
            error_log("Error during Google authentication: " . $e->getMessage());
            $err = 'Error processing login: ' . $e->getMessage();
            header('Location: ../index.php?error=' . urlencode($err));
            exit;
        }
    } else {
        error_log("Google token error: " . ($token['error'] ?? 'unknown error'));
        $err = 'Failed to login with Google';
        header('Location: ../index.php?error=' . urlencode($err));
        exit;
    }
} else {
    error_log("No code parameter received from Google");
    $err = 'Invalid Login';
    header('Location: ../index.php?error=' . urlencode($err));
    exit;
}
