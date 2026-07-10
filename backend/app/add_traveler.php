<?php

header("Content-Type: application/json");

include "db.php";

$nama = $_POST["nama"] ?? "";

$email = $_POST["email"] ?? "";

$password = $_POST["password"] ?? "";

if (

    empty($nama) ||
    empty($email) ||
    empty($password)

) {

    echo json_encode([

        "status" => "error",

        "message" => "Semua field wajib diisi"
    ]);

    exit;
}

$check = mysqli_query(

    $conn,

    "SELECT * FROM users

     WHERE email='$email'"
);

if (mysqli_num_rows($check) > 0) {

    echo json_encode([

        "status" => "error",

        "message" => "Email sudah digunakan"
    ]);

    exit;
}

$sql = "INSERT INTO users (

            nama,
            email,
            password,
            role

        )

        VALUES (

            '$nama',
            '$email',
            '$password',
            'traveler'
        )";

if ($conn->query($sql)) {

    echo json_encode([

        "status" => "success",

        "message" => "Traveler berhasil ditambahkan"
    ]);

} else {

    echo json_encode([

        "status" => "error",

        "message" => $conn->error
    ]);
}
?>