<?php
session_start();

// Check for error parameter in URL
if(isset($_GET['error'])) {
    $err = $_GET['error'];
}

include('config/config.php'); // Ensure this file contains a valid $mysqli connection

// Load composer autoloader
require_once __DIR__ . "/assets/vendor/autoload.php";

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . "/assets");
try {
  $dotenv->load();
} catch (Exception $e) {
  die('Error loading .env file. Please ensure it exists in the assets directory.');
}

$sitekey = $_ENV['RECAPTCHA_SITE_KEY'] ?? '';

//login 
if (isset($_POST['login'])) {
  $secretkey = $_ENV['RECAPTCHA_SECRET_KEY'] ?? '';
  $recaptcha_response = $_POST['g-recaptcha-response'] ?? '';

  if (empty($recaptcha_response)) {
    $err = "Please complete the reCAPTCHA verification";
  } else {
    $verify = file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret={$secretkey}&response={$recaptcha_response}");
    $response = json_decode($verify);

    if ($response->success) {
      $staff_email = $_POST['staff_email'];
      $staff_password = sha1(md5($_POST['staff_password'])); //double encrypt to increase security
      $stmt = $mysqli->prepare("SELECT staff_email, staff_password, staff_id FROM bnhs_staff WHERE (staff_email =? AND staff_password =?)");
      $stmt->bind_param('ss', $staff_email, $staff_password);
      $stmt->execute();
      $stmt->bind_result($staff_email, $staff_password, $staff_id);
      $rs = $stmt->fetch();
      $_SESSION['staff_id'] = $staff_id;
      if ($rs) {
        header("location:dashboard.php");
      } else {
        $err = "Incorrect Authentication Credentials";
      }
    } else {
      $err = "reCAPTCHA verification failed. Please try again.";
    }
  }
}
require_once('partials/_inhead.php');
?>

<body>
  <div class="containers">
    <img src="assets/img/brand/bnhs.png" alt="This is a Logo" style="width: 120px; height: auto;" />
    <form method="POST" rule="form">
      <div class="field email-field">
        <div class="input-field">
          <input type="text" placeholder="Email" name="staff_email" required />
        </div>
      </div>
      <div class="field create-password">
        <div class="input-field">
          <input class="username" type="password" placeholder="Password" name="staff_password" required id="passwordField" />
          <img src="assets/img/theme/show.png" id="toggleIcon1" onclick="togglePassword('passwordField', 'toggleIcon1')" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; width: 20px; height: 20px;">
        </div>
      </div>
      <!-- <div class="field">
       
      </div> -->
      <div class="links" style="text-align: end; margin-top: 10px;">
        <a class="password" href="send_code.php">Forgot Password</a>
      </div>
      <div class="g-recaptcha" style="margin-left:15px;" data-sitekey="<?= htmlspecialchars($sitekey); ?>"></div>
      <div class="input-field buttons" style="margin-top: 10px; margin-bottom: 0px;">
        <button type="submit" name="login" style="background-color: #29126d;">LOGIN</button>
      </div>

      <div class="input-field buttons" style="margin-top: 0px; margin-bottom: 5px;">
        <a href="googleAuth/google-login.php" style="display: flex; align-items: center; justify-content: center; width: 100%; background-color: white; color: black; padding: 10px; text-decoration: none; border-radius: 5px; border: 1px solid #b6b7b8; transition: all 0.3s ease;" onmouseover="this.style.backgroundColor='#f8f9fa'; this.style.borderColor='#8d8e8f';" onmouseout="this.style.backgroundColor='white'; this.style.borderColor='#b6b7b8';">
          <img src="assets/img/theme/google-icon.png" alt="Google" style="width: 20px; height: 20px; margin-right: 10px;">
          Sign in with Google
        </a>
      </div>

      <div class="links" style="align-items: center;">
        <p style=>Don't have an account? <a href="create_account.php">Signup</a></p>
      </div>
    </form>
    </div>
  
    <script>
    function togglePassword(fieldId, iconId) {
      const passwordField = document.getElementById(fieldId);
      if (passwordField.type === "password") {
        passwordField.type = "text";
        document.getElementById(iconId).src = "assets/img/theme/hide.png";
      } else {
        passwordField.type = "password";
        document.getElementById(iconId).src = "assets/img/theme/show.png";
      }
    }
  </script>
    <!-- Footer -->
    <?php
    require_once('partials/_footer.php');
    ?>
    <
      </body>

      <!-- Core -->
      <script src="https://www.google.com/recaptcha/api.js" async defer></script>
      <script src="https://accounts.google.com/gsi/client" async defer></script>

      
</html>