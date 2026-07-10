<?php
header("Content-Type: application/json");
include "db.php";

// Ambil data JSON
$data = json_decode(file_get_contents("php://input"), true);

// Ambil input (support JSON & POST)
$nama = $_POST['nama'] ?? ($data['nama'] ?? null);
$email = $_POST['email'] ?? ($data['email'] ?? null);
$password = $_POST['password'] ?? ($data['password'] ?? null);

// Validasi
if (!$nama || !$email || !$password) {
    echo json_encode([
        "status" => "error",
        "message" => "Semua field wajib diisi"
    ]);
    exit;
}

// Cek email sudah ada atau belum
$check = $conn->query("SELECT * FROM users WHERE email='$email'");

if ($check->num_rows > 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Email sudah terdaftar"
    ]);
    exit;
}

// Default role = customer
$role = "customer";

// Simpan ke database
$sql = "INSERT INTO users (nama, email, password, role)
        VALUES ('$nama', '$email', '$password', '$role')";

if ($conn->query($sql)) {
    echo json_encode([
        "status" => "success",
        "message" => "Registrasi berhasil"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Gagal register"
    ]);
}
?>