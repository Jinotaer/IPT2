<?php
session_start();
include('config/config.php'); // Ensure this file contains a valid $mysqli connection


if (isset($_POST['change_password']) && isset($_SESSION['verified_email'])) {
    if (empty($_POST['new_password']) || empty($_POST['confirm_password'])) {
        $err = "All fields are required.";
    } elseif (strlen($_POST['new_password']) < 8) {
        $err = "Password must be at least 8 characters long.";
    } elseif ($_POST['new_password'] !== $_POST['confirm_password']) {
        $err = "Passwords do not match.";
    } else {
        $email = $_SESSION['verified_email'];
        $new_password = sha1(md5($_POST['new_password'])); // Hash the password

        $updateQuery = "UPDATE bnhs_staff SET staff_password = ? WHERE staff_email = ?";
        $updateStmt = $mysqli->prepare($updateQuery);

        if ($updateStmt) {
            $updateStmt->bind_param('ss', $new_password, $email);

            if ($updateStmt->execute()) {
             
                // Password updated, remove verification session
                unset($_SESSION['verified_email']);
                $success = "Password updated successfully.";
                // Redirect to login page 
                $success = "Password updated successfully.";
                header("Location: index.php");
            } else {
                $err = "Error: " . $updateStmt->error;
            }
        } else {
            $err = "Error: " . $mysqli->error;
        }
    }
}
require_once('partials/_inhead.php');
?>

<body>
  <div class="containers">
    <img src="assets/img/brand/bnhs.png" alt="This is a Logo" style="width: 150px; height: auto; margin-bottom: 40px">
    <form method="POST" rule="form">
      <div class="field create-password">
        <div class="input-field">
          <input class="username" type="password" placeholder="New Password" name="new_password" id="newPasswordField" required />
          <img src="assets/img/theme/show.png" id="toggleIcon1" onclick="togglePassword('newPasswordField', 'toggleIcon1')" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; width: 20px; height: 20px;">
          </div>
      </div>

      <div class="field create-password">
        <div class="input-field">
          <input class="username" type="password" placeholder="Confirm Password" name="confirm_password" id="confirmPasswordField" required />
          <img src="assets/img/theme/show.png" id="toggleIcon2" onclick="togglePassword('confirmPasswordField', 'toggleIcon2')" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; width: 20px; height: 20px;">
          </div>
      </div>
      
      <div class="input-field buttons">
        <button type="submit" name="change_password" style="background-color: #29126d">CHANGE PASSWORD</button>
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
</body>
<footer class="text-muted fixed-bottom mb-5">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-md-6 text-left text-md-start">
        &copy; 2024 - <?php echo date('Y'); ?> - Developed By SOVATECH Company
      </div>
      <div class="col-md-6 text-right text-md-end">
        <a href="#" class="nav-link" target="_blank">BNHS INVENTORY SYSTEM</a>
      </div>
    </div>
  </div>
</footer>