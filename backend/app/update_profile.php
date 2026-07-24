<?php

include "db.php";

$id    = $_POST['id'] ?? "";
$nama  = trim($_POST['nama'] ?? "");
$no_hp = trim($_POST['no_hp'] ?? "");

if ($id == "" || $nama == "") {
    echo json_encode([
        "status" => "error",
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

$sql = "UPDATE users
        SET nama = ?, no_hp = ?
        WHERE id = ?";

$stmt = mysqli_prepare($conn, $sql);

mysqli_stmt_bind_param(
    $stmt,
    "ssi",
    $nama,
    $no_hp,
    $id
);

if (mysqli_stmt_execute($stmt)) {

    echo json_encode([
        "status" => "success",
        "message" => "Profil berhasil diperbarui"
    ]);

} else {

    echo json_encode([
        "status" => "error",
        "message" => "Gagal memperbarui profil"
    ]);
}