<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$id = $_POST['id'] ?? '';
$metode = trim($_POST['metode_pembayaran'] ?? '');
$nomor = trim($_POST['nomor_rekening'] ?? '');
$atasNama = trim($_POST['atas_nama'] ?? '');

// Validasi input
if (empty($id) || empty($metode) || empty($nomor) || empty($atasNama)) {
    echo json_encode([
        "status" => "error",
        "message" => "Semua field wajib diisi."
    ]);
    exit;
}

// Cek apakah metode pembayaran sudah digunakan oleh data lain
$cek = mysqli_prepare(
    $conn,
    "SELECT id
     FROM rekening_pembayaran
     WHERE metode_pembayaran = ?
       AND id != ?
       AND is_active = 1"
);

mysqli_stmt_bind_param($cek, "si", $metode, $id);
mysqli_stmt_execute($cek);
mysqli_stmt_store_result($cek);

if (mysqli_stmt_num_rows($cek) > 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Metode pembayaran sudah tersedia."
    ]);
    exit;
}

// Update data
$stmt = mysqli_prepare(
    $conn,
    "UPDATE rekening_pembayaran
     SET
        metode_pembayaran = ?,
        nomor_rekening = ?,
        atas_nama = ?
     WHERE id = ?"
);

mysqli_stmt_bind_param(
    $stmt,
    "sssi",
    $metode,
    $nomor,
    $atasNama,
    $id
);

if (mysqli_stmt_execute($stmt)) {

    echo json_encode([
        "status" => "success",
        "message" => "Berhasil mengubah metode pembayaran."
    ]);

} else {

    echo json_encode([
        "status" => "error",
        "message" => "Gagal mengubah metode pembayaran."
    ]);

}

mysqli_stmt_close($stmt);
mysqli_close($conn);