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

$data = json_decode(
    file_get_contents("php://input"),
    true
);

$email =
    $_POST["email"]
    ?? ($data["email"] ?? "");

$password =
    $_POST["password"]
    ?? ($data["password"] ?? "");

if (empty($email) || empty($password)) {

    echo json_encode([
        "status" => "error",
        "message" => "Email dan password wajib diisi."
    ]);

    exit;
}

$stmt = $conn->prepare(

"SELECT * FROM users

WHERE email=?"

);

$stmt->bind_param("s",$email);

$stmt->execute();

$result = $stmt->get_result();

if($result->num_rows==0){

    echo json_encode([

        "status"=>"error",

        "message"=>"Email tidak ditemukan."
    ]);

    exit;
}

$user = $result->fetch_assoc();

$passwordBenar = false;

/*
|--------------------------------------------------------------------------
| Support akun lama (plain text)
|--------------------------------------------------------------------------
*/

if($user["password"] == $password){

    $passwordBenar = true;
}

/*
|--------------------------------------------------------------------------
| Support akun baru (password_hash)
|--------------------------------------------------------------------------
*/

if(password_verify(
    $password,
    $user["password"]
)){

    $passwordBenar = true;
}

if(!$passwordBenar){

    echo json_encode([

        "status"=>"error",

        "message"=>"Password salah."
    ]);

    exit;
}

/*
|--------------------------------------------------------------------------
| Traveler harus approved
|--------------------------------------------------------------------------
*/

if($user["role"]=="traveler"){

    if($user["status_verifikasi"]=="pending"){

        echo json_encode([

            "status"=>"error",

            "message"=>"Akun Traveler masih menunggu persetujuan Admin."
        ]);

        exit;
    }

    if($user["status_verifikasi"]=="rejected"){

        echo json_encode([

            "status"=>"error",

            "message"=>"Pendaftaran Traveler ditolak Admin."
        ]);

        exit;
    }
}

/*
|--------------------------------------------------------------------------
| Login Success
|--------------------------------------------------------------------------
*/

echo json_encode([

    "status"=>"success",

    "role"=>$user["role"],

    "user"=>[

        "id"=>$user["id"],

        "nama"=>$user["nama"],

        "email"=>$user["email"],

        "role"=>$user["role"]
    ]
]);