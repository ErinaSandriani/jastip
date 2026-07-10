<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include "db.php";

// Ambil data dari JSON (API)
$data = json_decode(
    file_get_contents("php://input"),
    true
);

// Ambil juga dari POST
$email =
    $_POST['email']
    ?? ($data['email'] ?? null);

$password =
    $_POST['password']
    ?? ($data['password'] ?? null);

// Validasi input
if (
    !$email ||
    !$password
) {

    echo json_encode([

        "status" => "error",

        "message" =>
            "Email dan password wajib diisi"
    ]);

    exit;
}

// Query database
$sql =
    "SELECT * FROM users
     WHERE email='$email'
     AND password='$password'";

$result =
    $conn->query($sql);

// Cek hasil login
if (
    $result &&
    $result->num_rows > 0
) {

    $user =
        $result->fetch_assoc();

    echo json_encode([

        "status" => "success",

        "role" => $user['role'],

        "user" => [

            "id" =>
                $user['id'],

            "nama" =>
                $user['nama'],

            "email" =>
                $user['email'],

            "role" =>
                $user['role']
        ]
    ]);

} else {

    echo json_encode([

        "status" => "error",

        "message" =>
            "Login gagal"
    ]);
}
?>