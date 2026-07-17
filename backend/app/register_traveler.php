<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';
$email    = $_POST['email'] ?? '';
$nama     = $_POST['nama'] ?? '';
$alamat   = $_POST['alamat'] ?? '';
$no_hp    = $_POST['no_hp'] ?? '';

if (
    empty($username) ||
    empty($password) ||
    empty($email) ||
    empty($nama) ||
    empty($alamat) ||
    empty($no_hp)
) {

    echo json_encode([
        "status" => "error",
        "message" => "Semua data wajib diisi."
    ]);
    exit;
}

// cek email
$cek = $conn->prepare(
    "SELECT id FROM users WHERE email=?"
);

$cek->bind_param("s",$email);
$cek->execute();
$result = $cek->get_result();

if($result->num_rows > 0){

    echo json_encode([
        "status"=>"error",
        "message"=>"Email sudah digunakan."
    ]);

    exit;
}

$passwordHash = password_hash(
    $password,
    PASSWORD_DEFAULT
);

$stmt = $conn->prepare(

"INSERT INTO users
(
username,
password,
email,
nama,
role,
alamat,
no_hp,
status_verifikasi
)

VALUES
(
?,
?,
?,
?,
'traveler',
?,
?,
'pending'
)"

);

$stmt->bind_param(

"ssssss",

$username,

$passwordHash,

$email,

$nama,

$alamat,

$no_hp

);

if($stmt->execute()){

    echo json_encode([

        "status"=>"success",

        "message"=>"Pendaftaran traveler berhasil. Tunggu persetujuan admin."
    ]);

}else{

    echo json_encode([

        "status"=>"error",

        "message"=>"Pendaftaran gagal."
    ]);
}