<?php 
// Load composer autoloader
require_once __DIR__ . "/../assets/vendor/autoload.php";

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . "/../assets");
$dotenv->load();


$client = new Google_Client();
$client->setClientId($_ENV['GOOGLE_CLIENT_ID']);
$client->setClientSecret($_ENV['GOOGLE_CLIENT_SECRET']);
$client->setRedirectUri($_ENV['GOOGLE_REDIRECT']);
$client->addScope('email');
$client->addScope('profile');

$oauth2 = new Google\Service\Oauth2($client);

header('Location: ' . $client->createAuthUrl());

exit();

?>