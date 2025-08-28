<?php
session_start();
include('config/config.php'); // Ensure this file contains a valid $mysqli connection

if (isset($_POST['add'])) {
  // Prevent Posting Blank Values
  if ($_POST['staff_password'] !== $_POST['staff_pass_confirm']) {
    $err = "Password doesn't match.";
  } elseif (strlen($_POST['staff_password']) < 8) { // Validate password length
    $err = "Password must be at least 8 characters long.";
  } elseif (!preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])/', $_POST['staff_password'])) {
    $err = "Password must include uppercase, lowercase, number, and special character.";
  } else {
    $staff_name = $_POST['staff_name'];
    $staff_email = $_POST['staff_email'];
    $staff_password = sha1(md5($_POST['staff_password'])); // Hash This
    $staff_id = $_POST['staff_id'];

    $stmt = $pdo->prepare("SELECT * FROM bnhs_staff WHERE staff_email = ?");
    $stmt->execute([$staff_email]);

    if ($stmt->rowCount() > 0) {
      $err = "Email is already exist";
    }
    // Insert Captured Information into the Database Table
    $postQuery = "INSERT INTO bnhs_staff (staff_id, staff_name, staff_email, staff_password) VALUES(?,?,?,?)";
    $postStmt = $mysqli->prepare($postQuery);

    if ($postStmt) {
      // Bind Parameters
      $rc = $postStmt->bind_param('ssss', $staff_id, $staff_name, $staff_email, $staff_password);

      // Execute the Query
      if ($postStmt->execute()) {
        $success = "staff Account Created Successfully";
        header("refresh:1; url=index.php");
      } else {
        $err = "Error: " . $postStmt->error; // Debugging: Show SQL error
      }
    } else {
      $err = "Error: " . $mysqli->error; // Debugging: Show SQL preparation error
    }
  }
}
require_once('partials/_inhead.php');
require_once('config/code-generator.php');
?>

<style>
  .input-fields {
    position: relative;
  }
</style>

<body>
  <div class="containers">
    <img src="assets/img/brand/bnhs.png" alt="This is a Logo" style="width: 120px; height: auto;">
    <form method="POST" rule="form">
      <div class="field">
        <div class="input-fields" style="">
          <input type="text" placeholder="ID" name="staff_id" required>
          <!-- <input class="form-control" value="<?php echo $cus_id; ?>" required name="staff_id"  type="hidden"> -->
        </div>
      </div>
      <div class="field">
        <div class="input-fields">
          <input type="text" placeholder="Full Name" name="staff_name" required>
          <!-- <input class="form-control" value="<?php echo $cus_id; ?>" required name="staff_id"  type="hidden"> -->
        </div>
      </div>
      <div class="field">
        <div class="input-fields">
          <input type="email" placeholder="Email" name="staff_email" required>
        </div>
      </div>
      <div class="field">
        <div class="input-fields">
          <input type="password" placeholder="Password" name="staff_password" id="passwordField" required>
          <img src="assets/img/theme/show.png" id="toggleIcon1" onclick="togglePassword('passwordField', 'toggleIcon1')" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; width: 20px; height: 20px;">
        </div>
      </div>
      <div class="field">
        <div class="input-fields">
          <input type="password" placeholder="Confirm Password" name="staff_pass_confirm" id="confirmPasswordField" required>
          <img src="assets/img/theme/show.png" id="toggleIcon2" onclick="togglePassword('confirmPasswordField', 'toggleIcon2')" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; width: 20px; height: 20px;">
        </div>
      </div>
      <div class="input-field buttons">
        <button type="submit" name="add" style="background-color: #29126d">SIGNUP</button>
      </div>
      <div class="links">
        <p style="margin-bottom: 0px;">Already have an account? <a href="index.php">Login</a></p>
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
<footer class="text-muted fixed-bottom mb-4">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-md-6 text-left text-md-start">
        &copy; 2024 - <?php echo date('Y'); ?> - Developed By SOVATECH Company
      </div>
      <div class="col-md-6 text-right text-md-end">
        <a href="#" class="nav-link" target="_blank"> BNHS INVENTORY SYSTEM</a>
      </div>
    </div>
  </div>
</footer>


</html>